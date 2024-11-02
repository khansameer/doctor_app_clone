import 'package:doctor_app/core/colors.dart';
import 'package:doctor_app/core/common/common_text_widget.dart';
import 'package:doctor_app/core/common/common_textfield.dart';
import 'package:doctor_app/core/common/custom_alert_dialog.dart';
import 'package:doctor_app/core/component/component.dart';
import 'package:doctor_app/core/image/image_path.dart';
import 'package:doctor_app/provider/admin_dashboard_provider.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/responsive.dart';
import 'chat/web_chat_screen.dart';

class CommunicationScreen extends StatefulWidget {
  const CommunicationScreen({super.key});

  @override
  State<CommunicationScreen> createState() => _CommunicationScreenState();
}

class _CommunicationScreenState extends State<CommunicationScreen> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    var isMobile = Responsive.isMobile(context);
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withValues(alpha: 0.3), //color of shadow
                    spreadRadius: 2, //spread radius
                    blurRadius: 3, // blur radius
                    offset: const Offset(0, 2),
                  )
                ],
                borderRadius: BorderRadius.circular(8)),
            height: size.height * 0.9,
            margin: EdgeInsets.all(isMobile ? 0 : 10),
            child: Padding(
              padding: const EdgeInsets.all(0.0),
              child: DefaultTabController(
                  length: 2,
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              10,
                            ),
                            color: const Color.fromRGBO(250, 251, 253, 1),
                          ),
                          child: TabBar(
                            unselectedLabelStyle: commonTextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 13,
                            ),
                            isScrollable: false,
                            dividerColor: Colors.white,
                            indicatorSize: TabBarIndicatorSize.tab,
                            tabAlignment: TabAlignment.fill,

                            indicator: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: AppColors.colorBgNew),
                            labelStyle: commonTextStyle(
                                fontSize: 13, fontWeight: FontWeight.w500),
                            labelColor: AppColors.colorBlue,
                            // indicatorColor: AppColors.colorTextNew,
                            unselectedLabelColor: AppColors.colorBlue,

                            tabs: const [
                              Tab(text: 'Patients'),
                              Tab(text: 'Doctors'),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: TabBarView(
                          children: [
                            _commonUserList(isMobile: isMobile),
                            _commonUserList(isMobile: isMobile)
                          ],
                        ),
                      ),
                    ],
                  )),
            ),
          ),
        ),
        isMobile
            ? SizedBox.shrink()
            : Expanded(
                flex: 5,
                child: WebChatScreen(
                  communication: true,
                ),
              ),
      ],
    );
  }

  _commonUserList({required bool isMobile}) {
    return Consumer<AdminDashboardProvider>(
      builder: (context, chatModel, child) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(10),
                shrinkWrap: true,
                itemCount: chatModel.patients.length,
                itemBuilder: (context, index) {
                  var data = chatModel.patients[index];
                  return Container(
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.only(top: 0),
                    decoration: BoxDecoration(
                        color: index == chatModel.selectedUserIndex
                            ? AppColors.colorBgNew
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(8)),
                    child: ListTile(
                      trailing: data.messageCount == 0
                          ? const SizedBox.shrink()
                          : Container(
                              width: 30,
                              height: 30,
                              decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColors.colorNotification),
                              child: Center(
                                child: CommonTextWidget(
                                  text: '${data.messageCount}',
                                  fontSize: 10,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                      titleAlignment: ListTileTitleAlignment.center,
                      leading: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: setAssetImage(
                              width: 40,
                              height: 40,
                              fit: BoxFit.cover,
                              image: data.profile ?? icDummyUsers,
                            ),
                          ),
                          data.messageCount == 0
                              ? const SizedBox.shrink()
                              : Positioned(
                                  right: -5,
                                  top: -3,
                                  child: Container(
                                    width: 10,
                                    decoration: const BoxDecoration(
                                        color: Colors.green,
                                        shape: BoxShape.circle),
                                    height: 10,
                                  ))
                        ],
                      ),
                      title: CommonTextWidget(
                        text: data.name,
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                      subtitle: CommonTextWidget(
                        text: data.latestMessage,
                        fontSize: 11,
                        textColor: AppColors.colorBlue,
                      ),
                      onTap: () {
                        if (isMobile) {
                          showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: (BuildContext context) {
                                return const CustomAlertDialog(
                                  insetPadding: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 10),
                                  content: WebChatScreen(
                                    communication: false,
                                  ),
                                );
                              });
                          chatModel.chatUserInfoValue(data);
                          chatModel.selectUser(index);
                        } else {
                          chatModel.chatUserInfoValue(data);
                          chatModel.selectUser(index);
                        }
                      },
                    ),
                  );
                },
              ),
            ),
            const Divider(
              thickness: 0.3,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                height: 40,
                child: CommonTextField(
                  onChange: (query) {
                    // context.read<AdminDashboardProvider>().updateSearchQuery(query);
                  },
                  hint: "Search",
                  colorFill: AppColors.colorListView,
                  //  hint: "Search Patient Name/ID/Phone number",
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}