import 'package:doctor_app/core/color_utils.dart';
import 'package:doctor_app/core/common/app_scaffold.dart';
import 'package:doctor_app/core/common/common_text_widget.dart';

import 'package:doctor_app/core/component/component.dart';
import 'package:doctor_app/core/responsive.dart';
import 'package:doctor_app/screen/mobile_view/chat_screen/chat_input_widget.dart';
import 'package:doctor_app/screen/mobile_view/chat_screen/chat_list_widget.dart';
import 'package:flutter/material.dart';

import '../../../core/image/image_path.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key, this.isAI = false});
  final bool? isAI;

  @override
  Widget build(BuildContext context) {
    var isMobile = Responsive.isMobile(context);
    return AppScaffold(
      left: 0,
      right: 0,
      appBar: commonAppBar(
          centerTitle: false,
          titleSpacing: 0,
          titleWidget: Row(
            children: [
              CircleAvatar(
                child: ClipOval(
                  child: setAssetImage(image: icDummyUser),
                ),
              ),
              //  Icon(Icons.ac_unit_rounded),
              CommonTextWidget(
                left: 10,
                fontSize: 14,
                textColor: Colors.white,
                fontWeight: FontWeight.w700,
                text: "Richard".toUpperCase(),
              )
            ],
          ),
          // title: "Chat".toUpperCase(),
          actions: [
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.videocam_outlined,
                  color: Colors.white,
                )),
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.more_vert,
                  color: Colors.white,
                ))
          ]),
      child: Container(
        color: isMobile ? colorBG : Colors.white,
        padding: EdgeInsets.all(isMobile ? 0 : 20.0),
        child: const Column(
          children: [
            Expanded(child: ChatListWidget()), // Messages List
            ChatInputWidget(), // Input field
          ],
        ),
      ),
    );
  }
}
