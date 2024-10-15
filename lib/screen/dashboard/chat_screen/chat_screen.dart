
import 'package:doctor_app/core/common/app_scaffold.dart';

import 'package:doctor_app/core/component/component.dart';
import 'package:doctor_app/screen/dashboard/chat_screen/chat_input_widget.dart';
import 'package:doctor_app/screen/dashboard/chat_screen/chat_list_widget.dart';
import 'package:flutter/material.dart';


class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key, this.isAI = false});
  final bool? isAI;

  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.sizeOf(context);
    return AppScaffold(
   left: 0,
      right: 0,
    appBar: commonAppBar(
      title: "Chat",
      actions: [
        IconButton(onPressed: (){}, icon: const Icon(Icons.videocam_outlined,color: Colors.white,)),
        IconButton(onPressed: (){}, icon: Icon(Icons.more_vert,color: Colors.white,))
      ]
    ),

      child: const Column(
        children: [
          Expanded(child: ChatListWidget()), // Messages List
          ChatInputWidget(), // Input field
        ],
      ),
    );
  }
}
