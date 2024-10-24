import 'package:doctor_app/screen/admin/video/video_auth.dart';
import 'package:flutter/material.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
class VideoCallScreen extends StatelessWidget {
  const VideoCallScreen({super.key, this.name, this.userID});

  final String? name;
  final String? userID;

  @override
  Widget build(BuildContext context) {
    return ZegoUIKitPrebuiltCall(
        appID: VideoAuth.appID,


        appSign: VideoAuth.appSign,
        userID: userID.toString(),
        userName: name.toString(),
        callID: "sameer",
        // You can also use groupVideo/groupVoice/oneOnOneVoice to make more types of calls.
        config: ZegoUIKitPrebuiltCallConfig.oneOnOneVideoCall());
  }
}
