import 'package:doctor_app/core/app_constants.dart';
import 'package:doctor_app/core/colors.dart';

import 'package:doctor_app/core/common/common_text_widget.dart';
import 'package:doctor_app/core/common/error_page.dart';
import 'package:doctor_app/core/component/component.dart';
import 'package:doctor_app/core/image/image_path.dart';
import 'package:doctor_app/core/responsive.dart';
import 'package:doctor_app/provider/dashboard_provider.dart';
import 'package:doctor_app/screen/web_view/admin_dashboard_view/admin_dashboard_view.dart';
import 'package:doctor_app/screen/web_view/admin_dashboard_view/communication_screen.dart';
import 'package:doctor_app/screen/web_view/screen/calender/admin_calender_screen.dart';
import 'package:doctor_app/screen/web_view/screen/patient_new_screen.dart';
import 'package:doctor_app/screen/web_view/screen/setting/admin_setting_screen.dart';

import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../report/admin_web_report.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  final SideMenuController _sideMenuController = SideMenuController();
  int _selectedPage = 0;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<DashboardProvider>().getUserName();
    });

    super.initState();
  }

  final List<Widget> _pages = [
    const AdminDashboardView(),
    Container(
      color: AppColors.colorBgNew,
      padding: const EdgeInsets.all(sixteen),
      child: const AdminCalenderScreen(),
    ),
    Container(
      color: AppColors.colorBgNew,
      padding: const EdgeInsets.all(sixteen),
      child: const PatientNewScreen(),
    ),
    Container(
      color: AppColors.colorBgNew,
      padding: const EdgeInsets.all(sixteen),
      child: const Center(
        child: CommunicationScreen(),
      ),
    ),
    Container(
      color: AppColors.colorBgNew,
      padding: const EdgeInsets.all(sixteen),
      child: const Center(
        child: AdminWebReport(),
      ),
    ),
    Container(
      color: AppColors.colorBgNew,
      padding: const EdgeInsets.all(sixteen),
      child: const AdminSettingScreen(),
    ),
    Container(
      color: AppColors.colorBgNew,
      padding: const EdgeInsets.all(sixteen),
      child: const Center(
        child: ErrorPage(),
      ),
    ),
    Container(
      color: AppColors.colorBgNew,
      padding: const EdgeInsets.all(sixteen),
      child: const Center(
        child: ErrorPage(),
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    var isMobile = Responsive.isMobile(context);
    var isDesktop = Responsive.isDesktop(context);
    var size = MediaQuery.sizeOf(context);
    return Consumer<DashboardProvider>(builder: (context, provider, child) {
      return Scaffold(
        /*  drawer: Drawer(
          child: AdminDrawerMenu(
            selectedPageNotifier: _selectedPageNotifier,
          ),
        ),*/
        backgroundColor: Colors.white,
        appBar: AppBar(
          surfaceTintColor: Colors.transparent,
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
          leadingWidth: isMobile ? 50 : 130,
          iconTheme: IconThemeData(
              color: isMobile ? AppColors.colorTextNew : Colors.white),
          leading: isMobile
              ? null
              : const ImageIcon(
                  size: 500,
                  color: AppColors.colorActive,
                  AssetImage(
                    icLogoApps,
                  )),
          backgroundColor: AppColors.colorBgNew,
        ),
        body: Row(
          children: [
            isMobile
                ? const SizedBox.shrink()
                : SideMenu(
                    controller: _sideMenuController,
                    style: SideMenuStyle(
                      openSideMenuWidth: isMobile ? 0 : 210,
                      itemHeight: 48,
                      itemBorderRadius: BorderRadius.circular(4),
                      itemOuterPadding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      itemInnerSpacing: 8,

                      //      hoverColor: AppColors.primary.withValues(alpha: 0.1),
                      displayMode: SideMenuDisplayMode.open,
                      // showHamburger: isMobile ? true : false,

                      unselectedTitleTextStyle: commonTextStyle(
                          color: AppColors.colorMenuUnSelectedText,
                          fontSize: 14,
                          fontWeight: FontWeight.w500),

                      selectedColor: AppColors.colorBgNew,
                      selectedTitleTextStyle: commonTextStyle(
                          color: AppColors.primary,
                          fontSize: 14,
                          fontWeight: FontWeight.w600),
                      selectedIconColor: AppColors.primary,
                      decoration: BoxDecoration(
                        color: AppColors.colorBgNew,
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.grey,
                            blurRadius: 10.0,
                          ),
                        ],
                        border:
                            Border.all(color: AppColors.colorBgNew, width: 1),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(0)),
                      ),
                    ),
                    items: [
                      SideMenuItem(
                        title: 'Dashboard',
                        onTap: (index, _) {
                          setState(() {
                            _selectedPage = 0;

                            _sideMenuController.changePage(index);
                          });
                          //// Navigate to Calendar page
                        },
                        icon: const Icon(Icons.dashboard),
                        tooltipContent: "This is a tooltip for Dashboard item",
                      ),
                      SideMenuItem(
                        title: 'Appointment',
                        onTap: (index, _) {
                          setState(() {
                            _selectedPage = 1;

                            _sideMenuController.changePage(index);
                          });
                        },
                        icon: const Icon(Icons.calendar_month_sharp),
                        tooltipContent: "This is a tooltip for Dashboard item",
                      ),
                      commonMenuDivider(),
                      SideMenuItem(
                        title: 'Patients',
                        onTap: (index, _) {
                          setState(() {
                            _selectedPage = 2;

                            _sideMenuController.changePage(index);
                          });
                          //sideMenu.changePage(index);
                        },
                        icon: const Icon(Icons.person),
                      ),
                      commonMenuDivider(),
                      SideMenuItem(
                        title: 'Communications',
                        onTap: (index, _) {
                          setState(() {
                            _selectedPage = 3;

                            _sideMenuController.changePage(index);
                          });
                          // sideMenu.changePage(index);
                        },
                        icon: const Icon(Icons.cell_tower),
                      ),
                      commonMenuDivider(),
                      SideMenuItem(
                        title: 'Reports',
                        onTap: (index, _) {
                          setState(() {
                            _selectedPage = 4;

                            _sideMenuController.changePage(index);
                          });
                          //sideMenu.changePage(index);
                        },
                        icon: const Icon(Icons.auto_graph),
                      ),
                      commonMenuDivider(),
                      SideMenuItem(
                        title: 'Settings',
                        onTap: (index, _) {
                          setState(() {
                            _selectedPage = 5;

                            _sideMenuController.changePage(index);
                          });
                        },
                        icon: const Icon(Icons.settings_outlined),
                      ),
                      commonMenuDivider(),
                      SideMenuItem(
                        title: 'Feedback',
                        onTap: (index, _) {
                          setState(() {
                            _selectedPage = 6;

                            _sideMenuController.changePage(index);
                          });
                        },
                        icon: const Icon(Icons.thumb_up_alt_outlined),
                      ),
                      commonMenuDivider(),
                      SideMenuItem(
                        onTap: (index, _) {
                          commonLogoutDialog(
                              width: isMobile
                                  ? size.width * zero9
                                  : size.width * 0.3,
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
              child: _pages[_selectedPage],
            ),
            /* Expanded(
              child: ValueListenableBuilder<int>(
                valueListenable: _selectedPageNotifier,
                builder: (context, selectedPage, child) {
                  return _pages[selectedPage];
                },
              ),
            ),*/
          ],
        ),
      );
    });
  }

  commonMenuDivider({Color? colorLine}) {
    return SideMenuItem(
      builder: (context, displayMode) {
        return Divider(
          height: 0,
          color: colorLine ?? AppColors.colorBgNew,
          // color: Colors.white,
          endIndent: 8,
          indent: 0,
          thickness: 0.5,
        );
      },
    );
  }
}

class AdminDrawerMenu extends StatefulWidget {
  const AdminDrawerMenu({super.key, required this.selectedPageNotifier});
  final ValueNotifier<int> selectedPageNotifier;

  @override
  State<AdminDrawerMenu> createState() => _AdminDrawerMenuState();
}

class _AdminDrawerMenuState extends State<AdminDrawerMenu> {
  final SideMenuController _sideMenuController = SideMenuController();

  /* @override
  void dispose() {
    _sideMenuController.dispose();
    super.dispose();
  }*/

  @override
  void initState() {
    super.initState();
    _sideMenuController.changePage(0);
    widget.selectedPageNotifier.value = 0;
  }

  @override
  Widget build(BuildContext context) {
    var isMobile = Responsive.isMobile(context);
    var isDesktop = Responsive.isDesktop(context);
    var size = MediaQuery.sizeOf(context);
    return SideMenu(
      title: isMobile
          ? const Center(
              child: ImageIcon(
                  size: 100,
                  color: AppColors.colorActive,
                  AssetImage(
                    icLogoApps,
                  )),
            )
          : const SizedBox.shrink(),
      controller: _sideMenuController,
      style: SideMenuStyle(
        openSideMenuWidth: isMobile ? 0 : 210,
        itemHeight: 48,
        itemBorderRadius: BorderRadius.circular(4),
        itemOuterPadding:
            const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        itemInnerSpacing: 8,

        displayMode: SideMenuDisplayMode.open,
        // showHamburger: isMobile ? true : false,

        unselectedTitleTextStyle: commonTextStyle(
            color: AppColors.colorMenuUnSelectedText,
            fontSize: 14,
            fontWeight: FontWeight.w500),

        selectedColor: AppColors.colorBgNew,
        selectedTitleTextStyle: commonTextStyle(
            color: AppColors.primary,
            fontSize: 14,
            fontWeight: FontWeight.w600),
        selectedIconColor: AppColors.primary,
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
        commonMenuDivider(colorLine: Colors.grey.withValues(alpha: 0.5)),
        SideMenuItem(
          title: 'Dashboard',
          onTap: (index, _) {
            setState(() {
              widget.selectedPageNotifier.value = 0;
              _sideMenuController.changePage(index);
              if (isMobile) {
                Navigator.of(context).pop();
              }
            });
            //// Navigate to Calendar page
          },
          icon: const Icon(Icons.calendar_month_sharp),
          tooltipContent: "This is a tooltip for Dashboard item",
        ),
        SideMenuItem(
          title: 'Appointment',
          onTap: (index, _) {
            setState(() {
              widget.selectedPageNotifier.value = 1;
              _sideMenuController.changePage(index);
              if (isMobile) {
                Navigator.of(context).pop();
              }
            });
          },
          icon: const Icon(Icons.calendar_month_sharp),
          tooltipContent: "This is a tooltip for Dashboard item",
        ),
        commonMenuDivider(),
        SideMenuItem(
          title: 'Patients',
          onTap: (index, _) {
            setState(() {
              widget.selectedPageNotifier.value = 2;
              _sideMenuController.changePage(index);
              if (isMobile) {
                Navigator.of(context).pop();
              }
            });
            //sideMenu.changePage(index);
          },
          icon: const Icon(Icons.person),
        ),
        commonMenuDivider(),
        SideMenuItem(
          title: 'Communications',
          onTap: (index, _) {
            setState(() {
              widget.selectedPageNotifier.value = 3;
              _sideMenuController.changePage(index);
              if (isMobile) {
                Navigator.of(context).pop();
              }
            });
            // sideMenu.changePage(index);
          },
          icon: const Icon(Icons.cell_tower),
        ),
        commonMenuDivider(),
        SideMenuItem(
          title: 'Reports',
          onTap: (index, _) {
            setState(() {
              widget.selectedPageNotifier.value = 4;
              _sideMenuController.changePage(index);
              if (isMobile) {
                Navigator.of(context).pop();
              }
            });
            //sideMenu.changePage(index);
          },
          icon: const Icon(Icons.auto_graph),
        ),
        commonMenuDivider(),
        SideMenuItem(
          title: 'Settings',
          onTap: (index, _) {
            setState(() {
              widget.selectedPageNotifier.value = 5;
              _sideMenuController.changePage(index);
              if (isMobile) {
                Navigator.of(context).pop();
              }
            });
          },
          icon: const Icon(Icons.settings_outlined),
        ),
        commonMenuDivider(),
        SideMenuItem(
          title: 'Feedback',
          onTap: (index, _) {
            setState(() {
              widget.selectedPageNotifier.value = 6;
              _sideMenuController.changePage(index);
              if (isMobile) {
                Navigator.of(context).pop();
              }
            });
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
    );
  }

  commonMenuDivider({Color? colorLine}) {
    return SideMenuItem(
      builder: (context, displayMode) {
        return Divider(
          height: 0,
          color: colorLine ?? AppColors.colorBgNew,
          // color: Colors.white,
          endIndent: 8,
          indent: 0,
          thickness: 0.5,
        );
      },
    );
  }
}
