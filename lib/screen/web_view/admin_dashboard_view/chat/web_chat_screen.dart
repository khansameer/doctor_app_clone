import 'package:doctor_app/core/colors.dart';
import 'package:doctor_app/core/common/common_text_widget.dart';
import 'package:doctor_app/core/common/common_textfield.dart';
import 'package:doctor_app/core/component/component.dart';
import 'package:doctor_app/core/image/image_path.dart';
import 'package:doctor_app/core/responsive.dart';
import 'package:doctor_app/provider/admin_dashboard_provider.dart';
import 'package:doctor_app/screen/web_view/admin_dashboard_view/chat/receiver_message_view.dart';
import 'package:doctor_app/screen/web_view/admin_dashboard_view/chat/sender_message_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../provider/chat_provider.dart';

class WebChatScreen extends StatefulWidget {
  const WebChatScreen(
      {super.key, required this.communication, this.chatRoomId});

  final bool communication;
  final String? chatRoomId;

  @override
  State<WebChatScreen> createState() => _WebChatScreenState();
}

class _WebChatScreenState extends State<WebChatScreen> {
  String? userId;
  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    userId = await getUserID();
    print('===userId==$userId');
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    var isDesktop = Responsive.isDesktop(context);
    var isMobile = Responsive.isMobile(context);
    final chatProvider = Provider.of<ChatProvider>(context);
    final TextEditingController messageController = TextEditingController();

    return Container(
      width: isDesktop
          ? size.width * 0.8
          : isMobile
              ? size.width
              : size.width * 0.9,
      height: size.height,

      //  margin: EdgeInsets.all(communication ? 10 : 0),
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3), //color of shadow
              spreadRadius: 2, //spread radius
              blurRadius: 3, // blur radius
              offset: const Offset(0, 2),
            )
          ],
          borderRadius: BorderRadius.circular(8)),
      //height: size.height * 0.8,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                Expanded(
                    child: Row(
                  children: [
                    widget.communication
                        ? const SizedBox.shrink()
                        : IconButton(
                            padding: const EdgeInsets.all(3),
                            alignment: Alignment.center,
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            icon: const Icon(
                              color: Colors.grey,
                              Icons.arrow_back_ios_outlined,
                              size: 24,
                            )),
                    widget.communication
                        ? const SizedBox.shrink()
                        : const SizedBox(
                            width: 10,
                          ),
                    isMobile
                        ? const SizedBox.shrink()
                        : commonInkWell(
                            child: commonProfileIcon(
                                width: 40,
                                height: 40,
                                path: context
                                        .read<AdminDashboardProvider>()
                                        .chatUserInfo
                                        ?.profile ??
                                    context
                                        .read<AdminDashboardProvider>()
                                        .patients[0]
                                        .profile)),
                    Flexible(
                      child: CommonTextWidget(
                        text: context
                                .read<AdminDashboardProvider>()
                                .chatUserInfo
                                ?.name ??
                            context
                                .read<AdminDashboardProvider>()
                                .patients[0]
                                .name,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        left: 10,
                      ),
                    )
                  ],
                )),
                Expanded(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(
                          left: 25.0, right: 25, top: 10, bottom: 10),
                      margin: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          color: AppColors.colorBgNew,
                          borderRadius: BorderRadius.circular(8)),
                      child: Center(
                        child: isMobile
                            ? const Icon(Icons.history_edu_rounded)
                            : CommonTextWidget(
                                text: "Case History",
                                textColor: AppColors.colorTextNew,
                                fontWeight: FontWeight.w600,
                              ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Flexible(
                      child: Container(
                        alignment: Alignment.topLeft,
                        width: 40,
                        decoration: const BoxDecoration(
                            color: AppColors.colorBgNew,
                            shape: BoxShape.circle),
                        height: 40,
                        child: const Center(
                          child: Icon(
                            size: 20,
                            Icons.call_sharp,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                  ],
                ))
              ],
            ),
          ),
          const Divider(
            thickness: 0.3,
          ),
          Expanded(
            child: StreamBuilder<List<Map<String, dynamic>>>(
                stream: chatProvider.getMessages(widget.chatRoomId ?? ''),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(child: Text('No messages yet.'));
                  }
                  final messages = snapshot.data!;

                  return ListView.builder(
                    reverse: true,
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      final message = messages[index];
                      final isMe = message['senderId'] == userId;
                      if (isMe) {
                        return SenderMessageView(
                          msg: message['message'] ?? '',
                        );
                      } else {
                        return ReceiverMessageView(
                          msg: message['message'] ?? '',
                        );
                      }
                      /*  return Align(
                        alignment: isMe
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 10),
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: isMe ? Colors.blue : Colors.grey[300],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            message['message'] ?? '',
                            style: TextStyle(
                                color: isMe ? Colors.white : Colors.black),
                          ),
                        ),
                      );*/
                      /* if (chatModel.chatMessages[index].sentByUser) {
                        return SenderMessageView(
                          chatMessage: chatModel.chatMessages[index],
                        );
                      } else {
                        return ReceiverMessageView(
                          chatMessage: chatModel.chatMessages[index],
                        );
                      }*/
                    },
                  );
                }),
          ),
          /* const Divider(
                thickness: 0.3,
              ),*/
          Container(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: CommonTextField(
                    suffixIcon: IconButton(
                      icon: Icon(Icons.send),
                      onPressed: () {
                        final message = messageController.text.trim();
                        chatProvider.sendMessage(
                            chatRoomId: widget.chatRoomId ?? '',
                            senderId: userId,
                            message: message);
                        messageController.clear();
                      },
                    ),
                    colorFill: Colors.white,
                    controller: messageController,
                    /* decoration: InputDecoration(
                      hintText: 'Type a message...',
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey.withOpacity(0.2)
                        )
                      ),
                    ),*/
                  ),
                ),
                /*    IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    final message = messageController.text.trim();
                    chatProvider.sendMessage(chatRoomId, message, userId);
                    messageController.clear();
                  },
                ),*/
              ],
            ),
          ),
          /*Container(
            margin: EdgeInsets.only(
                left: size.width * 0.1, right: size.width * 0.1),
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: CommonTextField(
                    colorFill: Colors.white,
                    borderColor: Colors.grey.withOpacity(0.40),
                    iconWidget: IconButton(
                        onPressed: () {
                          final message = messageController.text.trim();
                          chatProvider.sendMessage(
                              chatRoomId ?? '', message, userId ?? '');
                          messageController.clear();
                        },
                        icon: Icon(
                          Icons.attachment_outlined,
                          color: Colors.grey,
                        )),
                    suffixIcon: Container(
                      width: 50,
                      height: 50,
                      child: Center(
                        child: setAssetImage(
                            image: icSend,
                            width: 20,
                            height: 20,
                            color: Colors.grey),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),*/
        ],
      ),
    );
  }
}
