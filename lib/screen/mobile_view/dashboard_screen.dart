import 'package:doctor_app/core/colors.dart';
import 'package:doctor_app/core/component/component.dart';
import 'package:doctor_app/core/responsive.dart';
import 'package:doctor_app/provider/dashboard_provider.dart';
import 'package:doctor_app/screen/mobile_view/home/home_screen.dart';
import 'package:doctor_app/screen/mobile_view/profile/profile_menu_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'chat_screen/patient_list_screen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key, this.child});

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DashboardProvider>(context);
    var isMobile = Responsive.isMobile(context);

    final List<Widget> screens = [
      HomeScreen(
        onSelectedPage: (value) {
          provider.updateAppPage = value;
          provider.setAppBarTitle(value);
        },
      ),
      Container(),
      const PatientListScreen(),
      const ProfileMenuScreen()
    ];

    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        elevation: 2,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppColors.primary,
        selectedLabelStyle: commonTextStyle(fontSize: 11),
        unselectedLabelStyle: commonTextStyle(fontSize: 11),
        unselectedItemColor: Colors.grey,
        currentIndex: provider.selectedIndex,
        onTap: (index) {
          provider.setIndex(index);

          if (index == 0) {
            provider.setAppBarTitle("Home".toUpperCase());
          }
          if (index == 1) {
            provider.setAppBarTitle("Q&A".toUpperCase());
          }
          if (index == 2) {
            provider.setAppBarTitle("Chat".toUpperCase());
            //provider.updateAppPage = "Chat".to;
          }
          if (index == 3) {
            provider.setAppBarTitle("Profile".toUpperCase());
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Q&A'),
          BottomNavigationBarItem(
              icon: Icon(Icons.mark_unread_chat_alt), label: 'Chat'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
      backgroundColor: Colors.white,
      appBar: appBarView(
          context: context, title: isMobile ? provider.appBarTitle : null),
      body: Container(
        child: screens[provider.selectedIndex],
      ),
    );
  }
}
