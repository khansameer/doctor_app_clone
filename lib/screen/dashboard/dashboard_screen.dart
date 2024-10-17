import 'package:doctor_app/core/app_constants.dart';
import 'package:doctor_app/core/color_utils.dart';
import 'package:doctor_app/core/component/component.dart';
import 'package:doctor_app/core/responsive.dart';
import 'package:doctor_app/provider/dashboard_provider.dart';
import 'package:doctor_app/screen/dashboard/home/home_screen.dart';
import 'package:doctor_app/screen/dashboard/profile/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'chat_screen/patient_list_screen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key,this.child});
 final Widget? child;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DashboardProvider>(context);
    var isMobile = Responsive.isMobile(context);
    final List<Widget> screens = [
       HomeScreen(onSelectedPage: (value ) {

         provider.getPageSelected=value;

        },),
      Container(),
      const PatientListScreen(),
    ];

    return Scaffold(
      bottomNavigationBar: isMobile
          ? BottomNavigationBar(
              backgroundColor: Colors.white,
              elevation: 2,
              selectedItemColor: colorAmber,
              selectedLabelStyle: commonTextStyle(fontSize: 11),
              unselectedLabelStyle: commonTextStyle(fontSize: 11),
              unselectedItemColor: Colors.grey,
              currentIndex: provider.selectedIndex,
              onTap: (index) {
                provider.setIndex(index);
              },
              items: const [
                BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
                BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Q&A'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.mark_unread_chat_alt), label: 'Chat'),
              ],
            )
          : const SizedBox.shrink(),
      backgroundColor: Colors.white,
      appBar: isMobile
          ? appBarView(context)
          : const PreferredSize(
              preferredSize: Size.zero, child: SizedBox.shrink()),
      body: Row(
        children: [
          isMobile
              ? const SizedBox.shrink()
              : NavigationRail(
                  extended: isMobile ? false : true,
                  useIndicator: false,
                  backgroundColor: colorBG,
                  indicatorColor: Colors.white,
                  selectedIconTheme: const IconThemeData(color: colorGreen),
                  unselectedLabelTextStyle: const TextStyle(
                      fontSize: fourteen,
                      color: Colors.black,
                      fontWeight: FontWeight.w500),
                  selectedLabelTextStyle: const TextStyle(
                      fontSize: fourteen,
                      color: colorGreen,
                      fontWeight: FontWeight.w700),
                  selectedIndex: provider.selectedIndex,
                  onDestinationSelected: (int index) {
                    provider.setSelectedIndex(index);
                    provider.updatePage = screens[index]; // Use the correct screen here

                    provider.setSelectedIndex(index);
                    provider.updatePage = screens[index]; // Use the correct screen here
                  },
                  labelType: NavigationRailLabelType.none,
                  destinations: provider.navigationItems.map((item) {
                    return NavigationRailDestination(
                      icon: Tooltip(
                        message: item.label,
                        child: SizedBox(
                          height: 30,
                          width: 30,
                          child: item.icon,
                        ),
                      ),
                      selectedIcon: SizedBox(
                        height: 30,
                        width: 30,
                        child: item.selectedIcon,
                      ),
                      label: Text(item.label),
                    );
                  }).toList(),
                ),
          Expanded(
            child: provider.currentPage != null
                ? provider.currentPage  // If currentPage is not null, use it
                : screens[provider.selectedIndex],  // Else fallback to the selected screen
          )
          // Expanded(child: provider.currentPage??screens[provider.selectedIndex])
        ],
      ),
    );
  }
}
