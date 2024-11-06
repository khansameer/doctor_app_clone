import 'package:doctor_app/core/common/common_text_widget.dart';
import 'package:doctor_app/provider/dashboard_provider.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AdminNotificationScreen extends StatelessWidget {
  const AdminNotificationScreen({super.key});


  @override
  Widget build(BuildContext context) {
    return Consumer<DashboardProvider>(
      builder: (context,provider,child) {
        return ListView.separated(
            shrinkWrap: true,
            itemCount: provider.doctorNotifications.length,
            itemBuilder: (context,index){
              var data=provider.doctorNotifications[index];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: CommonTextWidget(text: data.toString(),fontSize: 11,fontWeight: FontWeight.w600,),
          );
        }, separatorBuilder: (BuildContext context, int index) { return Divider(thickness: 0.3,); },);
      }
    );
  }
}