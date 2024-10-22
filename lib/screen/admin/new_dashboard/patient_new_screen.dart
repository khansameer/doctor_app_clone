import 'package:doctor_app/core/color_utils.dart';
import 'package:doctor_app/core/colors.dart';
import 'package:doctor_app/core/common/common_button_widget.dart';
import 'package:doctor_app/core/common/common_text_widget.dart';
import 'package:doctor_app/core/component/component.dart';
import 'package:doctor_app/provider/calender_provider.dart';
import 'package:doctor_app/provider/dashboard_provider.dart';
import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PatientNewScreen extends StatefulWidget {
  const PatientNewScreen({super.key});

  @override
  State<PatientNewScreen> createState() => _PatientNewScreenState();
}

class _PatientNewScreenState extends State<PatientNewScreen> {
  final bool _isExpanded = false;

  int? expandedIndex;
  PageController pageController = PageController();
  SideMenuController sideMenu = SideMenuController();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<DashboardProvider>().getUserName();
      context.read<CalenderProvider>().getPatientDetails().then((value) {
        setState(() {});
      });
    });
    sideMenu.addListener((index) {
      pageController.jumpToPage(index);
    });
    super.initState();
  }
  bool isFirstTime = true;
  bool isShowBG = true;

  List<Map<String, dynamic>> outerList = [
    {'title': 'Patients', 'items': ['All Patients', 'Recently Visited', 'Recently Added']},
    {'title': 'Groups', 'items': ['My Groups', 'Memberships',]},
    {'title': 'Smart Group', 'items': ['All Female Customer', 'All Male Customer', 'Female Customer Over 30','Female Customer under 30']},

  ];

  int selectedOuterIndex = 0;
  int selectedInnerIndex = 0;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    return Consumer<DashboardProvider>(builder: (context, provider, child) {
      return Container(
        color: Colors.white,
        width: size.width,
        padding: const EdgeInsets.all(0),
        height: size.height,
        child: ListView(
          children: [
            Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  padding: const EdgeInsets.all(7),
                  color: Colors.grey.withOpacity(0.10),
                  child: Row(
                    children: [
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                commonText(
                                    text: "Patient",
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600),
                                commonText(
                                  left: 10,
                                  color: Colors.grey,
                                  text: "Clear Vision Eye Clinic",
                                  fontSize: 12,
                                ),
                                const Icon(
                                  Icons.keyboard_arrow_down_sharp,
                                  color: Colors.grey,
                                )
                              ],
                            ),

                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(7.0),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.person,
                        color: AppColors.colorMenuProfile,
                      ),
                      commonText(
                          left: 5,
                          text: "All Patients",
                          color: AppColors.colorMenuProfile,
                          fontWeight: FontWeight.w600),
                    ],
                  ),
                ),
                const Divider(
                  thickness: 0.3,
                ),
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
                          /*  border: Border.a(vertical: BorderSide(
                              color: Colors.red,width:1
                            ))*/
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
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: CommonTextWidget(

                                      text:outerList[outerIndex]['title'],
                                   fontSize: 16, fontWeight: FontWeight.bold,
                                    ),
                                  ),

                                  // Inner ListView
                                  ListView.builder(
                                    shrinkWrap: true,
                                    physics: const NeverScrollableScrollPhysics(),
                                    itemCount: outerList[outerIndex]['items'].length,
                                    itemBuilder: (context1, innerIndex) {
                                      bool isSelected = selectedOuterIndex == outerIndex && selectedInnerIndex == innerIndex;
                                      return GestureDetector(
                                        onTap: () {
                                          setState(() {

                                            provider.setPatientDetailsPage(
                                              context: context,
                                              value: '${outerList[outerIndex]['items'][innerIndex]}'
                                            );
                                           // provider.setPatientDetailsPage() = '${outerList[outerIndex]['items'][innerIndex]}';
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
                        child: provider.currentPatientPage,
                      ),
                    )

                  ],
                )
              ],
            ),
          ],
        ),
      );
    });
  }


}

