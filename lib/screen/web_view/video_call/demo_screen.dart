import 'package:flutter/material.dart';
import 'package:videosdk/videosdk.dart';

class DemoScreen extends StatefulWidget {
  const DemoScreen({super.key});

  @override
  State<DemoScreen> createState() => _DemoScreenState();
}

class _DemoScreenState extends State<DemoScreen> {
  late Room _room;
  var micEnabled = true;
  Mode mode=Mode.CONFERENCE;
  String meetingId = "3olc-wwhx-aghi";
  String token =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhcGlrZXkiOiIyYmNhN2IwYS03MGZiLTRkMGUtOGU1ZC1hOWYzZGQ5ZmVlMDkiLCJwZXJtaXNzaW9ucyI6WyJhbGxvd19qb2luIl0sImlhdCI6MTczMTA0NDExNiwiZXhwIjoxNzQ2NTk2MTE2fQ.ISjq5oGZUSpiQNTu0_cAEX3G0-lxx9z4UnC23Hi0ofE";

  var camEnabled = true;
  Map<String, Participant> participants = {};

  @override
  void initState() {
    // create room
    _room = VideoSDK.createRoom(
      roomId: meetingId,
      token: token,
      displayName: "John Doe",
      multiStream: false,
      mode: mode,
      micEnabled: micEnabled,
      camEnabled: camEnabled,
      defaultCameraIndex: 1,
    );

    setMeetingEventListener();

    // Join room
    _room.join();

    super.initState();
  }
/*
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
  }*/
  void setMeetingEventListener() {
    _room.on(Events.roomJoined, () {
      setState(() {
        participants.putIfAbsent(
          _room.localParticipant.id,
              () => _room.localParticipant,
        );
      });
    });

    _room.on(Events.participantJoined, (Participant participant) {
      setState(() {
        participants.putIfAbsent(participant.id, () => participant);
      });
    });

    _room.on(Events.participantLeft, (String participantId) {
      if (participants.containsKey(participantId)) {
        setState(() => participants.remove(participantId));
      }
    });

    _room.on(Events.roomLeft, () {
      participants.clear();
      Navigator.popUntil(context, ModalRoute.withName('/'));
    });
  }


  // onbackButton pressed leave the room
  Future<bool> _onWillPop() async {
    _room.leave();
    return true;
  }

  @override
  Widget build(BuildContext context) {
    final localParticipant = _room.localParticipant;
    final remoteParticipants = participants.values
        .where((p) => p.id != localParticipant.id)
        .toList();
    return WillPopScope(
      onWillPop: () => _onWillPop(),
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          children: [
            // Display the main participant's video in full screen
            if (participants.isNotEmpty)
              Positioned.fill(
                child: ParticipantTile(
                  key: Key(participants.values.first.id),
                  participant: participants.values.first,
                ),
              ),
            // Add a small PIP window for the local participant's video
           /* Positioned(
              bottom: 10,
              right: 20,
              width: 150,
              height: 200,
              child: ParticipantTile(
                key: Key(_room.localParticipant.id),
                participant: _room.localParticipant,
              ),
            ),*/
            if (mode == Mode.CONFERENCE)
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
            // Add meeting controls at the bottom
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: MeetingControls(
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
            ),
          ],
        ) /*Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    mainAxisExtent: 300,
                  ),
                  itemBuilder: (context, index) {
                    return ParticipantTile(
                        key: Key(participants.values.elementAt(index).id),
                        participant: participants.values.elementAt(index));
                  },
                  itemCount: participants.length,
                ),
              ),
            ),
            MeetingControls(
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
        )*/
        ,
      ),
    );
  }
}

class MeetingControls extends StatelessWidget {
  final void Function() onToggleMicButtonPressed;
  final void Function() onToggleCameraButtonPressed;
  final void Function() onLeaveButtonPressed;

  const MeetingControls(
      {super.key,
      required this.onToggleMicButtonPressed,
      required this.onToggleCameraButtonPressed,
      required this.onLeaveButtonPressed});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        commButton(
          icon: Icons.cameraswitch,
          onTap: onToggleCameraButtonPressed,
        ),
        SizedBox(
          width: 20,
        ),
        commButton(
            icon: Icons.mic_none_rounded, onTap: onToggleMicButtonPressed),
        SizedBox(
          width: 20,
        ),
        commButton(
            icon: Icons.call_end,
            colorBg: Colors.red,
            colorButton: Colors.white,
            onTap: onLeaveButtonPressed),
      ],
    );
  }

  commButton(
      {IconData? icon,
      VoidCallback? onTap,
      Color? colorBg,
      Color? colorButton}) {
    return Container(
      width: 60,
      decoration:
          BoxDecoration(color: colorBg ?? Colors.white, shape: BoxShape.circle),
      height: 60,
      child: Center(
        child: IconButton(
            onPressed: onTap,
            icon: Icon(
              icon ?? Icons.camera,
              color: colorButton ?? Colors.grey,
            )),
      ),
    );
  }
}

/*
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
    // initial video stream for the participant
    widget.participant.streams.forEach((key, Stream stream) {
      setState(() {
        if (stream.kind == 'video') {
          videoStream = stream;
        }
      });
    });
    _initStreamListeners();
    super.initState();
  }
  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  _initStreamListeners() {
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
}*/

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
