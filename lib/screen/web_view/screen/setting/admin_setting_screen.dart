import 'package:doctor_app/core/colors.dart';
import 'package:doctor_app/core/common/common_text_widget.dart';
import 'package:doctor_app/core/common/error_page.dart';
import 'package:doctor_app/core/component/component.dart';
import 'package:doctor_app/core/responsive.dart';
import 'package:doctor_app/provider/dashboard_provider.dart';
import 'package:doctor_app/screen/web_view/admin_dashboard_view/my_address/my_address_screen.dart';
import 'package:doctor_app/screen/web_view/admin_dashboard_view/notification/notification_setting_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../mobile_view/profile/edit_profile_screen.dart';
import '../../admin_dashboard_view/prescription/setting_prescription_screen.dart';

class AdminSettingScreen extends StatefulWidget {
  const AdminSettingScreen({super.key});

  @override
  State<AdminSettingScreen> createState() => _AdminSettingScreenState();
}

class _AdminSettingScreenState extends State<AdminSettingScreen> {
  List<Map<String, dynamic>> outerList = [
    {
      'title': '',
      'items': [
        // 'Procedure Catalog',
        'Clinic Address',
        'Notification',
        'Consent Forms',
        'Billing',
        // 'EMR',
        'Prescriptions',
        'Calendar',
        'Communications',
        'Contacts',
        // 'Email PDF Settings',
        // 'Medical History'
        'My Profile',
      ]
    },
  ];

  int selectedOuterIndex = 0;
  int selectedInnerIndex = 0;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<DashboardProvider>().getUserName();
      context.read<DashboardProvider>().getEmail();
    });
  }

  getDoctorData() async {}

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    var isMobile = Responsive.isMobile(context);
    var isTablet = Responsive.isTablet(context);
    return Consumer<DashboardProvider>(builder: (context, provider, child) {
      return Container(
        color: Colors.white,
        width: size.width,
        padding: const EdgeInsets.all(0),
        height: size.height,
        child: DefaultTabController(
          length: 9,
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
                      Tab(text: 'Clinic Address'),
                      Tab(text: 'Notification'),
                      Tab(text: 'Consent Forms'),
                      Tab(text: 'Billing'),
                      Tab(text: 'Prescriptions'),
                      Tab(text: 'Calender'),
                      Tab(text: 'Communications'),
                      Tab(text: 'Contacts'),
                      Tab(text: 'My Profile'),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    const MyAddressScreen(),
                    const NotificationSettingScreen(),
                    const ErrorPage(),
                    const ErrorPage(),
                    const SettingPrescriptionScreen(),
                    const ErrorPage(),
                    const ErrorPage(),
                    const ErrorPage(),
                    const EditProfileScreen()
                  ],
                ),
              ),
              /* Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                      flex: isMobile ? 3 :isTablet?3:1,
                      child: Container(
                        padding: EdgeInsets.zero,
                        height: size.height,
                        decoration: const BoxDecoration(
                          color: AppColors.colorBG,
                        ),
                        child: Column(
                          children: [
                            */ /* Container(
                                padding: const EdgeInsets.all(20),
                              child:  Column(

                                children: [
                                  const Stack(
                                      alignment: Alignment.center,
                                      children: [

                                        Align(
                                            alignment: Alignment.topCenter,
                                            child: SizedBox(
                                              child: CircleAvatar(
                                                radius: 40.0,
                                                backgroundColor: Colors.white,
                                                child: CircleAvatar(
                                                  radius: 38.0,
                                                  backgroundImage: AssetImage(icDoctorWidget),
                                                  child: Align(
                                                    alignment: Alignment.bottomRight,
                                                    child: CircleAvatar(
                                                      backgroundColor: Colors.white,
                                                      radius: 12.0,
                                                      child: Icon(
                                                        Icons.camera_alt,
                                                        size: 15.0,
                                                        color: Color(0xFF404040),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),)
                                        ),
                                      ]
                                  ),
                                  CommonTextWidget(text:  provider.name ?? "",fontSize: 14,fontWeight: FontWeight.w600,top: 10,),
                                  CommonTextWidget(text: provider.email ?? "",fontSize: 12,top: 5,),
                                  CommonButtonWidget(text: "Edit",left: 40,right: 40,fontSize: 11,radius: 5,height: 30,top: 15,)
                                ],
                              ),
                              ),
                              const Divider(thickness: 0.3,),
          */ /*
                            ListView.builder(
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              itemCount: outerList.length,
                              // Number of outer list items
                              itemBuilder: (context, outerIndex) {
                                return Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ListView.builder(
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemCount:
                                          outerList[outerIndex]['items'].length,
                                      itemBuilder: (context, innerIndex) {
                                        bool isSelected =
                                            selectedOuterIndex == outerIndex &&
                                                selectedInnerIndex == innerIndex;
                                        return GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              provider.setAdminSettingPagePage =
                                                  '${outerList[outerIndex]['items'][innerIndex]}';

                                              selectedOuterIndex = outerIndex;
                                              selectedInnerIndex = innerIndex;
                                              //selectedInnerIndex[outerIndex] = innerIndex;
                                            });
                                          },
                                          child: Container(
                                            color: isSelected
                                                ? AppColors.colorGreen
                                                : AppColors.colorBG,
                                            padding: const EdgeInsets.all(10.0),
                                            child: CommonTextWidget(
                                                textColor: isSelected
                                                    ? Colors.white
                                                    : null,
                                                text: outerList[outerIndex]
                                                    ['items'][innerIndex],
                                                fontSize: 12),
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                );
                              },
                            ),
                          ],
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
              )*/
            ],
          ),
        ),
      );
    });
  }
}
