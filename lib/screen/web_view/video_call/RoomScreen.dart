import 'package:flutter/material.dart';
import 'package:videosdk/videosdk.dart';

import 'ParticipantTile.dart';

class RoomScreen extends StatefulWidget {
  const RoomScreen(
      {super.key});

  @override
  State<RoomScreen> createState() => _RoomScreenState();
}

class _RoomScreenState extends State<RoomScreen> {
  late Room _room;

  
  Map<String, Participant> participants = {};
  String? joined;

  @override
  void initState() {
    // create room
    _room = VideoSDK.createRoom(
      roomId: "3olc-wwhx-aghi",
      token: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhcGlrZXkiOiIyYmNhN2IwYS03MGZiLTRkMGUtOGU1ZC1hOWYzZGQ5ZmVlMDkiLCJwZXJtaXNzaW9ucyI6WyJhbGxvd19qb2luIl0sImlhdCI6MTczMDgwODcxMywiZXhwIjoxNzMwODk1MTEzfQ.H8jXV4x0BdO4Ntzn56DV8Jnwr9QEa43NnZQWGX0IX0U",
      displayName: "Sam's Org",
      micEnabled: true,
      camEnabled: true,
      defaultCameraIndex:
      1, // Index of MediaDevices will be used to set default camera
    );

    //set up event listener which will give any updates happening in the room
    setRoomEventListener();
    super.initState();
  }

  // listening to room events
  void setRoomEventListener() {
    //Event called when room is joined successfully
    _room.on(Events.roomJoined, () {
      setState(() {
        joined = "JOINED";
        participants.putIfAbsent(
            _room.localParticipant.id, () => _room.localParticipant);
      });
    });

    //Event called when new participant joins
    _room.on(
      Events.participantJoined,
          (Participant participant) {
        setState(
              () => participants.putIfAbsent(participant.id, () => participant),
        );
      },
    );
    //Event called when a participant leaves the room
    _room.on(Events.participantLeft, (String participantId) {
      if (participants.containsKey(participantId)) {
        setState(
              () => participants.remove(participantId),
        );
      }
    });
    //Event called when you leave the meeting
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
    return WillPopScope(
      onWillPop: () => _onWillPop(),
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: const Text('VideoSDK QuickStart'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: joined != null
              ? joined == "JOINED"
              ? Column(
            children: [
              //render all participants in the room
              Expanded(
                child: GridView.builder(
                  gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemBuilder: (context, index) {
                    return ParticipantTile(
                        participant:
                        participants.values.elementAt(index));
                  },
                  itemCount: participants.length,
                ),
              )
            ],
          ): const Text("JOINING the Room",
              style: TextStyle(color: Colors.white))
              : ElevatedButton(
              onPressed: () {
                //Method to join the room
                _room.join();
                setState(() {
                  joined = "JOINING";
                });
              },
              child: const Text("Join the Room")),
        ),
      ),
    );
  }
}