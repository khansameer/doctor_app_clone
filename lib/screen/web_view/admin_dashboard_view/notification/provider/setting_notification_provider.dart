import 'dart:convert';

import 'package:doctor_app/core/component/component.dart';
import 'package:doctor_app/screen/web_view/admin_dashboard_view/notification/model/setting_notification_model.dart';
import 'package:doctor_app/service/api_config.dart';
import 'package:doctor_app/service/api_services.dart';
import 'package:doctor_app/service/gloable_status_code.dart';
import 'package:flutter/material.dart';

class SettingNotificationProvider with ChangeNotifier {
  final _service = ApiService();
  bool get isFetching => _isFetching;
  bool _isFetching = false;
   SettingNotificationModel? notificationModel;

  Future<void> getNotificationDetails({required BuildContext context}) async {
    _isFetching = true;
    notifyListeners();
    try {

      final response = await _service.callGetMethodApiWithToken(
        url: ApiConfig.settingNotification,
      );
      notificationModel = SettingNotificationModel.fromJson(json.decode(response));

      print('===${notificationModel?.email?.appointments}');
      if (globalStatusCode == 200) {

      } else if (globalStatusCode == 401) {
        commonSessionError(context: context, isAuth: true);
      } else {}
    } catch (e) {
      // _registerModel = RegisterModel(message: 'server_error'.tr());
    }
    _isFetching = false;
    notifyListeners();
  }

  // Method to update specific notification setting
  void updateNotificationSetting({
    required String notificationType, // e.g., "email", "sms", or "push"
    required String fieldName,        // e.g., "appointments", "reminders"
    required bool value,
  }) {
    // Access the Email, SMS, or Push notification setting



    var setting = notificationType == 'email'
        ? notificationModel?.email
        : notificationType == 'sms'
        ? notificationModel?.sms
        : notificationModel?.push;

    if (setting != null) {
      // Use a switch statement or if-else to update the desired field
      switch (fieldName) {
        case 'appointments':
          setting.appointments = value;
          break;
        case 'reminders':
          setting.reminders = value;
          break;
        case 'prescriptions':
          setting.prescriptions = value;
          break;
        case 'reports':
          setting.reports = value;
          break;
        case 'marketing':
          setting.marketing = value;
          break;
        default:
          return; // Invalid field, do nothing
      }
      notifyListeners(); // Notify listeners of the update
    }
  }
}
