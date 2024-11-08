import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:videosdk/videosdk.dart';

class RoomScreen extends StatefulWidget {
  const RoomScreen(
      {super.key});

  @override
  State<RoomScreen> createState() => _RoomScreenState();
}

class _RoomScreenState extends State<RoomScreen> {

  late Room _room;

  @override
  void initState() {
    super.initState();

    // Initialize VideoSDK Room
    init();

  }


  Future<void> init() async {
   await   requestPermissions();
    _room = VideoSDK.createRoom(
      roomId: "3olc-wwhx-aghi",
      token:
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhcGlrZXkiOiIyYmNhN2IwYS03MGZiLTRkMGUtOGU1ZC1hOWYzZGQ5ZmVlMDkiLCJwZXJtaXNzaW9ucyI6WyJhbGxvd19qb2luIl0sImlhdCI6MTczMTA0NDExNiwiZXhwIjoxNzQ2NTk2MTE2fQ.ISjq5oGZUSpiQNTu0_cAEX3G0-lxx9z4UnC23Hi0ofE",
      displayName: "Sam's Org",
      micEnabled: true,
      camEnabled: true,
      maxResolution: "hd",
    );

    _room.on(Events.roomJoined, (participant) {
      setState(() {}); // Rebuild the UI to show the new participant
    });

    _room.on(Events.participantLeft, (participant) {
      setState(() {}); // Rebuild the UI to reflect the change
    });

    _room.join();
  }
  Future<bool> requestPermissions() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.camera,
      Permission.microphone,
    ].request();

    return statuses[Permission.camera]!.isGranted && statuses[Permission.microphone]!.isGranted;
  }

  @override
  void dispose() {
    _room.leave();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('=====localParticipant====${ _room.localParticipant.id}');
    return Scaffold(
      appBar: AppBar(
        title: Text('Video Call'),
      ),
      body: Stack(
       children: [
         // Remote Participant View
         Positioned.fill(
           child: _room.participants.isNotEmpty
               ? ParticipantView(
             participant: _room.participants.values.first,
           )
               : Center(
             child: Text(
               "Waiting for participant...",
               style: TextStyle(color: Colors.white),
             ),
           ),
         ),

         // Local Participant View (Preview)
         Positioned(
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
         ),
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
       ],
      ),
    );
  }

}
class ParticipantView extends StatelessWidget {
  final Participant participant;

  ParticipantView({required this.participant});

  @override
  Widget build(BuildContext context) {
    // Get the video stream, if available
    final Stream? videoStream = participant.streams.values
        .cast<Stream?>()
        .firstWhere(
          (stream) => stream?.kind == "video",
      orElse: () => null, // Return null if no video stream is found
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
                participant.displayName ?? "No Video",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),

          // Participant name overlay
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
