import 'package:doctor_app/core/colors.dart';
import 'package:doctor_app/core/common/custom_alert_dialog.dart';

import 'package:doctor_app/core/common/common_text_widget.dart';
import 'package:doctor_app/core/common/error_page.dart';
import 'package:doctor_app/core/component/component.dart';
import 'package:doctor_app/core/image/image_path.dart';
import 'package:doctor_app/core/responsive.dart';
import 'package:doctor_app/provider/admin_dashboard_provider.dart';
import 'package:doctor_app/provider/dashboard_provider.dart';
import 'package:doctor_app/provider/patient_provider.dart';
import 'package:doctor_app/provider/report_provier.dart';
import 'package:doctor_app/screen/web_view/admin_dashboard_view/chat/web_chat_screen.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../service/gloable_status_code.dart';
import 'admin_patient_details_view.dart';

class AdminPatientAllListView extends StatefulWidget {
  const AdminPatientAllListView({super.key, this.title});

  final String? title;

  @override
  State<AdminPatientAllListView> createState() => _AdminAllListScreenState();
}

class _AdminAllListScreenState extends State<AdminPatientAllListView> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<DashboardProvider>().getUserName();
      context
          .read<PatientProvider>()
          .getPatientDetails(context: context)
          .then((value) {});
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.title == "all") {
        context.read<PatientProvider>().getAlLList();
      } else if (widget.title == "all_male") {
        context.read<PatientProvider>().filterByGender("male");
      } else if (widget.title == "all_female") {
        context.read<PatientProvider>().filterByGender("female");
      }
    });
    var isMobile = Responsive.isMobile(context);
    var size = MediaQuery.sizeOf(context);
    return Consumer<PatientProvider>(builder: (context, provider, child) {
      return Stack(
        children: [
          ListView(
            children: [
              Column(
                children: [
                  Container(
                    width: size.width,
                    padding: const EdgeInsets.all(10.0),
                    color: AppColors.colorBgNew,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: List.generate(26, (index) {
                          final letter = String.fromCharCode(
                              65 + index); // ASCII value of A is 65
                          final isAvailable =
                              provider.availableLetters?.contains(letter);

                          return GestureDetector(
                            onTap: isAvailable == true
                                ? () => provider.selectLetter(letter)
                                : null,
                            child: Container(
                              margin: const EdgeInsets.symmetric(horizontal: 3),
                              padding: const EdgeInsets.all(15.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                color:
                                    isAvailable == true ? Colors.white : null,
                              ),
                              child: CommonTextWidget(
                                text: letter,
                                fontSize: 12,
                                textAlign: TextAlign.center,
                                textColor: isAvailable == true
                                    ? AppColors.colorBlue
                                    : AppColors.colorTextNew,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          );
                        }),
                      ),
                    ),
                  ),
                  globalStatusCode==200 || globalStatusCode==201? ListView.builder(
                      shrinkWrap: true,
                      itemCount: provider.patients?.length ?? 0,
                      itemBuilder: (context, index) {
                        var data = provider.patients?[index];
                        /*  var data = provider.patients?[index];
                        final age = provider.calculateAge(DateTime.parse(
                            data?.dateOfBirth.toString() ??
                                DateTime.now().toString()));*/
                        final dateOfBirthStr = data?.dateOfBirth?.toString();
                        final dateOfBirth = dateOfBirthStr != null
                            ? DateTime.parse(dateOfBirthStr)
                            : DateTime.now();
                        final age = calculateAge(dateOfBirth);
                        return Container(
                          decoration: BoxDecoration(
                              color: AppColors.colorListView,
                              borderRadius: BorderRadius.circular(8)),
                          margin: const EdgeInsets.all(10),
                          padding: const EdgeInsets.all(15),
                          child: ListTile(
                            titleAlignment: ListTileTitleAlignment.titleHeight,
                            contentPadding: EdgeInsets.zero,
                            trailing: isMobile
                                ? const SizedBox.shrink()
                                : _viewButtonView(
                                patientID: data?.sId??'',
                                    isMobile: isMobile, index: index),
                            leading: MouseRegion(
                                cursor: SystemMouseCursors.click,
                                onEnter: (details) {
                                  if (!provider.isProfileDialogOpen) {
                                    provider.showProfileOverlay(
                                      context: context,patientID:data?.sId??'' ,
                                        size: size);
                                  }
                                },
                                onExit: (_) {
                                  if (provider.isProfileDialogOpen) {
                                    provider.hideProfileOverlay();
                                  }
                                },
                                child: SizedBox(
                                  width: 40,
                                  height: 40,
                                  child: commonImageNetworkWidget(
                                      width: 40,
                                      height: 40,
                                      path:
                                          '${data?.profile?.profilePicture.toString()}'),
                                )),
                            title: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                commonInkWell(
                                  onEnter: (event) {
                                    // showProfileDialog(context);
                                    context.read<ReportProvider>().setName =
                                        '${data?.firstName.toString()} ${data?.lastName.toString()}';
                                    context.read<ReportProvider>().setImage =
                                        icPatientUser4;
                                  },
                                  child: CommonTextWidget(
                                    text:
                                        '${data?.firstName.toString()} ${data?.lastName.toString()}(${data?.gender.toString().toUpperCase()[0]})',
                                    fontWeight: FontWeight.w700,
                                    fontSize: 15,
                                  ),
                                )
                              ],
                            ),
                            subtitle: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CommonTextWidget(
                                  text: '$age',
                                  top: 5,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 13,
                                ),
                                isMobile
                                    ? _viewButtonView(
                                        patientID: data?.sId??'',
                                        isMobile: isMobile, index: index)
                                    : const SizedBox.shrink()
                              ],
                            ),
                          ),
                        );
                      }):ErrorPage(),
                ],
              ),
            ],
          ),
          provider.isAdding ? showLoaderList() : const SizedBox.shrink()
        ],
      );
    });
  }

  _viewButtonView({required bool isMobile, required int index,required String patientID}) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        commonInkWell(
          onTap: () {
            //  chatModel.chatUserInfoValue(data);

          },
          child: Consumer<AdminDashboardProvider>(
              builder: (context, provider, child) {
            return MouseRegion(
              onEnter: (_) {
                provider.setHoveredVideoCall(index);
              },
              onExit: (_) {
                provider.setHoveredVideoCall(null);
              },
              child: AnimatedContainer(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                    color: provider.hoveredVideoCall == index
                        ? AppColors.primary
                        : AppColors.colorBgNew,
                    shape: BoxShape.circle),
                /* decoration: const BoxDecoration(
                      color: Colors.white, shape: BoxShape.circle),*/
                duration: const Duration(milliseconds: 200),
                child: Center(
                  child: Icon(
                    Icons.videocam_outlined,
                    size: 20,
                    color: provider.hoveredVideoCall == index
                        ? Colors.white
                        : Colors.grey,
                  ),
                ),
              ),
            );
          }),
        ),
        const SizedBox(
          width: 10,
        ),
        commonInkWell(
          onTap: () {
            //  chatModel.chatUserInfoValue(data);
            showDialog(
                barrierDismissible: false,
                context: context,
                builder: (BuildContext context) {
                  return const CustomAlertDialog(
                    content: WebChatScreen(
                      chatRoomId: "Sameer",
                      communication: false,
                    ),
                  );
                });
          },
          child: Consumer<AdminDashboardProvider>(
              builder: (context, provider, child) {
                return MouseRegion(
                  onEnter: (_) {
                    provider.setHoveredChat(index);
                  },
                  onExit: (_) {
                    provider.setHoveredChat(null);
                  },
                  child: AnimatedContainer(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                        color: provider.hoveredChat == index
                            ? AppColors.primary
                            : AppColors.colorBgNew,
                        shape: BoxShape.circle),
                    /* decoration: const BoxDecoration(
                      color: Colors.white, shape: BoxShape.circle),*/
                    duration: const Duration(milliseconds: 200),
                    child: Center(
                      child: Icon(
                        Icons.chat,
                        size: 20,
                        color: provider.hoveredChat == index
                            ? Colors.white
                            : Colors.grey,
                      ),
                    ),
                  ),
                );
              }),
        ),
        const SizedBox(
          width: 10,
        ),
        Flexible(
          child: Consumer<AdminDashboardProvider>(
              builder: (context, provider, child) {
            return MouseRegion(
              onEnter: (_) {
                provider.setHoveredAudioCall(index);
              },
              onExit: (_) {
                provider.setHoveredAudioCall(null);
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                alignment: Alignment.topLeft,
                width: 50,
                decoration: BoxDecoration(
                    color: provider.hoveredAudioCall == index
                        ? AppColors.primary
                        : AppColors.colorBgNew,
                    shape: BoxShape.circle),
                height: 50,
                child: Center(
                  child: Icon(
                    size: 20,
                    Icons.call_sharp,
                    color: provider.hoveredAudioCall == index
                        ? Colors.white
                        : Colors.grey,
                  ),
                ),
              ),
            );
          }),
        ),
        const SizedBox(
          width: 10,
        ),
        commonInkWell(
          onTap: () {
            showDialog(
                barrierDismissible: false,
                context: context,
                builder: (BuildContext context) {
                  return  CustomAlertDialog(
                    content: AdminPatientDetailsView(patientID: patientID??'',),
                  );
                });
          },
          child: Consumer<AdminDashboardProvider>(
              builder: (context, provider, child) {
            return MouseRegion(
              onEnter: (_) {
                provider.setHoveredEdit(index);
              },
              onExit: (_) {
                provider.setHoveredEdit(null);
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                margin: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                    color: provider.hoveredEdit == index
                        ? AppColors.primary
                        : AppColors.colorBgNew,
                    borderRadius: BorderRadius.circular(8)),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20.0, right: 20),
                    child: isMobile
                        ? const Icon(Icons.remove_red_eye_outlined)
                        : CommonTextWidget(
                            textColor: provider.hoveredEdit == index
                                ? Colors.white
                                : null,
                            text: "View Profile",
                            fontWeight: FontWeight.w600,
                          ),
                  ),
                ),
              ),
            );
          }),
        ),
      ],
    );
  }
}
