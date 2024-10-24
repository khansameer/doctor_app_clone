import 'package:doctor_app/core/app_constants.dart';
import 'package:doctor_app/core/color_utils.dart';
import 'package:doctor_app/core/component/component.dart';
import 'package:doctor_app/core/responsive.dart';
import 'package:doctor_app/provider/dashboard_provider.dart';
import 'package:doctor_app/screen/dashboard/home/home_screen.dart';
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
    ];

    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        elevation: 2,
        selectedItemColor: colorAmber,
        selectedLabelStyle: commonTextStyle(fontSize: 11),
        unselectedLabelStyle: commonTextStyle(fontSize: 11),
        unselectedItemColor: Colors.grey,
        currentIndex: provider.selectedIndex,
        onTap: (index) {
          provider.setIndex(index);

          if (index == 0) {
            provider.setAppBarTitle("Home");
            provider.updateAppPage = "Home";
          }
          if (index == 1) {
            provider.setAppBarTitle("Q&A");
            provider.updateAppPage = "Q&A";
          }
          if (index == 2) {
            provider.setAppBarTitle("Chat");
            provider.updateAppPage = "Chat";
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Q&A'),
          BottomNavigationBarItem(
              icon: Icon(Icons.mark_unread_chat_alt), label: 'Chat'),
        ],
      ),
      backgroundColor: Colors.white,
      appBar: appBarView(
          context: context, title: isMobile ? provider.appBarTitle : null),
      body: Container(
        child: provider.currentAppPage != null
            ? provider.currentAppPage // If currentPage is not null, use it
            : screens[
                provider.selectedIndex], // Else fallback to the selected screen
      ) /*Expanded(child:provider.currentAppPage??

      screens[provider.selectedIndex])*/
      ,
    );
  }
}
