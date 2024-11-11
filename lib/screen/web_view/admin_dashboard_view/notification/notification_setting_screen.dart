import 'package:doctor_app/core/colors.dart';
import 'package:doctor_app/core/common/common_text_widget.dart';
import 'package:doctor_app/core/component/component.dart';
import 'package:doctor_app/screen/web_view/admin_dashboard_view/notification/provider/setting_notification_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NotificationSettingScreen extends StatefulWidget {
  const NotificationSettingScreen({super.key});

  @override
  State<NotificationSettingScreen> createState() =>
      _NotificationSettingScreenState();
}

class _NotificationSettingScreenState extends State<NotificationSettingScreen> {
  /* bool _switchValueNotification = true;
  bool _switchValueAppointment = true;
  bool _switchValuePatient = true;
  bool _switchValuEmergency = false;
  bool _switchValuGeneral = true;
  bool _switchValuMessage = true;*/

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // Trigger the fetchItems method when the screen loads
    Future.microtask(() =>
        Provider.of<SettingNotificationProvider>(context, listen: false)
            .getNotificationDetails(context: context));
  }

  // Callback to update switch values
/*  void _onSwitchChanged(String switchType, bool value) {
    setState(() {
      switch (switchType) {
        case 'notification':
          _switchValueNotification = value;
          break;
        case 'appointment':
          _switchValueAppointment = value;
          break;
        case 'patient':
          _switchValuePatient = value;
          break;
        case 'emergency':
          _switchValuEmergency = value;
          break;
        case 'general':
          _switchValuGeneral = value;
          break;
        case 'message':
          _switchValuMessage = value;
          break;
      }
    });
  }*/

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SettingNotificationProvider>(context);
    return provider.isFetching
        ? Center(child: showLoaderList())
        : ListView(
            children: [
              Column(
                children: [
                  commonTitleView(
                    title: "Email Notification",
                  ),
                  commonSubView(
                      title: 'Appointments',
                      onSwitchChanged: (bool) {
                       provider
                            .updateNotificationSetting(
                          notificationType: 'email',
                          fieldName: 'appointments',
                          value: bool,
                        );

                      },
                      switchValue:
                          provider.notificationModel.email!.appointments!),

                  commonSubView(
                      title: 'Reminders',
                      onSwitchChanged: (bool) {
                        provider
                            .updateNotificationSetting(
                          notificationType: 'email',
                          fieldName: 'reminders',
                          value: bool,
                        );

                      },
                      switchValue:
                      provider.notificationModel.email!.reminders!),
                  commonSubView(
                      title: 'Prescriptions',
                      onSwitchChanged: (bool) {
                        provider
                            .updateNotificationSetting(
                          notificationType: 'email',
                          fieldName: 'prescriptions',
                          value: bool,
                        );

                      },
                      switchValue:
                      provider.notificationModel.email!.prescriptions!),
                  commonSubView(
                      title: 'Reports',
                      onSwitchChanged: (bool) {
                        provider
                            .updateNotificationSetting(
                          notificationType: 'email',
                          fieldName: 'reports',
                          value: bool,
                        );

                      },
                      switchValue:
                      provider.notificationModel.email!.reports!),
                  commonSubView(
                      title: 'Marketing',
                      onSwitchChanged: (bool) {
                        provider
                            .updateNotificationSetting(
                          notificationType: 'email',
                          fieldName: 'marketing',
                          value: bool,
                        );

                      },
                      switchValue:
                      provider.notificationModel.email!.marketing!),
                ],
              ),
              Column(
                children: [
                  commonTitleView(
                    title: "SMS Notification",
                  ),
                  commonSubView(
                      title: 'Appointments',
                      onSwitchChanged: (bool) {
                        provider
                            .updateNotificationSetting(
                          notificationType: 'email',
                          fieldName: 'appointments',
                          value: bool,
                        );

                      },
                      switchValue:
                      provider.notificationModel.sms!.appointments!),

                  commonSubView(
                      title: 'Reminders',
                      onSwitchChanged: (bool) {
                        provider
                            .updateNotificationSetting(
                          notificationType: 'email',
                          fieldName: 'reminders',
                          value: bool,
                        );

                      },
                      switchValue:
                      provider.notificationModel.sms!.reminders!),
                  commonSubView(
                      title: 'Prescriptions',
                      onSwitchChanged: (bool) {
                        provider
                            .updateNotificationSetting(
                          notificationType: 'email',
                          fieldName: 'prescriptions',
                          value: bool,
                        );

                      },
                      switchValue:
                      provider.notificationModel.sms!.prescriptions!),
                  commonSubView(
                      title: 'Reports',
                      onSwitchChanged: (bool) {
                        provider
                            .updateNotificationSetting(
                          notificationType: 'email',
                          fieldName: 'reports',
                          value: bool,
                        );

                      },
                      switchValue:
                      provider.notificationModel.sms!.reports!),
                  commonSubView(
                      title: 'Marketing',
                      onSwitchChanged: (bool) {
                        provider
                            .updateNotificationSetting(
                          notificationType: 'email',
                          fieldName: 'marketing',
                          value: bool,
                        );

                      },
                      switchValue:
                      provider.notificationModel.sms!.marketing!),
                ],
              ),
              Column(
                children: [
                  commonTitleView(
                    title: "Push Notification",
                  ),
                  commonSubView(
                      title: 'Appointments',
                      onSwitchChanged: (bool) {
                        provider
                            .updateNotificationSetting(
                          notificationType: 'email',
                          fieldName: 'appointments',
                          value: bool,
                        );

                      },
                      switchValue:
                      provider.notificationModel.push!.appointments!),

                  commonSubView(
                      title: 'Reminders',
                      onSwitchChanged: (bool) {
                        provider
                            .updateNotificationSetting(
                          notificationType: 'email',
                          fieldName: 'reminders',
                          value: bool,
                        );

                      },
                      switchValue:
                      provider.notificationModel.push!.reminders!),
                  commonSubView(
                      title: 'Prescriptions',
                      onSwitchChanged: (bool) {
                        provider
                            .updateNotificationSetting(
                          notificationType: 'email',
                          fieldName: 'prescriptions',
                          value: bool,
                        );

                      },
                      switchValue:
                      provider.notificationModel.push!.prescriptions!),
                  commonSubView(
                      title: 'Reports',
                      onSwitchChanged: (bool) {
                        provider
                            .updateNotificationSetting(
                          notificationType: 'email',
                          fieldName: 'reports',
                          value: bool,
                        );

                      },
                      switchValue:
                      provider.notificationModel.push!.reports!),
                  commonSubView(
                      title: 'Marketing',
                      onSwitchChanged: (bool) {
                        provider
                            .updateNotificationSetting(
                          notificationType: 'email',
                          fieldName: 'marketing',
                          value: bool,
                        );

                      },
                      switchValue:
                      provider.notificationModel.sms!.marketing!),
                ],
              ),
            ],
          );
  }

  Widget commonTitleView({
    required String title,
  }) {
    return Container(width: double.infinity,
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColors.colorBgNew,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Container(
       child: CommonTextWidget(
          text: title,
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget commonSubView({
    required String title,
    required bool switchValue,
    required Function(bool) onSwitchChanged,
  }) {
    return Container(

      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CommonTextWidget(
            text: title,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
          CupertinoSwitch(
            value: switchValue,
            onChanged: onSwitchChanged,
          )
        ],
      ),

    );
  }


}
