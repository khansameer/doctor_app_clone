import 'package:doctor_app/core/common/common_button_widget.dart';
import 'package:doctor_app/screen/agora_video_call.dart';
import 'package:doctor_app/screen/web_view/video_call/CallScreen.dart';
import 'package:flutter/material.dart';

class CallDemo extends StatelessWidget {
  const CallDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: CommonButtonWidget(
              left: 40,
              right: 40,
              text: "Call",
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => CallScreen()));
              },
            ),
          ),
        ],
      ),
    );
  }
}
