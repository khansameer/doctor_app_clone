import 'package:doctor_app/core/common/common_text_widget.dart';
import 'package:doctor_app/core/image/image_path.dart';
import 'package:flutter/material.dart';
import 'package:doctor_app/core/app_constants.dart';
import 'package:doctor_app/core/color_utils.dart';
import 'package:doctor_app/core/component/component.dart';
import 'package:doctor_app/provider/chat_provider.dart';

import 'package:provider/provider.dart';


class ChatListWidget extends StatelessWidget {
  const ChatListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ChatProvider>(
      builder: (context, chatProvider, child) {
        return ListView.builder(
          padding: const EdgeInsets.all(ten),
          itemCount: chatProvider.messages.length,
          itemBuilder: (context, index) {
            final message = chatProvider.messages[index];
            return Align(
              alignment: message.isSentByMe
                  ? Alignment.centerRight
                  : Alignment.centerLeft,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  message.isSentByMe
                      ? const SizedBox.shrink()
                      : Container(
                          width: thirtyFive,
                          height: thirtyFive,
                          decoration: commonBoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                          child: Center(
                            child: ClipOval(
                              child: setAssetImage(image: icChatUserIcon),
                            ),
                          ),
                        ),
                  Flexible(
                    child: Container(
                      padding: const EdgeInsets.all(ten),
                      margin: const EdgeInsets.symmetric(
                          vertical: four, horizontal: sixteen),
                      decoration: BoxDecoration(
                        color: message.isSentByMe ? colorGreen : Colors.grey,
                        borderRadius: BorderRadius.circular(eight),
                      ),
                      child: CommonTextWidget(
                        text: message.text,
                        textColor: Colors.white,
                        fontSize: thirteen,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
