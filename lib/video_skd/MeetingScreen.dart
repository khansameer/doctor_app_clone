import 'dart:convert';

import 'package:doctor_app/core/common/common_button_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:videosdk/videosdk.dart';
import 'MeetingControls.dart';
import 'ParticipantTile.dart';
import 'package:http/http.dart' as http;
class MeetingScreenSS extends StatefulWidget {
  final String meetingId;
  final String token;

  const MeetingScreenSS(
      {super.key, required this.meetingId, required this.token});

  @override
  State<MeetingScreenSS> createState() => _MeetingScreenState();
}

class _MeetingScreenState extends State<MeetingScreenSS> {
  late Room _room;
  var micEnabled = true;
  var camEnabled = true;
  String? participantID;

  Map<String, Participant> participants = {};

  @override
  void initState() {
    // create room
    _room = VideoSDK.createRoom(
        roomId: widget.meetingId,
        token: widget.token,
        displayName: "John Doe",
        micEnabled: micEnabled,
        camEnabled: camEnabled
    );

    setMeetingEventListener();

    // Join room
    _room.join();

    super.initState();
  }

  // listening to meeting events
  void setMeetingEventListener() {
    _room.on(Events.roomJoined, () {
      setState(() {
        participants.putIfAbsent(
            _room.localParticipant.id, () => _room.localParticipant);
      });
    });

    _room.on(
      Events.participantJoined,
          (Participant participant) {

        setState(() {
          print('====participantID===${participant.id}');

          participantID=participant.id;
          participants.putIfAbsent(participant.id, () => participant);
          print('====participantID===${participantID}');
          print('====participantID===${participant.id}');
        });
        /*setState(
              () => participants.putIfAbsent(participant.id, () => participant),
        );*/
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


        _room.startRecording(config: config,postTranscriptionConfig: PostTranscriptionConfig(enabled: true,
            summaryConfig: SummaryConfig(enabled: true, prompt: "Write summary in sections like Title, Agenda, Speakers, Action Items, Outlines, Notes and Summary")));
           // startTrackRecording();
      },
    );

    _room.on(Events.participantLeft, (String participantId) {
      if (participants.containsKey(participantId)) {
        setState(
              () => participants.remove(participantId),

        );
       _room.stopRecording();
       // _room.stopTranscription();
        stopTrackRecording();
      }
    });

    _room.on(Events.roomLeft, () {
      participants.clear();
      _room.stopRecording();
      _room.stopTranscription();
     // Navigator.popUntil(context, ModalRoute.withName('/'));
    });
  }
  Future<void> startTrackRecording() async {
    final String roomId = widget.meetingId;
    final String participantId = participants[0]?.id ?? '';

    final Map<String, dynamic> body = {
      "roomId": roomId,
      "participantId": participantId,

    };

    final response = await http.post(
      Uri.parse(
          'https://api.videosdk.live/v2/recordings/participant/start'),
      headers: {
        "Authorization": widget.token,
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
    final String roomId = widget.meetingId;
    final String participantId = participants[0]?.id ?? '';


    final Map<String, dynamic> body = {
      "roomId": roomId,
      "participantId": participantId,

    };

    final response = await http.post(
      Uri.parse(
          'https://api.videosdk.live/v2/recordings/participant/stop'),
      headers: {
        "Authorization": widget.token,
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


  Future<void> getTrackRecording() async {


    print('==participantId=====${participantID}');
    final response = await http.get(
      Uri.parse(
          'https://api.videosdk.live/v2/recordings/participant/$participantID'),
      headers: {
        "Authorization": widget.token,
        "Content-Type": "application/json",
      },
     /* body: jsonEncode(body),*/
    );
    print("==========+End${response.body}");
    if (response.statusCode == 200) {
      // print(jsonDecode(response.body));

    } else {
      print('Failed to stop track recording');
    }
  }
  // onbackButton pressed leave the room
  Future<bool> _onWillPop() async {
    _room.leave();
    return true;
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _onWillPop(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('VideoSDK QuickStart Clone'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text(widget.meetingId),
              //render all participant
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      mainAxisExtent: 300,
                    ),
                    itemBuilder: (context, index) {
                      return ParticipantTileSS(
                          key: Key(participants.values.elementAt(index).id),
                          participant: participants.values.elementAt(index));
                    },
                    itemCount: participants.length,
                  ),
                ),
              ),

              CommonButtonWidget(text: "get",onPressed: (){
                getTrackRecording();
              },),
              MeetingControlsss(
                onToggleMicButtonPressed: () {
                  micEnabled ? _room.muteMic() : _room.unmuteMic();
                  micEnabled = !micEnabled;
                },
                onToggleCameraButtonPressed: () {
                  camEnabled ? _room.disableCam() : _room.enableCam();
                  camEnabled = !camEnabled;
                },
                onLeaveButtonPressed: () {
                  _room.leave();
                },
              ),
            ],
          ),
        ),
      ),

    );
  }
}