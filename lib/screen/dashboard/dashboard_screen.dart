import 'package:doctor_app/core/color_utils.dart';
import 'package:doctor_app/core/common/common_text_widget.dart';
import 'package:doctor_app/core/component/component.dart';
import 'package:doctor_app/core/route/route.dart';
import 'package:doctor_app/provider/dashboard_provider.dart';
import 'package:doctor_app/screen/dashboard/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'chat_screen/patient_list_screen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DashboardProvider>(context);
    final List<Widget> screens = [
      const HomeScreen(),
      Container(),
      const PatientListScreen(),
    ];

    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor:Colors.white,
        elevation: 2,
        selectedItemColor:colorAmber,
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
          BottomNavigationBarItem(icon: Icon(Icons.mark_unread_chat_alt), label: 'Chat'),
        ],
      ),
        backgroundColor: Colors.white,

      appBar:_appBarView(context),
      body: screens[provider.selectedIndex],
    );
  }


  _appBarView(BuildContext context) {
    return commonAppBar(
        leading: const Icon(Icons.dashboard_rounded,color: Colors.white,),
        color: colorGreen, actions: [
      commonIcon(onTap: () {
        pushScreen(context: context, routeName: RouteName.settingScreen);
      }),

      commonInkWell(
        onTap: (){
          pushScreen(
              context: context, routeName: RouteName.reportAndIssueScreen);
        },
        child: Container(
          width: 24,
          height: 24,
          alignment:Alignment.center ,
          decoration: commonBoxDecoration(shape: BoxShape.circle,
          border: Border.all(color: Colors.white,width: 1)),
          child: Container(

            alignment:Alignment.center ,
            child: const Icon(Icons.question_mark,size: 15,),
          ),),
      ),
      const SizedBox(width: 10,),
      commonInkWell(
        onTap: () {
          pushScreen(
              context: context, routeName: RouteName.notificationScreen);
        },
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            const Icon(
              Icons.notifications_none,
              color: Colors.white,
              size: 24,
            ),
            Positioned(
                top: -8.0,
                right: -3.0,
                child: Stack(
                  children: <Widget>[
                    Container(
                      width: 20,
                      height: 20,
                      decoration: commonBoxDecoration(
                          shape: BoxShape.circle, color: Colors.red),
                      child: Center(
                        child: CommonTextWidget(
                          text: "20",
                          fontSize: 9,
                          textColor: Colors.white,
                        ),
                      ),
                    )
                  ],
                ))
          ],
        ),
      ),
      const SizedBox(
        width: 10,
      )
    ]);
  }


}
