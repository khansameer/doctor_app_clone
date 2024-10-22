import 'package:doctor_app/core/color_utils.dart';
import 'package:doctor_app/core/colors.dart';
import 'package:doctor_app/core/common/common_text_widget.dart';
import 'package:doctor_app/provider/dashboard_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AdminSettingScreen extends StatefulWidget {
  const AdminSettingScreen({super.key});

  @override
  State<AdminSettingScreen> createState() => _AdminSettingScreenState();
}

class _AdminSettingScreenState extends State<AdminSettingScreen> {
  List<Map<String, dynamic>> outerList = [
    {'title': '', 'items': ['Invoice', 'Clinic Address', 'Notification']},

  ];

  int selectedOuterIndex = 0;
  int selectedInnerIndex = 0;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    return  Consumer<DashboardProvider>(
      builder: (context, provider, child) {
        return Container(
          color: Colors.white,
          width: size.width,
          padding: const EdgeInsets.all(0),
          height: size.height,
          child: ListView(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                      flex: 1,
                      child: Container(
                        height: size.height,

                        decoration: const BoxDecoration(
                          color: colorBG,
                        ),
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: outerList.length, // Number of outer list items
                          itemBuilder: (context, outerIndex) {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Outer list title
                                // Inner ListView
                                ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: outerList[outerIndex]['items'].length,
                                  itemBuilder: (context, innerIndex) {
                                    bool isSelected = selectedOuterIndex == outerIndex && selectedInnerIndex == innerIndex;
                                    return GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          provider.setAdminSettingPagePage = '${outerList[outerIndex]['items'][innerIndex]}';
                                          print('======${innerIndex}');
                                          print('======${outerList[outerIndex]['items'][innerIndex]}');
                                          selectedOuterIndex = outerIndex;
                                          selectedInnerIndex = innerIndex;
                                          //selectedInnerIndex[outerIndex] = innerIndex;
                                        });
                                      },
                                      child: Container(
                                        color: isSelected ? AppColors.primary.withOpacity(0.50) : colorBG,
                                        padding: const EdgeInsets.all(10.0),
                                        child: CommonTextWidget(
                                            textColor: isSelected?Colors.white:null,
                                            text:
                                            outerList[outerIndex]['items'][innerIndex],
                                            fontSize: 12
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            );
                          },
                        ),
                      )),

                 Expanded(
                    flex: 8,
                    child: SizedBox(
                      height: size.height,
                      child: provider.currentAdminSettingPage,
                    ),
                  )


                ],
              )
            ],
          ),

        );
      }
    );
  }
}
