import 'package:doctor_app/core/colors.dart';
import 'package:doctor_app/core/common/custom_alert_dialog.dart';

import 'package:doctor_app/core/common/common_text_widget.dart';
import 'package:doctor_app/core/component/component.dart';
import 'package:doctor_app/core/image/image_path.dart';
import 'package:doctor_app/core/responsive.dart';
import 'package:doctor_app/provider/dashboard_provider.dart';
import 'package:doctor_app/provider/patient_provider.dart';
import 'package:doctor_app/screen/web_view/admin_dashboard_view/chat/web_chat_screen.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'admin_patient_details_view.dart';

class AdminAllListScreen extends StatefulWidget {
  const AdminAllListScreen({super.key, this.title});

  final String? title;

  @override
  State<AdminAllListScreen> createState() => _AdminAllListScreenState();
}

class _AdminAllListScreenState extends State<AdminAllListScreen> {
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
        context.read<PatientProvider>().clearFilter();
      } else if (widget.title == "all_male") {
        context.read<PatientProvider>().filterByGender("male");
      } else if (widget.title == "all_female") {
        context.read<PatientProvider>().filterByGender("female");
      }
    });
    var isMobile = Responsive.isMobile(context);
    return Consumer<PatientProvider>(builder: (context, provider, child) {
      return Stack(
        children: [
          ListView(
            children: [
              Column(
                children: [
                  Container(
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
                  ListView.builder(
                      shrinkWrap: true,
                      itemCount: provider.patients?.length ?? 0,
                      itemBuilder: (context, index) {
                        var data = provider.patients?[index];
                        return Container(
                          decoration: BoxDecoration(
                              color: AppColors.colorListView,
                              borderRadius: BorderRadius.circular(8)),
                          margin: const EdgeInsets.all(10),
                          padding: const EdgeInsets.all(15),
                          child: ListTile(
                            titleAlignment: ListTileTitleAlignment.threeLine,
                            contentPadding: EdgeInsets.zero,
                            trailing: isMobile
                                ? SizedBox.shrink()
                                : _viewButtonView(isMobile: isMobile),
                            leading: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: setAssetImage(
                                width: 50,
                                height: 50,
                                fit: BoxFit.cover,
                                image: icDummyUser,
                              ) /*commonImageNetworkWidget(path: provider.patients[index].photo)*/,
                            ),
                            title: CommonTextWidget(
                              text:
                                  '${data?.firstName.toString()} ${data?.lastName.toString()}(${data?.gender.toString().toUpperCase()[0]})',
                              fontWeight: FontWeight.w700,
                              fontSize: 15,
                            ),
                            subtitle: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CommonTextWidget(
                                  text: "28 years",
                                  top: 5,
                                  fontSize: 13,
                                ),
                                isMobile
                                    ? _viewButtonView(isMobile: isMobile)
                                    : SizedBox.shrink()
                              ],
                            ),
                          ),
                        );
                      }),
                ],
              ),
            ],
          ),
          provider.isAdding ? showLoaderList() : const SizedBox.shrink()
        ],
      );
    });
  }

  _viewButtonView({required bool isMobile}) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        commonInkWell(
          onTap: () {
            //  chatModel.chatUserInfoValue(data);
            showDialog(
                barrierDismissible: false,
                context: context,
                builder: (BuildContext context) {
                  return const CustomAlertDialog(
                    content: WebChatScreen(
                      communication: false,
                    ),
                  );
                });
          },
          child: Container(
            width: 50,
            height: 50,
            decoration: const BoxDecoration(
                color: Colors.white, shape: BoxShape.circle),
            child: const Center(
              child: Icon(
                Icons.chat,
                size: 20,
                color: Colors.grey,
              ),
            ),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Flexible(
          child: Container(
            alignment: Alignment.topLeft,
            width: 50,
            decoration: const BoxDecoration(
                color: Colors.white, shape: BoxShape.circle),
            height: 50,
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
        commonInkWell(
          onTap: () {
            showDialog(
                barrierDismissible: false,
                context: context,
                builder: (BuildContext context) {
                  return const CustomAlertDialog(
                    content: AdminPatientDetailsView(),
                  );
                });
          },
          child: Container(
            margin: const EdgeInsets.all(5),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(8)),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20),
                child: isMobile
                    ? Icon(Icons.remove_red_eye_outlined)
                    : CommonTextWidget(
                        text: "View Profile",
                        fontWeight: FontWeight.w600,
                      ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}