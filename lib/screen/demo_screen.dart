import 'package:doctor_app/core/app_constants.dart';
import 'package:doctor_app/core/colors.dart';
import 'package:doctor_app/core/common/common_text_widget.dart';
import 'package:doctor_app/core/component/component.dart';
import 'package:doctor_app/core/image/image_path.dart';
import 'package:doctor_app/core/responsive.dart';
import 'package:doctor_app/provider/dashboard_provider.dart';
import 'package:doctor_app/screen/dashboard/calender/calender_screen.dart';
import 'package:doctor_app/screen/new_dashboard/invoice/invoice_screen.dart';
import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'new_dashboard/calender_new_screen.dart';
import 'new_dashboard/patient_profile_page.dart';

class SamplePage extends StatefulWidget {
  @override
  State<SamplePage> createState() => _SamplePageState();
}

class _SamplePageState extends State<SamplePage> {
  PageController pageController = PageController();
  SideMenuController sideMenu = SideMenuController();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<DashboardProvider>().getUserName();
    });
    sideMenu.addListener((index) {
      pageController.jumpToPage(index);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var isMobile = Responsive.isMobile(context);
    return Consumer<DashboardProvider>(builder: (context, provider, child) {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
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
              tooltip: "profile",
              offset: const Offset(zero, thirty),
              onSelected: (value) {
                print('====${value}');
                if (value == 0) {
                  provider.updatePageValue(8);
                  // provider.updatePagesss = "setting";

                  //     provider.setSelectedIndex(index);
                }
                if (value == 1) {
                  // provider.setSelectedMenu("profile");
                }
              },
              itemBuilder: (context) => [
                //buildPopupMenuItem(context: context, index: 0, text: profile),
                buildPopupMenuItem(context: context, index: 0, text: "Invoice"),
                buildPopupMenuItem(context: context, index: 1, text: "Logout"),
              ],
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
            const SizedBox(
              width: ten,
            ),
          ],
          leadingWidth: isMobile ? null : oneHundred,
          iconTheme: const IconThemeData(color: Colors.white),
          leading: isMobile
              ? null
              : const ImageIcon(
                  color: Colors.white,
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
                openSideMenuWidth: 250,
                itemBorderRadius: BorderRadius.circular(0),
                itemOuterPadding: EdgeInsets.zero,
                // showTooltip: false,

                itemInnerSpacing: 5,

                displayMode: SideMenuDisplayMode.auto,
                showHamburger: false,
                arrowCollapse: Colors.white,
                unselectedIconColorExpandable: Colors.white.withOpacity(0.50),
                selectedIconColorExpandable: Colors.white.withOpacity(0.50),
                unselectedIconColor: Colors.white.withOpacity(0.50),
                unselectedTitleTextStyle:
                    TextStyle(color: Colors.white.withOpacity(0.50)),
                selectedTitleTextStyleExpandable:
                    const TextStyle(color: Colors.white),
                hoverColor: Colors.white.withOpacity(0.10),
                selectedHoverColor: Colors.white.withOpacity(0.10),
                selectedColor: Colors.white.withOpacity(0.50),
                selectedTitleTextStyle: const TextStyle(color: Colors.white),
                selectedIconColor: Colors.white,
                //backgroundColor: AppColors.colorDrawer
                decoration: const BoxDecoration(
                  color: AppColors.colorDrawer,
                  borderRadius: BorderRadius.all(Radius.circular(0)),
                ),
                // backgroundColor: Colors.grey[200]
              ),
              items: [
                SideMenuItem(
                  title: 'Calender',
                  onTap: (index, _) {
                    provider.updatePageValue(0); // Navigate to Calendar page
                    //sideMenu.changePage(index);
                  },
                  icon: const Icon(Icons.calendar_month_sharp),
                  tooltipContent: "This is a tooltip for Dashboard item",
                ),
                SideMenuItem(
                  title: 'Patients',
                  onTap: (index, _) {
                    provider.updatePageValue(1);
                    //    sideMenu.changePage(index);
                  },
                  icon: const Icon(Icons.person),
                ),
                SideMenuItem(
                  title: 'Communications',
                  onTap: (index, _) {
                    provider.updatePageValue(3);
                    //sideMenu.changePage(index);
                  },
                  icon: const Icon(Icons.cell_tower),
                ),
                SideMenuItem(
                  title: 'Reports',
                  onTap: (index, _) {
                    provider.updatePageValue(4);
                    //sideMenu.changePage(index);
                  },
                  icon: const Icon(Icons.auto_graph),
                ),
                SideMenuItem(
                  title: 'Settings',
                  onTap: (index, _) {
                    sideMenu.changePage(index);
                  },
                  icon: const Icon(Icons.settings_outlined),
                ),
                SideMenuItem(
                  title: 'Profile',
                  onTap: (index, _) {
                    sideMenu.changePage(index);
                  },
                  icon: const Icon(Icons.person),
                ),
                SideMenuItem(
                  title: 'Feedback',
                  onTap: (index, _) {
                    sideMenu.changePage(index);
                  },
                  icon: const Icon(Icons.thumb_up_alt_outlined),
                ),
                const SideMenuItem(
                  title: 'Exit',
                  icon: Icon(Icons.exit_to_app),
                ),
              ],
            ),
            const VerticalDivider(
              width: 0,
            ),
            Expanded(
              child: PageView(
                controller: provider.pageController,
                children: [
                  const CalenderNewScreen(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: const PatientProfilePage(),
                  ),
                  Container(
                    color: Colors.white,
                    child: const Center(
                      child: Text(
                        'Expansion Item 1',
                        style: TextStyle(fontSize: 35),
                      ),
                    ),
                  ),
                  Container(
                    color: Colors.white,
                    child: const Center(
                      child: Text(
                        'Expansion Item 2',
                        style: TextStyle(fontSize: 35),
                      ),
                    ),
                  ),
                  Container(
                    color: Colors.white,
                    child: const Center(
                      child: Text(
                        'Files',
                        style: TextStyle(fontSize: 35),
                      ),
                    ),
                  ),
                  Container(
                    color: Colors.white,
                    child: const Center(
                      child: Text(
                        'Download',
                        style: TextStyle(fontSize: 35),
                      ),
                    ),
                  ),
                  Container(
                    color: Colors.white,
                    child: const Center(
                      child: Text(
                        'Download',
                        style: TextStyle(fontSize: 35),
                      ),
                    ),
                  ),
                  Container(
                    color: Colors.white,
                    child: const Center(
                      child: Text(
                        'Download',
                        style: TextStyle(fontSize: 35),
                      ),
                    ),
                  ),
                  InvoiceScreen(),

                  // this is for SideMenuItem with builder (divider)

                  Container(
                    color: Colors.white,
                    child: const Center(
                      child: Text(
                        'dsddsds',
                        style: TextStyle(fontSize: 35),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}
