import 'package:doctor_app/core/app_constants.dart';
import 'package:doctor_app/core/colors.dart';

import 'package:doctor_app/core/common/common_text_widget.dart';
import 'package:doctor_app/core/common/error_page.dart';
import 'package:doctor_app/core/component/component.dart';
import 'package:doctor_app/core/image/image_path.dart';
import 'package:doctor_app/core/responsive.dart';
import 'package:doctor_app/provider/dashboard_provider.dart';
import 'package:doctor_app/screen/web_view/screen/calender/admin_calender_screen.dart';
import 'package:doctor_app/screen/web_view/screen/patient_new_screen.dart';
import 'package:doctor_app/screen/web_view/screen/setting/admin_setting_screen.dart';

import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../admin_dashboard_view/admin_dashboard_view.dart';
import '../../admin_dashboard_view/communication_screen.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  PageController pageControllerDashBoard = PageController();
  SideMenuController sideMenu = SideMenuController();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<DashboardProvider>().getUserName();
    });
    sideMenu.addListener((index) {
      pageControllerDashBoard.jumpToPage(index);
    });
    super.initState();
  }

  @override
  void dispose() {
    pageControllerDashBoard.dispose();
    sideMenu.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var isMobile = Responsive.isMobile(context);
    var isDesktop = Responsive.isDesktop(context);
    var size = MediaQuery.sizeOf(context);

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
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  width: thirtyFive,
                  height: thirtyFive,
                  clipBehavior: Clip.antiAlias,
                  decoration: commonBoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white,
                  ),
                  child: const Icon(
                    Icons.notifications_none,
                    color: AppColors.colorTextNew,
                    size: 18,
                  ),
                ),
                Positioned(
                    right: 0,
                    top: -5,
                    child: Container(
                      width: 12,
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color.fromARGB(255, 244, 147, 43)),
                      height: 12,
                    )),
              ],
            ),
            const SizedBox(
              width: 10,
            ),
            SizedBox(
              width: thirtyFive,
              height: thirtyFive,
              child: commonProfileIcon(path: icDummyUser),
            ),
            const SizedBox(
              width: 10,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CommonTextWidget(
                    text: provider.name ?? "",
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    textColor: AppColors.colorText),
                CommonTextWidget(
                    text: "Cardiologist",
                    fontSize: 12,
                    textColor: AppColors.colorText),
              ],
            ),
            const SizedBox(
              width: 40,
            ),
            PopupMenuButton<int>(
              color: Colors.white,
              constraints: const BoxConstraints.tightFor(width: twoHundred),
              elevation: zero,
              offset: const Offset(zero, thirty),
              onSelected: (value) {},
              itemBuilder: (context) => [],
              child: commonInkWell(
                onTap: () {},
                child: const Icon(
                  Icons.keyboard_arrow_down_sharp,
                  color: Colors.grey,
                ),
              ),
            ),
            const SizedBox(
              width: 30,
            ),
          ],
          leadingWidth: isMobile ? 100 : 130,
          iconTheme: const IconThemeData(color: Colors.white),
          leading: const ImageIcon(
              size: 500,
              color: AppColors.colorActive,
              AssetImage(
                icLogoApps,
              )),
          backgroundColor: AppColors.colorBgNew,
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
                //for sub Menu
                //arrowCollapse: Colors.black,
                // arrowOpen: Colors.black,
                // toggleColor: Colors.black,
                //     unselectedIconColorExpandable: AppColors.colorText,
                //    selectedIconColorExpandable: Colors.red,

                //===
                //  unselectedIconColor: AppColors.colorText,
                unselectedTitleTextStyle: commonTextStyle(
                    color: AppColors.colorMenuUnSelectedText,
                    fontSize: 14,
                    fontWeight: FontWeight.w500),
                /*   selectedTitleTextStyleExpandable: commonTextStyle(
                    color: AppColors.colorBlue,
                    fontSize: 14,
                    fontWeight: FontWeight.w500),*/
                //hoverColor: AppColors.colorHover,
                //selectedHoverColor: AppColors.colorHover,
                selectedColor: AppColors.colorBgNew,
                selectedTitleTextStyle: commonTextStyle(
                    color: AppColors.colorBlue,
                    fontSize: 14,
                    fontWeight: FontWeight.w600),
                selectedIconColor: AppColors.colorBlue,
                decoration: BoxDecoration(
                  color: AppColors.colorBgNew,
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 10.0,
                    ),
                  ],
                  border: Border.all(color: AppColors.colorBgNew, width: 1),
                  borderRadius: const BorderRadius.all(Radius.circular(0)),
                ),
                // backgroundColor: Colors.grey[200]
              ),
              items: [
                SideMenuItem(
                  title: 'Dashboard',
                  onTap: (index, _) {
                    sideMenu.changePage(index); // Navigate to Calendar page
                  },
                  icon: const Icon(Icons.calendar_month_sharp),
                  tooltipContent: "This is a tooltip for Dashboard item",
                ),
                SideMenuItem(
                  title: 'Appointment',
                  onTap: (index, _) {
                    sideMenu.changePage(index);
                  },
                  icon: const Icon(Icons.calendar_month_sharp),
                  tooltipContent: "This is a tooltip for Dashboard item",
                ),
                commonMenuDivider(),
                SideMenuItem(
                  title: 'Patients',
                  onTap: (index, _) {
                    sideMenu.changePage(index);
                  },
                  icon: const Icon(Icons.person),
                ),
                commonMenuDivider(),
                SideMenuItem(
                  title: 'Communications',
                  onTap: (index, _) {
                    sideMenu.changePage(index);
                  },
                  icon: const Icon(Icons.cell_tower),
                ),
                commonMenuDivider(),
                SideMenuItem(
                  title: 'Reports',
                  onTap: (index, _) {
                    sideMenu.changePage(index);
                  },
                  icon: const Icon(Icons.auto_graph),
                ),
                commonMenuDivider(),
                SideMenuItem(
                  title: 'Settings',
                  onTap: (index, _) {
                    sideMenu.changePage(index);
                  },
                  icon: const Icon(Icons.settings_outlined),
                ),
                commonMenuDivider(),
                SideMenuItem(
                  title: 'Feedback',
                  onTap: (index, _) {
                    sideMenu.changePage(index);
                  },
                  icon: const Icon(Icons.thumb_up_alt_outlined),
                ),
                commonMenuDivider(),
                SideMenuItem(
                  onTap: (index, _) {
                    commonLogoutDialog(
                        width: isMobile ? size.width * zero9 : size.width * 0.3,
                        contextAd: context,
                        isDesktop: isDesktop,
                        isMobile: isMobile);
                  },
                  title: 'Logout',
                  icon: const Icon(Icons.exit_to_app),
                ),
              ],
            ),
            const VerticalDivider(
              color: AppColors.colorBgNew,
              width: 2,
            ),
            Expanded(
              child: Container(
                color: AppColors.colorBgNew,
                child: PageView(
                  controller: pageControllerDashBoard,
                  children: const [
                    Padding(
                      padding: EdgeInsets.all(16),
                      child: AdminDashboardView(),
                    ),
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
                        child: CommunicationScreen(),
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

                    Padding(
                      padding: EdgeInsets.all(16),
                      child: Center(
                        child: ErrorPage(),
                      ),
                    ),
                    // EditProfileScreen(),
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
          color: AppColors.colorBgNew,
          // color: Colors.white,
          endIndent: 8,
          indent: 0,
          thickness: 0.5,
        );
      },
    );
  }
}
