import 'package:doctor_app/core/color_utils.dart';
import 'package:doctor_app/core/colors.dart';
import 'package:doctor_app/core/common/common_text_widget.dart';

import 'package:doctor_app/core/responsive.dart';
import 'package:doctor_app/provider/appointments_provider.dart';
import 'package:doctor_app/provider/dashboard_provider.dart';
import 'package:doctor_app/provider/patient_provider.dart';
import 'package:doctor_app/screen/web_view/admin_dashboard_view/paitent_view/admin_patient_view.dart';
import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PatientNewScreen extends StatefulWidget {
  const PatientNewScreen({super.key});

  @override
  State<PatientNewScreen> createState() => _PatientNewScreenState();
}

class _PatientNewScreenState extends State<PatientNewScreen> {
  int? expandedIndex;
  SideMenuController sideMenu = SideMenuController();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<DashboardProvider>().getUserName();
      context
          .read<PatientProvider>()
          .getPatientDetails(context: context)
          .then((value) {});
    });
    sideMenu.addListener((index) {
      //   pageController.jumpToPage(index);
    });
    super.initState();
  }

  bool isFirstTime = true;
  bool isShowBG = true;

  List<Map<String, dynamic>> outerList = [
    {
      'title': 'Patients',
      'items': [
        'All Patients',
      ]
    },
    /*{
      'title': 'Groups',
      'items': [
        'My Groups',
        'Memberships',
      ]
    },*/
    {
      'title': 'Categories',
      'items': [
        'All Female Customer',
        'All Male Customer',
        'Female Customer Over 30',
        'Female Customer under 30'
      ]
    },
  ];

  int selectedOuterIndex = 0;
  int selectedInnerIndex = 0;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    var isMobile = Responsive.isMobile(context);
    return Consumer<DashboardProvider>(builder: (context, provider, child) {
      return SizedBox(
        width: size.width,
        height: size.height,
        child: ListView(
          children: [
            CommonTextWidget(
              letterSpacing: 1,
              text: "Patients List",
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              width: size.width,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(8)),
              padding: const EdgeInsets.all(0),
              height: size.height,
              child: const Padding(
                padding: EdgeInsets.all(16),
                child: AdminPatientView(),
              ) /*DefaultTabController(length: 2, child: Column(
                children: [
                  Container(
                    color: colorBGWithOpacity, // Background color for the TabBar
                    child:  TabBar(
                      dividerColor: Colors.transparent,
                      labelColor: colorText,
                      labelStyle: commonTextStyle(fontWeight: FontWeight.w700),
                      unselectedLabelColor:colorText,
                      indicatorColor:colorText,
                      tabs: [
                        Tab(text: "Appointment"),
                        Tab(text: "Paitent"),

                      ],
                    ),
                  ),
                  const Expanded(
                    // Content for each tab
                    child: TabBarView(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(16),
                          child: AdminCalenderScreen(),
                        ),
                        Padding(
                          padding: EdgeInsets.all(16),
                          child: AdminPatientView(),
                        ),

                      ],
                    ),
                  ),
                ],
              ))*/
              ,
            ),
          ],
        ),
      );
    });
  }

  _view(
      {required bool isMobile,
      required DashboardProvider provider,
      required Size size}) {
    return ListView(
      children: [
        Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                    flex: isMobile ? 3 : 1,
                    child: Container(
                      height: size.height,
                      decoration: const BoxDecoration(
                        color: colorBG,
                        /*  border: Border.a(vertical: BorderSide(
                              color: Colors.red,width:1
                            ))*/
                      ),
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount:
                            outerList.length, // Number of outer list items
                        itemBuilder: (context, outerIndex) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Outer list title
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CommonTextWidget(
                                  text: outerList[outerIndex]['title'],
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              // Inner ListView
                              ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount:
                                    outerList[outerIndex]['items'].length,
                                itemBuilder: (context1, innerIndex) {
                                  bool isSelected =
                                      selectedOuterIndex == outerIndex &&
                                          selectedInnerIndex == innerIndex;
                                  return GestureDetector(
                                    onTap: () {
                                      provider.setPatientDetailsPage(
                                          context: context,
                                          value:
                                              '${outerList[outerIndex]['items'][innerIndex]}');

                                      selectedOuterIndex = outerIndex;
                                      selectedInnerIndex = innerIndex;
                                    },
                                    child: Container(
                                      color: isSelected
                                          ? AppColors.colorActive
                                          : colorBG,
                                      padding: const EdgeInsets.all(10.0),
                                      child: CommonTextWidget(
                                          textColor:
                                              isSelected ? Colors.white : null,
                                          text: outerList[outerIndex]['items']
                                              [innerIndex],
                                          fontSize: 12),
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
                    child: provider.currentPatientPage,
                  ),
                )
              ],
            )
          ],
        ),
      ],
    );
  }
}
