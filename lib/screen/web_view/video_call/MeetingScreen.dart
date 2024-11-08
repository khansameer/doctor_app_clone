
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:videosdk/videosdk.dart';

class MeetingScreen extends StatefulWidget {


  const MeetingScreen(
      {super.key, });

  @override
  State<MeetingScreen> createState() => _MeetingScreenState();
}

class _MeetingScreenState extends State<MeetingScreen> {
  late Room _room;
  var micEnabled = true;
  var camEnabled = true;
  late final Mode mode=Mode.CONFERENCE;

  String meetingId="3olc-wwhx-aghi";
  Map<String, Participant> participants = {};
  late VideoSDK videoSDK; // Video SDK instance
  @override
  void initState() {
    // create room

    _room = VideoSDK.createRoom(
        roomId: "3olc-wwhx-aghi",
        token:
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhcGlrZXkiOiIyYmNhN2IwYS03MGZiLTRkMGUtOGU1ZC1hOWYzZGQ5ZmVlMDkiLCJwZXJtaXNzaW9ucyI6WyJhbGxvd19qb2luIl0sImlhdCI6MTczMTA0NDExNiwiZXhwIjoxNzQ2NTk2MTE2fQ.ISjq5oGZUSpiQNTu0_cAEX3G0-lxx9z4UnC23Hi0ofE",
        multiStream: false,
        displayName: "John Doe",
        micEnabled: micEnabled,
        mode: mode,
        notification: const NotificationInfo(
          title: "Video SDK",
          message: "Video SDK is sharing screen in the meeting",
          icon: "notification_share", // drawable icon name
        ),
        camEnabled: camEnabled,
        defaultCameraIndex: kIsWeb
            ? 0
            : 1  // Index of MediaDevices will be used to set default camera
    );

    setMeetingEventListener();

    // Join room
    _room.join();

    super.initState();
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
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

  // onbackButton pressed leave the room
  Future<bool> _onWillPop() async {
    _room.leave();
    return true;
  }

  @override
  void dispose() {
    //_room.dispose();
    super.dispose();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _onWillPop(),
      //home: JoinScreen(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('VideoSDK QuickStart'),
        ),
        body:Stack(
          children: [
            // Remote Participant View
            Positioned.fill(
              child: _room.participants.isNotEmpty
                  ? ParticipantView(participant: _room.participants.values.first)
                  : Center(
                child: Text(
                  "Waiting for participant...",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
         /*   Positioned(
              bottom: 20,
              right: 20,
              child: Container(
                width: 100,
                height: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.white),
                ),
                child: ParticipantView(participant: _room.localParticipant),
              ),
            ),*/
            Positioned(
              bottom: 40,
              left: 0,
              right: 0,
              child: Center(
                child: IconButton(
                  icon: Icon(Icons.call_end, color: Colors.red, size: 36),
                  onPressed: () {
                    _room.leave();
                    Navigator.pop(context);
                  },
                ),
              ),
            ),
            // Local Participant (Preview)
          ],
        )


        /* Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text(meetingId),
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
          ),
        )*/,
      ),
    );
  }
}

class ParticipantView extends StatelessWidget {
  final Participant participant;

  ParticipantView({required this.participant});

  @override
  Widget build(BuildContext context) {
    // Check if the participant has a video stream
    final Stream? videoStream = participant.streams.values.firstWhere(
          (stream) => stream.kind == "video",


    );


    return Container(
      color: Colors.black,
      child: Stack(
        children: [
          // Render video if available
          if (videoStream != null)
            RTCVideoView(videoStream.renderer!)
          else
            Center(
              child: Text(
                participant.displayName ?? "Participant",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),

          // Display participant name overlay
          Positioned(
            bottom: 8,
            left: 8,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.black54,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                participant.displayName ?? "Unknown",
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
