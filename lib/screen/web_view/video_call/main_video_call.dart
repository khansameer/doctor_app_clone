import 'package:doctor_app/core/common/common_button_widget.dart';
import 'package:doctor_app/screen/web_view/video_call/CallScreen.dart';

import 'package:flutter/material.dart';

class MainVideoCall extends StatelessWidget {
  const MainVideoCall({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              CommonButtonWidget(
                text: "Doctor",
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>CallScreen()));
                },
              ),


            ],
          ),
        ),
      ),
    );
  }
}
