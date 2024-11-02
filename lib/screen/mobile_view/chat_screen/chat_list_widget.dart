import 'package:doctor_app/core/colors.dart';
import 'package:doctor_app/core/common/common_text_widget.dart';
import 'package:doctor_app/core/image/image_path.dart';
import 'package:flutter/material.dart';
import 'package:doctor_app/core/app_constants.dart';
import 'package:doctor_app/core/component/component.dart';
import 'package:doctor_app/provider/chat_provider.dart';

import 'package:provider/provider.dart';

import '../../../core/responsive.dart';

class ChatListWidget extends StatelessWidget {
  const ChatListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    var isMobile = Responsive.isMobile(context);
    var isTablet = Responsive.isTablet(context);
    return Center(
      child: Container(
        width: isMobile
            ? size.width
            : isTablet
                ? size.width * 0.7
                : size.width * 0.4,
        height: size.height,
        decoration: const BoxDecoration(
            color: AppColors.colorBG,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10), topRight: Radius.circular(10))),
        child: Consumer<ChatProvider>(
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
                              width: 40,
                              height: 40,
                              margin: const EdgeInsets.all(5),
                              decoration: commonBoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                              ),
                              child: CircleAvatar(
                                child: ClipOval(
                                  child: Center(
                                    child: setAssetImage(
                                        image: icMen, width: 40, height: 40),
                                  ),
                                ),
                              ),
                            ),
                      Flexible(
                        child: Container(
                          padding: const EdgeInsets.all(ten),
                          margin: const EdgeInsets.symmetric(
                              vertical: four, horizontal: sixteen),
                          decoration: BoxDecoration(
                            color: message.isSentByMe
                                ? AppColors.colorGreen
                                : Colors.grey,
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
        ),
      ),
    );
  }
}
