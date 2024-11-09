
import 'package:flutter/material.dart';
import 'package:videosdk/videosdk.dart';

class CallScreen extends StatefulWidget {
 // final bool isDoctor;

  const CallScreen({super.key, });

  @override
  State<CallScreen> createState() => _CallScreenState();
}

class _CallScreenState extends State<CallScreen> {

  late Room _room;
  bool micEnabled = true;
  bool camEnabled = true;
  String meetingId = "3olc-wwhx-aghi";
  String token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhcGlrZXkiOiIyYmNhN2IwYS03MGZiLTRkMGUtOGU1ZC1hOWYzZGQ5ZmVlMDkiLCJwZXJtaXNzaW9ucyI6WyJhbGxvd19qb2luIl0sImlhdCI6MTczMTA0NDExNiwiZXhwIjoxNzQ2NTk2MTE2fQ.ISjq5oGZUSpiQNTu0_cAEX3G0-lxx9z4UnC23Hi0ofE";

  Map<String, Participant> participants = {};

  @override
  void initState() {
    super.initState();

    _room = VideoSDK.createRoom(
      roomId: meetingId,
      token: token,
      displayName: "Patient",
      micEnabled: micEnabled,
      camEnabled: camEnabled,
      defaultCameraIndex: 1,
    );

    // Event listeners and join room
    setMeetingEventListener();
    _room.join();
  }


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
        setState(
              () => participants.putIfAbsent(participant.id, () => participant),
        );
      },
    );

    _room.on(Events.participantLeft, (String participantId) {
      if (participants.containsKey(participantId)) {
        setState(
              () => participants.remove(participantId),
        );
      }
    });

    _room.on(Events.roomLeft, () {
      participants.clear();
      Navigator.popUntil(context, ModalRoute.withName('/'));
    });
  }


  Future<bool> _onWillPop() async {
    _room.leave();
    return true;
  }
  @override
  Widget build(BuildContext context) {
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
              width: 100,
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
              child: MeetingControls(
                onToggleMicButtonPressed: () {
                  micEnabled ? _room.muteMic() : _room.unmuteMic();
                  setState(() => micEnabled = !micEnabled);
                },
                onToggleCameraButtonPressed: () {
                  camEnabled ? _room.disableCam() : _room.enableCam();
                  setState(() => camEnabled = !camEnabled);
                },
                onLeaveButtonPressed: () {
                  _room.leave();
                },
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