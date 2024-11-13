import 'dart:convert';

import 'package:doctor_app/core/component/component.dart';
import 'package:doctor_app/screen/web_view/admin_dashboard_view/feedback/model/feedback_model.dart';
import 'package:doctor_app/screen/web_view/admin_dashboard_view/notification/model/setting_notification_model.dart';
import 'package:doctor_app/service/api_config.dart';
import 'package:doctor_app/service/api_services.dart';
import 'package:doctor_app/service/gloable_status_code.dart';
import 'package:flutter/material.dart';
class FeedbackProvider with ChangeNotifier {
  final _service = ApiService();
  bool get isFetching => _isFetching;
  bool _isFetching = false;
   FeedbackModel? feedbackModel ; // Initialize with a default value

  Future<FeedbackModel?> getFeedbackList({required BuildContext context}) async {
    _isFetching = true;
    notifyListeners();

    try {
      final response = await _service.callGetMethodApiWithToken(
        url: ApiConfig.getFeedback,
      );

      if (globalStatusCode == 200) {
        feedbackModel = FeedbackModel.fromJson(json.decode(response));
        _isFetching = false;

        notifyListeners();
        return feedbackModel; // Return the successfully fetched data
      } else if (globalStatusCode == 401) {
        commonSessionError(context: context, isAuth: true);
        _isFetching = false;
        notifyListeners();
        return null; // Return null on failure
      } else {
        _isFetching = false;
        notifyListeners();
        return null;
      }
    } catch (e) {
      _isFetching = false;
      notifyListeners();
      return null;
    }
  }
}
