import 'package:doctor_app/core/color_utils.dart';
import 'package:doctor_app/core/common/common_text_widget.dart';
import 'package:doctor_app/core/component/component.dart';
import 'package:flutter/material.dart';

import '../../core/route/route.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: commonAppBar(
          leadingWidth: 200,
          leading: Container(
            width: 200,
            color: Colors.red,
            height: 56,
            child: Center(
                child: CommonTextWidget(
              text: "Logo here",
            )),
          ),
          color: colorGreen,
          actions: [
            commonIcon(onTap: (){
              pushScreen(context: context, routeName: RouteName.settingScreen);
            }),
            commonIcon(icon: Icons.question_mark_outlined),
            commonInkWell(
              onTap: (){
                pushScreen(context: context, routeName: RouteName.notificationScreen);
              },
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  const Icon(Icons.notifications_none,color: Colors.white,size: 24,),
                  Positioned(
                      top: -8.0,
                      right: -3.0,
                      child: Stack(
                        children: <Widget>[

                          Container(
                            width: 20,
                            height: 20,
                            decoration: commonBoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.red
                            ),
                            child: Center(

                              child: CommonTextWidget(text: "20",fontSize: 9,textColor: Colors.white
                                ,),
                            ),
                          )
                        ],
                      ))
                ],
              ),
            ),
            const SizedBox(width: 10,)
          ]),
    );
  }

  commonIcon({IconData? icon,double? size,VoidCallback ?onTap}) {
    return IconButton(
        onPressed: onTap,
        icon: Icon(
          icon ?? Icons.settings_outlined,
          color: Colors.white,
          size: size,
        ));
  }
}
