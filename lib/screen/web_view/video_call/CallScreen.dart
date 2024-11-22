import 'dart:developer';
import 'package:doctor_app/core/common/common_text_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:speech_to_text/speech_to_text.dart';

import 'package:videosdk/videosdk.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

class CallScreen extends StatefulWidget {
  // final bool isDoctor;

  const CallScreen({super.key, required this.meetingId});

  final String meetingId;
  @override
  State<CallScreen> createState() => _CallScreenState();
}

class _CallScreenState extends State<CallScreen> {

  bool isRoomInitialized = false;
  late Room _room;
  List<String> _transcriptionList = [];
  bool _isListening = false;
  bool micEnabled = true;
  bool camEnabled = true;
  int currentCameraIndex = 1; // 1 for front camera, 0 for back camera
  String meetingId = "3olc-wwhx-aghi";
  String token =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhcGlrZXkiOiIyYmNhN2IwYS03MGZiLTRkMGUtOGU1ZC1hOWYzZGQ5ZmVlMDkiLCJwZXJtaXNzaW9ucyI6WyJhbGxvd19qb2luIl0sImlhdCI6MTczMTgzMjAwOSwiZXhwIjoxNzQ3Mzg0MDA5fQ.TYhJymQVwYDs8MaK1bpAMXzi4J9x8znJCYl0Mvpj3iY";

  Map<String, Participant> participants = {};


