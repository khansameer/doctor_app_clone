import 'package:doctor_app/core/colors.dart';
import 'package:doctor_app/core/common/common_drop_down_view.dart';
import 'package:doctor_app/core/common/common_text_widget.dart';
import 'package:doctor_app/core/component/component.dart';
import 'package:doctor_app/core/image/image_path.dart';
import 'package:doctor_app/provider/dashboard_provider.dart';
import 'package:doctor_app/provider/report_provier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AdminFeedbackScreen extends StatefulWidget {
  const AdminFeedbackScreen({super.key});

  @override
  State<AdminFeedbackScreen> createState() => _AdminFeedbackScreenState();
}

class _AdminFeedbackScreenState extends State<AdminFeedbackScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<DashboardProvider>().getUserName();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    return SizedBox(
      width: size.width,
      height: size.height,
      child: ListView(
        children: [
          CommonTextWidget(
            letterSpacing: 1,
            text: "Which Doctor's feedback do you wish to view",
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            width: size.width,
            height: size.height,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(8)),
            padding: const EdgeInsets.all(0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 15.0, top: 10),
                  child: CommonTextWidget(
                    text: "Me",
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: AppColors.colorBgNew.withValues(alpha: 0.4),
                      borderRadius: BorderRadius.circular(8)),
                  child: ListTile(
                    title: CommonTextWidget(
                      fontWeight: FontWeight.w600,
                      text: context.read<DashboardProvider>().name,
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.thumb_up,
                            size: 15,
                            color: Colors.green,
                          ),
                          CommonTextWidget(
                            text: "99%",
                            left: 5,
                            textColor: Colors.green,
                            fontWeight: FontWeight.w700,
                          ),
                          CommonTextWidget(
                            text: "(377 Votes)",
                            left: 2,
                            textColor: Colors.grey,
                            fontWeight: FontWeight.w400,
                          )
                        ],
                      ),
                    ),
                    trailing: Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.message_rounded,
                            size: 18,
                            color: Colors.black,
                          ),
                          CommonTextWidget(
                            text: "72 feedback",
                            left: 2,
                            fontSize: 13,
                            textColor: Colors.black,
                            fontWeight: FontWeight.w500,
                          )
                        ],
                      ),
                    ),
                    leading: commonProfileIcon(
                        width: 40, path: icDummyUser, height: 40),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0, top: 0),
                      child: CommonTextWidget(
                        text: "Other from",
                        textColor: Colors.grey,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    SizedBox(
                      width: size.width * 0.14,
                      child: Consumer<ReportProvider>(
                          builder: (context, provider, child) {
                        return CommonDropDownView(
                            hint: "All Center",
                            height: 35,
                            horizontal: 10,
                            onChanged: (value) {
                              provider.setSelectData = value.toString();
                            },
                            selectedValue: provider.selectedValue,
                            borerColor: Colors.grey,
                            size: size,
                            items: provider.topMedicalCallCenters);
                      }),
                    )
                  ],
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: AppColors.colorBgNew.withValues(alpha: 0.4),
                      borderRadius: BorderRadius.circular(8)),
                  child: ListTile(
                    title: CommonTextWidget(
                      fontWeight: FontWeight.w600,
                      text: "Emily Davis",
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.thumb_up,
                            size: 15,
                            color: Colors.green,
                          ),
                          CommonTextWidget(
                            text: "89%",
                            left: 5,
                            textColor: Colors.green,
                            fontWeight: FontWeight.w700,
                          ),
                          CommonTextWidget(
                            text: "(156 Votes)",
                            left: 2,
                            textColor: Colors.grey,
                            fontWeight: FontWeight.w400,
                          )
                        ],
                      ),
                    ),
                    trailing: Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.message_rounded,
                            size: 18,
                            color: Colors.black,
                          ),
                          CommonTextWidget(
                            text: "28 feedback",
                            left: 2,
                            fontSize: 13,
                            textColor: Colors.black,
                            fontWeight: FontWeight.w500,
                          )
                        ],
                      ),
                    ),
                    leading: commonProfileIcon(
                        width: 40, path: icPatientUser3, height: 40),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
