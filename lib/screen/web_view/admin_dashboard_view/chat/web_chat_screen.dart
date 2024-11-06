import 'package:doctor_app/core/colors.dart';
import 'package:doctor_app/core/common/common_text_widget.dart';
import 'package:doctor_app/core/component/component.dart';
import 'package:doctor_app/core/image/image_path.dart';
import 'package:doctor_app/core/responsive.dart';
import 'package:doctor_app/provider/admin_dashboard_provider.dart';
import 'package:doctor_app/screen/web_view/admin_dashboard_view/chat/receiver_message_view.dart';
import 'package:doctor_app/screen/web_view/admin_dashboard_view/chat/sender_message_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WebChatScreen extends StatelessWidget {
  const WebChatScreen({super.key, required this.communication});

  final bool communication;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    var isDesktop = Responsive.isDesktop(context);
    var isMobile = Responsive.isMobile(context);

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
              color: Colors.grey.withOpacity( 0.3), //color of shadow
              spreadRadius: 2, //spread radius
              blurRadius: 3, // blur radius
              offset: const Offset(0, 2),
            )
          ],
          borderRadius: BorderRadius.circular(8)),
      //height: size.height * 0.8,
      child: Consumer<AdminDashboardProvider>(
        builder: (context, chatModel, child) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    Expanded(
                        child: Row(
                      children: [
                        communication
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
                        communication
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
                child: ListView.builder(
                  itemCount: chatModel.chatMessages.length,
                  itemBuilder: (context, index) {
                    if (chatModel.chatMessages[index].sentByUser) {
                      return SenderMessageView(
                        chatMessage: chatModel.chatMessages[index],
                      );
                    } else {
                      return ReceiverMessageView(
                        chatMessage: chatModel.chatMessages[index],
                      );
                    }
                  },
                ),
              ),
              const Divider(
                thickness: 0.3,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    const SizedBox(
                      width: 10,
                    ),
                    const Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          border: InputBorder.none,

                          //border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    Container(
                      width: 50,
                      height: 50,
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle, color: AppColors.colorBgNew),
                      child: Center(
                        child:
                            setAssetImage(image: icSend, width: 20, height: 20),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
