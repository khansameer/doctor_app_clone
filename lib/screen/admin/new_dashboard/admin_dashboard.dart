import 'package:doctor_app/core/app_constants.dart';
import 'package:doctor_app/core/colors.dart';
import 'package:doctor_app/core/common/CustomAlertDialog.dart';
import 'package:doctor_app/core/common/common_button_widget.dart';
import 'package:doctor_app/core/common/common_text_widget.dart';
import 'package:doctor_app/core/common/error_page.dart';
import 'package:doctor_app/core/component/component.dart';
import 'package:doctor_app/core/image/image_path.dart';
import 'package:doctor_app/core/responsive.dart';
import 'package:doctor_app/core/route/route.dart';
import 'package:doctor_app/provider/dashboard_provider.dart';
import 'package:doctor_app/screen/admin/new_dashboard/calender_new_screen.dart';
import 'package:doctor_app/screen/admin/new_dashboard/patient_new_screen.dart';
import 'package:doctor_app/screen/admin/setting/admin_setting_screen.dart';
import 'package:doctor_app/screen/dashboard/profile/edit_profile_screen.dart';
import 'package:doctor_app/screen/dashboard/profile/profile_screen.dart';
import 'package:doctor_app/shared_preferences/preference_helper.dart';
import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  PageController pageController = PageController();
  SideMenuController sideMenu = SideMenuController();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<DashboardProvider>().getUserName();
    });
    sideMenu.addListener((index) {
      context.read<DashboardProvider>().pageController.jumpToPage(index);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var isMobile = Responsive.isMobile(context);
    var isDesktop = Responsive.isDesktop(context);

    return Consumer<DashboardProvider>(builder: (context, provider, child) {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          toolbarHeight: 86,
          actions: [
            Container(
              width: thirtyFive,
              height: thirtyFive,
              clipBehavior: Clip.antiAlias,
              decoration: commonBoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.grey, width: one)),
              child: loadAssetImage(path: icDoctorWidget),
            ),
            const SizedBox(
              width: ten,
            ),
            PopupMenuButton<int>(
              color: Colors.white,
              constraints: const BoxConstraints.tightFor(width: twoHundred),
              elevation: zero,
            //  tooltip: "profile",
              offset: const Offset(zero, thirty),
              onSelected: (value) {

              },
              itemBuilder: (context) => [],
              child: commonInkWell(
                onTap: (){
                  provider.updatePageValue(11);
                },
                child: Row(
                  children: [
                    CommonTextWidget(
                        text: provider.name ?? "", textColor: Colors.white),
                    const Icon(
                      Icons.keyboard_arrow_down_sharp,
                      color: Colors.white,
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(
              width: ten,
            ),
          ],
          leadingWidth: isMobile ? 100 : 200,

          iconTheme: const IconThemeData(color: Colors.white),
          //leading: const SizedBox.shrink(),
          leading: const ImageIcon(
              size: 500,
              AssetImage(
                icLogoApps,
              )),
          backgroundColor: AppColors.colorDrawer,
        ),
        body: Row(
          children: [
            SideMenu(
              controller: sideMenu,

              style: SideMenuStyle(
                openSideMenuWidth: isMobile?0:250,
                itemHeight: 60,
                itemBorderRadius: BorderRadius.circular(0),
                itemOuterPadding: EdgeInsets.zero,
                itemInnerSpacing: 5,
                displayMode: SideMenuDisplayMode.auto,
                showHamburger: isMobile ? true : false,
                arrowCollapse: Colors.white,
                unselectedIconColorExpandable: Colors.white.withOpacity(0.50),
                selectedIconColorExpandable: Colors.white.withOpacity(0.50),
                unselectedIconColor: Colors.white.withOpacity(0.50),
                unselectedTitleTextStyle: commonTextStyle(
                    color: Colors.white.withOpacity(0.50),
                    fontSize: 13,
                    fontWeight: FontWeight.w600),
                selectedTitleTextStyleExpandable: commonTextStyle(
                    color: Colors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.w600),
                hoverColor: Colors.white.withOpacity(0.10),
                selectedHoverColor: Colors.white.withOpacity(0.10),
                selectedColor: Colors.white.withOpacity(0.50),
                selectedTitleTextStyle: commonTextStyle(
                    color: Colors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.w600),
                selectedIconColor: Colors.white,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  border: Border.all(
                      color: Colors.white.withOpacity(0.40), width: 1),
                  borderRadius: const BorderRadius.all(Radius.circular(0)),
                ),
                // backgroundColor: Colors.grey[200]
              ),
              items: [
                SideMenuItem(
                  title: 'Calender',
                  onTap: (index, _) {
                    provider.updatePageValue(1);
                    sideMenu.changePage(index); // Navigate to Calendar page
                    // sideMenu.changePage(index);
                  },
                  icon: const Icon(Icons.calendar_month_sharp),
                  tooltipContent: "This is a tooltip for Dashboard item",
                ),
                commonMenuDivider(),
                SideMenuItem(
                  title: 'Patients',
                  onTap: (index, _) {
                    provider.updatePageValue(2);
                    sideMenu.changePage(index);
                    //    sideMenu.changePage(index);
                  },
                  icon: const Icon(Icons.person),
                ),
                commonMenuDivider(),
                SideMenuItem(
                  title: 'Communications',
                  onTap: (index, _) {
                    provider.updatePageValue(3);
                    sideMenu.changePage(index);
                    //sideMenu.changePage(index);
                  },
                  icon: const Icon(Icons.cell_tower),
                ),
                commonMenuDivider(),
                SideMenuItem(
                  title: 'Reports',
                  onTap: (index, _) {
                    provider.updatePageValue(4);
                    sideMenu.changePage(index);
                    //sideMenu.changePage(index);
                  },
                  icon: const Icon(Icons.auto_graph),
                ),
                commonMenuDivider(),
                SideMenuItem(
                  title: 'Settings',
                  onTap: (index, _) {
                    provider.updatePageValue(5);
                    sideMenu.changePage(index);
                  },
                  icon: const Icon(Icons.settings_outlined),
                ),
                commonMenuDivider(),
                SideMenuItem(
                  title: 'Feedback',
                  onTap: (index, _) {
                    provider.updatePageValue(7);
                    sideMenu.changePage(index);
                  },
                  icon: const Icon(Icons.thumb_up_alt_outlined),
                ),
                commonMenuDivider(),
                SideMenuItem(
                  onTap: (index, _) {
                    showDialog(
                        barrierDismissible: false,
                        context: context,
                        builder: (BuildContext context) {
                          var width = MediaQuery.of(context).size.width;
                          return CustomAlertDialog(
                            content: SizedBox(
                              width: isMobile
                                  ? width * zero9
                                  : isDesktop
                                      ? width * 0.2
                                      : width * 0.19,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        CommonTextWidget(
                                          text:
                                              "Are you sure you want to sign out?",
                                          fontSize: 16,
                                          textAlign: TextAlign.center,
                                          fontWeight: FontWeight.w700,
                                          top: 20,
                                        ),
                                        CommonTextWidget(
                                          text:
                                              "You are also logged out from local data apps open in this browser.",
                                          fontSize: 14,
                                          textAlign: TextAlign.center,
                                          top: 20,
                                        ),
                                        const SizedBox(
                                          height: 50,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            CommonButtonWidget(
                                              onPressed: () async {
                                                await PreferenceHelper.clear();
                                                pushNamedAndRemoveUntil(
                                                    context: context,
                                                    routeName:
                                                        RouteName.loginScreen);
                                              },
                                              colorButton: Colors.red,
                                              fontSize: 12,
                                              padding: const EdgeInsets.only(
                                                  left: 40,
                                                  right: 40,
                                                  top: 10,
                                                  bottom: 10),
                                              text: "Logout",
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            CommonButtonWidget(
                                              text: "Cancel",
                                              colorBorder: Colors.black,
                                              colorButton: Colors.white,
                                              colorText: Colors.black,
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              fontSize: 12,
                                              padding: const EdgeInsets.only(
                                                  left: 40, right: 40),
                                            ),
                                            const SizedBox(
                                              width: 20,
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        });
                    //provider.updatePageValue(8);
                    //   sideMenu.changePage(index);

                    //showCommonDialog(context: context, title: "title", content: "content");
                  },
                  title: 'Logout',
                  icon: const Icon(Icons.exit_to_app),
                ),
              ],
            ),
            const VerticalDivider(
              width: 0,
            ),
            Expanded(
              child: PageView(
                controller: provider.pageController,
                children: const [
                  Padding(
                    padding: EdgeInsets.all(0),
                    child: CalenderNewScreen(),
                  ),
                  SizedBox.shrink(),
                  Padding(
                    padding: EdgeInsets.all(0),
                    child: PatientNewScreen(),
                  ),
                  SizedBox.shrink(),
                  Center(
                    child: ErrorPage(),
                  ),
                  SizedBox.shrink(),
                  Center(
                    child: ErrorPage(),
                  ),
                  SizedBox.shrink(),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: AdminSettingScreen(),
                  ),
                  SizedBox.shrink(),
                  Center(
                    child: ErrorPage(),
                  ),

                  EditProfileScreen(),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }

  commonMenuDivider() {
    return SideMenuItem(
      builder: (context, displayMode) {
        return  Divider(
          height: 0,
          color: Colors.white.withOpacity(0.40),
          endIndent: 0,
          indent: 0,
          thickness: 0.5,
        );
      },
    );
  }
}
