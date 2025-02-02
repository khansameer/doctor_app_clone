import 'package:aligned_dialog/aligned_dialog.dart';
import 'package:doctor_app/core/app_constants.dart';
import 'package:doctor_app/core/colors.dart';
import 'package:doctor_app/core/common/common_text_widget.dart';

import 'package:doctor_app/core/common/error_page.dart';
import 'package:doctor_app/core/component/component.dart';
import 'package:doctor_app/core/image/image_path.dart';
import 'package:doctor_app/core/responsive.dart';
import 'package:doctor_app/provider/dashboard_provider.dart';

import 'package:doctor_app/screen/web_view/admin_dashboard_view/communication_screen.dart';

import 'package:doctor_app/screen/web_view/admin_dashboard_view/notification/admin_notification_screen.dart';

import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

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
      context.read<DashboardProvider>().getUserProfile();
    });

    super.initState();
  }

  final List<Widget> _pages = [
    const CommunicationScreen(),
   /* Container(
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
        child: AdminFeedbackScreen(),
      ),
    ),
    Container(
      color: AppColors.colorBgNew,
      padding: const EdgeInsets.all(sixteen),
      child: const Center(
        child: ErrorPage(),
      ),
    ),*/
  ];

  @override
  Widget build(BuildContext context) {
    var isMobile = Responsive.isMobile(context);
    var isDesktop = Responsive.isDesktop(context);
    var size = MediaQuery.sizeOf(context);
    return Consumer<DashboardProvider>(builder: (context, provider, child) {
      return Scaffold(
        drawer: Drawer(
          child: Container(
            child: commonMenu(
                size: size, isMobile: isMobile, isDesktop: isDesktop),
          ),
        ),
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
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CommonTextWidget(
                    text: "Timezone: EST",
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    textColor: Colors.blueGrey.shade400),
              ],
            ),
            const SizedBox(
              width: 10,
            ),
            Stack(
              clipBehavior: Clip.none,
              children: [
                MouseRegion(
                  onEnter: (_) {
                    provider.setHoverNotification(0);
                  },
                  onExit: (_) {
                    provider.setHoverNotification(null);
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    width: thirtyFive,
                    height: thirtyFive,
                    clipBehavior: Clip.antiAlias,
                    decoration: commonBoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: provider.hoverNotification == 0
                          ? AppColors.primary
                          : Colors.white,
                      // color: Colors.white,
                    ),
                    child: Builder(
                      builder: (context) => InkWell(
                        hoverColor: Colors.transparent,
                        onTap: () async {
                          await showAlignedDialog(
                            context: context,
                            isGlobal: false,
                            barrierColor: Colors.transparent,
                            avoidOverflow: false,
                            targetAnchor: AlignmentDirectional(0.0, 1.0)
                                .resolve(Directionality.of(context)),
                            followerAnchor: AlignmentDirectional(0.0, -1.0)
                                .resolve(Directionality.of(context)),
                            builder: (dialogContext) {
                              return Material(
                                color: Colors.transparent,
                                child: GestureDetector(
                                  onTap: () =>
                                      FocusScope.of(dialogContext).unfocus(),
                                  child:
                                      AdminNotificationScreen(isDialog: true),
                                ),
                              );
                            },
                          );
                        },
                        child: Icon(
                          Icons.notifications_none,
                          color: provider.hoverNotification == 0
                              ? Colors.white
                              : AppColors.colorTextNew,
                          size: 18,
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                    right: 0,
                    top: -8,
                    child: Container(
                      width: 18,
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color.fromARGB(255, 244, 147, 43)),
                      height: 18,
                      child: Center(
                        child: CommonTextWidget(
                          text: '${provider.doctorNotifications.length}',
                          fontSize: 8,
                          textColor: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    )),
              ],
            ),
            const SizedBox(
              width: 10,
            ),
            SizedBox(
              width: thirtyFive,
              height: thirtyFive,
              child: commonImageNetworkWidget(path: provider.profileImage),
            ),
            const SizedBox(
              width: 10,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CommonTextWidget(
                    text: provider.name,
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
            // PopupMenuButton(
            //   color: Colors.white,
            //   constraints: const BoxConstraints.tightFor(width: twoHundred),
            //   elevation: zero,
            //   offset: const Offset(zero, thirty),
            //   onSelected: (value) {},
            //   itemBuilder: (context) => [
            //     new PopupMenuItem<String>(
            //         child: new Text('Doge'), value: 'Doge'),
            //     new PopupMenuItem<String>(
            //         child: new Text('Lion'), value: 'Lion'),
            //   ],
            //   child: commonInkWell(
            //     onTap: () {},
            //     child: const Icon(
            //       Icons.keyboard_arrow_down_sharp,
            //       color: Colors.grey,
            //     ),
            //   ),
            // ),
            PopupMenuButton(
              elevation: 0,
                offset: const Offset(zero, 45),
                constraints: const BoxConstraints.tightFor(width: 200,),
                color: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8.0))
                ),
                icon: Icon(
                  Icons.keyboard_arrow_down_sharp,
                  color: Colors.grey,
                ),
                onSelected: (value) {
                  // your logic
                  if(value=="profile"){

                  }

                  else
                    {
                      commonLogoutDialog(
                          width: isMobile ? size.width * zero9 : size.width * 0.2,
                          contextAd: context,
                          isDesktop: isDesktop,
                          isMobile: isMobile);
                    }

                  print(value);

                },
                itemBuilder: (BuildContext bc) {
                  return [
                    PopupMenuItem(
                      value: 'profile',
                      child: Row(
                        children: [
                          Icon(
                            Icons.person,
                            color: Colors.black,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          CommonTextWidget(text: "Profile"),
                        ],
                      ),
                    ),

                    PopupMenuItem(
                      value: 'logout',
                      child: Row(
                        children: [
                          Icon(
                            Icons.logout,
                            color: Colors.black,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          CommonTextWidget(text: "Logout"),
                        ],
                      ),
                    ),
                  ];
                }),
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
                : commonMenu(
                    size: size, isMobile: isMobile, isDesktop: isDesktop),
            const VerticalDivider(
              color: AppColors.colorBgNew,
              width: 2,
            ),
            Expanded(
              child: _pages[_selectedPage],
            ),
          ],
        ),
      );
    });
  }

  commonMenu(
      {required bool isMobile, required Size size, required bool isDesktop}) {
    return SideMenu(
      controller: _sideMenuController,
      title: isMobile
          ? Center(
              child: const ImageIcon(
                  size: 100,
                  color: AppColors.colorActive,
                  AssetImage(
                    icLogoApps,
                  )),
            )
          : null,
      style: SideMenuStyle(
        openSideMenuWidth: isMobile ? 0 : 210,
        itemHeight: 48,
        itemBorderRadius: BorderRadius.circular(4),
        itemOuterPadding:
            const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
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
          border: Border.all(color: AppColors.colorBgNew, width: 1),
          borderRadius: const BorderRadius.all(Radius.circular(0)),
        ),
      ),
      items: [
        SideMenuItem(
          title: 'Chat',
          onTap: (index, _) {
            setState(() {
              _selectedPage = 0;

              _sideMenuController.changePage(index);
              isMobile ? voidHidMenu() : null;
            });
            //// Navigate to Calendar page
          },
          icon: const Icon(Icons.dashboard),
          tooltipContent: "This is a tooltip for Dashboard item",
        ),
       /* SideMenuItem(
          title: 'VideoCall',
          onTap: (index, _) {
            setState(() {
              _selectedPage = 1;

              _sideMenuController.changePage(index);
              isMobile ? voidHidMenu() : null;
            });
          },
          icon: const Icon(Icons.calendar_month_sharp),
          tooltipContent: "This is a tooltip for Dashboard item",
        ),*/
      /*  commonMenuDivider(),
        SideMenuItem(
          title: 'Patients',
          onTap: (index, _) {
            setState(() {
              _selectedPage = 2;

              _sideMenuController.changePage(index);
              isMobile ? voidHidMenu() : null;
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
              isMobile ? voidHidMenu() : null;
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
              isMobile ? voidHidMenu() : null;
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
              isMobile ? voidHidMenu() : null;
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
              isMobile ? voidHidMenu() : null;
            });
          },
          icon: const Icon(Icons.thumb_up_alt_outlined),
        ),
        commonMenuDivider(),*/
        SideMenuItem(
          onTap: (index, _) {
            isMobile ? voidHidMenu() : null;
            commonLogoutDialog(
                width: isMobile ? size.width * zero9 : size.width * 0.2,
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

  voidHidMenu() {
    Navigator.of(context).pop();
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

// Custom painter to draw the triangle
class TrianglePainter extends CustomPainter {
  final Color color;

  TrianglePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final path = Path();
    path.moveTo(size.width / 2, 0); // Start at top center
    path.lineTo(0, size.height); // Bottom left
    path.lineTo(size.width, size.height); // Bottom right
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// Notification popup with triangle
