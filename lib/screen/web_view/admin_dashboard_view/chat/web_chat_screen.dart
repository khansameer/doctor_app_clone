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
import '../../video_call/CallScreen.dart';

class WebChatScreen extends StatefulWidget {
  const WebChatScreen(
      {super.key, required this.communication, this.chatRoomId,this.name,this.profilePic});

  final bool communication;
  final String? chatRoomId;
  final String? name;
  final String? profilePic;

  @override
  State<WebChatScreen> createState() => _WebChatScreenState();
}

class _WebChatScreenState extends State<WebChatScreen> {
  String? userId;
  String? username;
  String doctorID="672a8e078137e27f0cb18f84";
  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    userId = await getUserID();
    username = await getName();

  }

  @override
  Widget build(BuildContext context) {
    print('===chatRoomId==${widget.chatRoomId}');
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
                            child: commonImageNetworkWidget(
                                width: 40,
                                height: 40,
                                path: widget.profilePic)),
                    Flexible(
                      child: CommonTextWidget(
                        text: widget.name,
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

                    const SizedBox(
                      width: 10,
                    ),
                    Flexible(
                      child: commonInkWell(
                        onTap: (){
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder:
                                      (context) =>
                                      CallScreen()));
                        },
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
                              Icons.videocam_outlined,
                              color: Colors.grey,
                            ),
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
                  if (!snapshot.hasData || snapshot.data?.length==null) {
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
                    inputTypes: TextInputType.text,
                    onFieldSubmitted: (value) {
                      final message = messageController.text.trim();
                      chatProvider.sendMessage(
                          chatRoomId: widget.chatRoomId ?? '',
                          senderId: userId,
                          message: message);
                      messageController.clear();
                    },
                    textInputAction: TextInputAction.done,
                    suffixIcon: IconButton(
                      focusNode: FocusNode(
                        canRequestFocus: false,

                      ),
                      icon: Icon(Icons.send),

                      onPressed: () {
                        final message = messageController.text.trim();
                        chatProvider.sendMessage(
                            chatRoomId: widget.chatRoomId ?? '',
                            senderId: userId,
                            username: username,
                            message: message);
                        messageController.clear();
                      },
                    ),
                    colorFill: Colors.white,
                    controller: messageController,

                  ),
                ),

              ],
            ),
          ),

        ],
      ),
    );
  }
}