  Future<void> requestPermissions() async {
    await [
      Permission.camera,
      Permission.microphone,
    ].request();
    try {
      //By default both audio and video permissions will be requested.
      Map<String, bool>? reqAudioVideoPermissions =
      await VideoSDK.requestPermissions(Permissions.audio_video);
      //For requesting just audio permission.
      Map<String, bool>? reqAudioPermissions =
      await VideoSDK.requestPermissions(Permissions.audio);
      //For requesting just video permission.

      Map<String, bool>? reqVideoPermissions1 =
      await VideoSDK.requestPermissions(Permissions.video);
      //For requesting both audio and video permissions.
      // Map<String, bool>? reqAudioVideoPermissions = await VideoSDK.requestPermissions(Permissions.audio_video);
    } catch (ex) {
      print("Error in requestPermission ");
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _room.leave();

  }
  final SpeechToText _speechToText = SpeechToText();
  String _transcriptionText = "";


  @override
  void initState() {
    super.initState();
    initRoom();


  }

  void initRoom(){
    requestPermissions().then((_) async {
      CustomTrack audioTrack = await VideoSDK.createMicrophoneAudioTrack(
          microphoneId : 'mic-id', // OPTIONAL
          noiseConfig: {
            // It is used to improve the quality of audio by removing background noise
            // that can interfere with the clarity of speech.
            "noiseSuppression": true,

            // It is used to remove unwanted echoes from voice.
            "echoCancellation": true,

            // It is used to maintain a consistent level of loudness or amplitude in a voice.
            "autoGainControl": true,
          },
          encoderConfig: CustomAudioTrackConfig.speech_standard);
      fetchCameras();
      print('=-======docorRoomID${meetingId}');
      //_startListening();
      _room = VideoSDK.createRoom(
        roomId: meetingId,
        token: token,
        displayName: "Patient",
        micEnabled: micEnabled,
        camEnabled: camEnabled,
        defaultCameraIndex: kIsWeb ? 0 : 1,
        customMicrophoneAudioTrack: audioTrack,

        // defaultCameraIndex: 1,

      );
      isRoomInitialized = true; // Mark as initialized
      // Event listeners and join room
      setMeetingEventListener();
      _room.join();

      initializeSpeechToText();
    });
  }
  Future<void> initializeSpeechToText() async {
    bool available = await _speechToText.initialize();
    if (!available) {
      print("Speech recognition not available");
    }
  }

  void startListening() {
    if (!_speechToText.isListening) {
      setState(() {
        _isListening = true;
      });
      _speechToText.listen(onResult: (result) {
        setState(() {
          if (result.recognizedWords.isNotEmpty) {
            _transcriptionList.add(result.recognizedWords); // Add to list
          }
          _transcriptionText += "${result.recognizedWords}\n";
        });
      });
    }
  }

  void stopListening() {
    if (_speechToText.isListening) {
      _speechToText.stop();
      setState(() {
        _isListening = false;
      });
      // Show dialog with the recorded texts
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Recorded Texts"),
          content: _transcriptionList.isEmpty
              ? Text("No text recorded.")
              : Column(
            mainAxisSize: MainAxisSize.min,
            children: _transcriptionList
                .map((text) => Text("- $text")) // Display each entry
                .toList(),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Close"),
            ),
          ],
        ),
      );
    }
  }
  List<VideoDeviceInfo>? cameras = [];
  void fetchCameras() async {
    cameras = await VideoSDK.getVideoDevices();
    setState(() {});
  }

  void setMeetingEventListener() {

    _room.on(Events.roomJoined, () {
      setState(() {
        participants[_room.localParticipant.id] = _room.localParticipant;
      });
    });
    _room.on(Events.recordingStateChanged, (String status) {

      log("Meeting Recording status : $status");
    });
    _room.on(Events.recordingStopped, (String status) {

      log("Meeting Recording status : $status");
    });

    _room.on(Events.transcriptionStateChanged, (Map<String, dynamic> data) {
      log("Meeting transcription status : ${data['status']}");
    });

// Listen for transcription text event
    _room.on(Events.transcriptionText, (Map<String, dynamic> data) {
      log("${data['participantName']}: ${data['text']} ${data['timestamp']}");
    });

    _room.on(Events.participantJoined, (Participant participant) {
      setState(() {
        participants[participant.id] = participant;

        Map<String, dynamic> config = {
          "layout": {
            "type": "GRID",
            "priority": "SPEAKER",
            "gridSize": 4,
          },
          "theme": "DARK",
          "mode": "audio",
          "quality": "high",
          "orientation": "portrait",
        };



        startListening();
      });
    });

    _room.on(Events.participantLeft, (String participantId) {
      if (participants.containsKey(participantId)) {
        setState(() {
          String displayName =
              participants[participantId]?.displayName ?? "Unknown";
          participants.remove(participantId);
          //_room.stopRecording();
          _room.stopTranscription();
          //_stopListening();
          stopListening();
        });
      }
    });

    _room.on(Events.roomLeft, () {
      setState(() {
        participants.clear();
      });
      Navigator.of(context).pop();
    });
  }

  Future<bool> _onWillPop() async {
    _room.leave();
    Navigator.of(context).pop();
    return true;
  }

  Future<void> startTrackRecording() async {
    final String roomId = meetingId;
    final String participantId = participants[0]?.id ?? '';
    final String kind = "audio";
    final String webhookUrl = "participant-track-recording-starting";
    CustomTrack audioTrack = await VideoSDK.createMicrophoneAudioTrack(
        microphoneId : 'mic-id', // OPTIONAL
        noiseConfig: {
          // It is used to improve the quality of audio by removing background noise
          // that can interfere with the clarity of speech.
          "noiseSuppression": true,

          // It is used to remove unwanted echoes from voice.
          "echoCancellation": true,

          // It is used to maintain a consistent level of loudness or amplitude in a voice.
          "autoGainControl": true,
        },
        encoderConfig: CustomAudioTrackConfig.speech_standard);

    final Map<String, dynamic> body = {
      "roomId": roomId,
      "participantId": participantId,

    };

    final response = await http.post(
      Uri.parse(
          'https://api.videosdk.live/v2/recordings/participant/start'),
      headers: {
        "Authorization": token,
        "Content-Type": "application/json",
      },
      body: jsonEncode(body),
    );

    print('==code==${response.statusCode}');
    if (response.statusCode == 200) {
      print("==========+CallStart${jsonDecode(response.body)}");
    } else {
      print('Failed to start track recording');
    }
  }

  Future<void> stopTrackRecording() async {
    final String roomId = meetingId;
    final String participantId = participants[0]?.id ?? '';
    final String kind = "audio";

    final Map<String, dynamic> body = {
      "roomId": roomId,
      "participantId": participantId,
      "kind": kind,
    };

    final response = await http.post(
      Uri.parse(
          'https://api.videosdk.live/v2/recordings/participant/stop'),
      headers: {
        "Authorization": token,
        "Content-Type": "application/json",
      },
      body: jsonEncode(body),
    );

    if (response.statusCode == 200) {
      // print(jsonDecode(response.body));
      print("==========+End${jsonDecode(response.body)}");
    } else {
      print('Failed to stop track recording');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!isRoomInitialized) {
      return Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: CircularProgressIndicator(), // Show loading state
        ),
      );
    }
    final localParticipant = _room.localParticipant;

    return WillPopScope(
      onWillPop: () => _onWillPop(),
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          children: [
            // Full-screen view for the main participant
            Positioned.fill(
              child: _room.participants.isNotEmpty
                  ? ParticipantTile(
                participant: _room.participants.values.first,
              )
                  : Center(child: CircularProgressIndicator()),
            ),
            // PIP view for the local participant
            Positioned(
              top: 16,
              left: 16,
              width: 150,
              height: 150,
              child: ParticipantTile(
                key: Key(localParticipant.id),
                participant: localParticipant,
              ),
            ),
            // Meeting controls at the bottom

            Positioned(
              bottom: 16,
              left: 0,
              right: 0,
              child: Column(
                children: [

                  Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.black54,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    height: 50,
                    child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,

                        child:Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CommonTextWidget(
                              text: _transcriptionText,
                            ),
                          ],
                        )
                    ),
                  ),

                  MeetingControls(
                    onToggleMicButtonPressed: () {

                      micEnabled ? _room.muteMic() : _room.unmuteMic();
                      setState(() => micEnabled = !micEnabled);
                    },
                    onToggleCameraButtonPressed: () {
                      stopListening();
                      camEnabled ? _room.disableCam() : _room.enableCam();
                      //   camEnabled = !camEnabled;
                      setState(() => camEnabled = !camEnabled);
                    },
                    onLeaveButtonPressed: () {
                      //   Navigator.of(context).pop();
                      _room.end();


                    },
                  ),



                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Meeting controls widget
class MeetingControls extends StatelessWidget {
  final void Function() onToggleMicButtonPressed;
  final void Function() onToggleCameraButtonPressed;
  final void Function() onLeaveButtonPressed;

  const MeetingControls({
    super.key,
    required this.onToggleMicButtonPressed,
    required this.onToggleCameraButtonPressed,
    required this.onLeaveButtonPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        commButton(
          icon: Icons.cameraswitch,
          onTap: onToggleCameraButtonPressed,
        ),
        SizedBox(width: 20),
        commButton(
          icon: Icons.mic_none_rounded,
          onTap: onToggleMicButtonPressed,
        ),
        SizedBox(width: 20),
        commButton(
          icon: Icons.call_end,
          colorBg: Colors.red,
          colorButton: Colors.white,
          onTap: onLeaveButtonPressed,
        ),
      ],
    );
  }

  Widget commButton({
    IconData? icon,
    VoidCallback? onTap,
    Color? colorBg,
    Color? colorButton,
  }) {
    return Container(
      width: 60,
      decoration: BoxDecoration(
        color: colorBg ?? Colors.white,
        shape: BoxShape.circle,
      ),
      height: 60,
      child: Center(
        child: IconButton(
          onPressed: onTap,
          icon: Icon(
            icon ?? Icons.camera,
            color: colorButton ?? Colors.grey,
          ),
        ),
      ),
    );
  }
}

// Participant tile widget
class ParticipantTile extends StatefulWidget {
  final Participant participant;

  const ParticipantTile({super.key, required this.participant});

  @override
  State<ParticipantTile> createState() => _ParticipantTileState();
}

class _ParticipantTileState extends State<ParticipantTile> {
  Stream? videoStream;

  @override
  void initState() {
    super.initState();
    widget.participant.streams.forEach((key, Stream stream) {
      if (stream.kind == 'video') {
        setState(() {
          videoStream = stream;
        });
      }
    });
    _initStreamListeners();
  }

  void _initStreamListeners() {
    widget.participant.on(Events.streamEnabled, (Stream stream) {
      if (stream.kind == 'video') {
        setState(() => videoStream = stream);
      }
    });

    widget.participant.on(Events.streamDisabled, (Stream stream) {
      if (stream.kind == 'video') {
        setState(() => videoStream = null);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: videoStream != null
          ? RTCVideoView(
        videoStream?.renderer as RTCVideoRenderer,
        objectFit: RTCVideoViewObjectFit.RTCVideoViewObjectFitCover,
      )
          : Container(
        color: Colors.grey.shade800,
        child: const Center(
          child: Icon(
            Icons.person,
            size: 100,
          ),
        ),
      ),
    );
  }
}
