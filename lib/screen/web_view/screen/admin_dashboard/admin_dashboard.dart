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
import 'package:doctor_app/screen/web_view/screen/calender/admin_calender_screen.dart';
import 'package:doctor_app/screen/web_view/screen/patient_new_screen.dart';
import 'package:doctor_app/screen/web_view/screen/setting/admin_setting_screen.dart';

import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../shared_preferences/preference_helper.dart';
import '../../../mobile_view/profile/edit_profile_screen.dart';

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
  void dispose() {
    pageController.dispose();
    sideMenu.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var isMobile = Responsive.isMobile(context);
    var isDesktop = Responsive.isDesktop(context);

    return Consumer<DashboardProvider>(builder: (context, provider, child) {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          bottom: PreferredSize(
              preferredSize: const Size.fromHeight(4.0),
              child: Container(
                color: AppColors.colorMenuBG,
                height: 1.0,
              )),
          centerTitle: true,
          elevation: 0,
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
              onSelected: (value) {},
              itemBuilder: (context) => [],
              child: commonInkWell(
                onTap: () {
                  provider.updatePageValue(11);
                },
                child: Row(
                  children: [
                    CommonTextWidget(
                        text: provider.name ?? "",
                        textColor: AppColors.colorText),
                    const Icon(
                      Icons.keyboard_arrow_down_sharp,
                      color: AppColors.colorText,
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(
              width: ten,
            ),
          ],
          leadingWidth: isMobile ? 100 : 130,

          iconTheme: const IconThemeData(color: Colors.white),
          //leading: const SizedBox.shrink(),
          leading: const ImageIcon(
              size: 500,
              color: AppColors.colorActive,
              AssetImage(
                icLogoApps,
              )),
          backgroundColor: Colors.white,
        ),
        body: Row(
          children: [
            SideMenu(
              controller: sideMenu,
              style: SideMenuStyle(
                openSideMenuWidth: isMobile ? 0 : 210,
                itemHeight: 48,
                itemBorderRadius: BorderRadius.circular(4),
                itemOuterPadding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                itemInnerSpacing: 8,

                displayMode: SideMenuDisplayMode.auto,
                showHamburger: isMobile ? true : false,
                arrowCollapse: Colors.white,
                unselectedIconColorExpandable: AppColors.colorText,
                selectedIconColorExpandable: Colors.white,
                unselectedIconColor: AppColors.colorText,
                unselectedTitleTextStyle: commonTextStyle(
                    color: AppColors.colorText,
                    fontSize: 14,
                    fontWeight: FontWeight.w600),
                selectedTitleTextStyleExpandable: commonTextStyle(
                    color: AppColors.colorText,
                    fontSize: 14,
                    fontWeight: FontWeight.w600),
                hoverColor: AppColors.colorHover,
                selectedHoverColor: AppColors.colorHover,
                selectedColor: AppColors.colorActive,
                selectedTitleTextStyle: commonTextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600),
                selectedIconColor: Colors.white,
                decoration: BoxDecoration(
                  color: Colors.white,
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
                    commonLogoutDialog(
                        context: context,
                        isDesktop: isDesktop,
                        isMobile: isDesktop);
                  },
                  title: 'Logout',
                  icon: const Icon(Icons.exit_to_app),
                ),
              ],
            ),
            const VerticalDivider(
              color: AppColors.colorStock,
              width: 1,
            ),
            Expanded(
              child: Container(
                color: AppColors.colorBackground,
                child: PageView(
                  controller: provider.pageController,
                  children: const [
                    Padding(
                      padding: EdgeInsets.all(16),
                      child: AdminCalenderScreen(),
                    ),
                    SizedBox.shrink(),
                    Padding(
                      padding: EdgeInsets.all(16),
                      child: PatientNewScreen(),
                    ),
                    SizedBox.shrink(),
                    Padding(
                      padding: EdgeInsets.all(16),
                      child: Center(
                        child: ErrorPage(),
                      ),
                    ),
                    SizedBox.shrink(),
                    Padding(
                      padding: EdgeInsets.all(16),
                      child: Center(
                        child: ErrorPage(),
                      ),
                    ),
                    SizedBox.shrink(),
                    Padding(
                      padding: EdgeInsets.all(16.0),
                      child: AdminSettingScreen(),
                    ),
                    SizedBox.shrink(),
                    Padding(
                      padding: EdgeInsets.all(16),
                      child: Center(
                        child: ErrorPage(),
                      ),
                    ),
                    EditProfileScreen(),
                  ],
                ),
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
        return const Divider(
          height: 0,
          //  color: AppColors.colorMenuBG,
          color: Colors.white,
          endIndent: 8,
          indent: 0,
          thickness: 0.5,
        );
      },
    );
  }
}
