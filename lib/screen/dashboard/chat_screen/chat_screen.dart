
import 'package:doctor_app/core/color_utils.dart';
import 'package:doctor_app/core/common/app_scaffold.dart';

import 'package:doctor_app/core/component/component.dart';
import 'package:doctor_app/core/responsive.dart';
import 'package:doctor_app/screen/dashboard/chat_screen/chat_input_widget.dart';
import 'package:doctor_app/screen/dashboard/chat_screen/chat_list_widget.dart';
import 'package:flutter/material.dart';


class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key, this.isAI = false});
  final bool? isAI;

  @override
  Widget build(BuildContext context) {
    var isMobile=Responsive.isMobile(context);

    return AppScaffold(
   left: 0,
      right: 0,
    appBar: isMobile?PreferredSize(preferredSize: Size.zero, child: Container()):commonAppBar(
      title: "Chat",
      colorText: colorText,
      color: colorBG,
      leading: commonBackRedirectButton(page: "chat_user_list"),
      actions: [
        IconButton(onPressed: (){}, icon: const Icon(Icons.videocam_outlined,color: colorText,)),
        IconButton(onPressed: (){}, icon: const Icon(Icons.more_vert,color:colorText,))
      ]
    ),

      child: Container(
        color:colorBG ,
        padding:  EdgeInsets.all(isMobile?0:20.0),
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
