import 'dart:convert';

import 'package:doctor_app/core/component/component.dart';
import 'package:doctor_app/screen/new_dashboard/appointments_model.dart';
import 'package:doctor_app/service/api_config.dart';
import 'package:doctor_app/service/api_services.dart';
import 'package:flutter/cupertino.dart';

class CalenderProvider extends ChangeNotifier{
  final _service = ApiService();
  bool _isFetching = false;
  bool get isFetching => _isFetching;



  AppointmentsModel? _appointmentsModel;
  AppointmentsModel? get appointmentsModel => _appointmentsModel;
  Future getAppointments() async {

    String userId=await getUserID();
    print('=======uswer$userId');
    _isFetching = true;
    notifyListeners();
    try {


      final response = await _service.callGetMethod(
          url: '${ApiConfig.getDoctorAppointments}/$userId');
      _appointmentsModel = AppointmentsModel.fromJson(json.decode(response));



      _isFetching = false;
      notifyListeners();
    } catch (e) {
      _isFetching = false;
      notifyListeners();
    }
  }

  // Get today's and yesterday's date
  List<Appointments>? getTodayAppointments() {
    DateTime now = DateTime.now().toUtc();
    DateTime today = DateTime(now.year, now.month, now.day);
    return _appointmentsModel?.appointments.where((appointment) {

      DateTime dateTime = DateTime.parse(appointment.dateTime??DateTime.now().toString());

      // Extract year, month, and day
      int year = dateTime.year;
      int month = dateTime.month;
      int day = dateTime.day;

      return year == today.year &&
          month== today.month &&
          day == today.day;
    }).toList();
  }

  List<Appointments>? getYesterdayAppointments() {
    DateTime now = DateTime.now().toUtc();
    DateTime yesterday = DateTime(now.year, now.month, now.day).subtract(Duration(days: 1));
    return _appointmentsModel?.appointments.where((appointment) {

      DateTime dateTime = DateTime.parse(appointment.dateTime??DateTime.now().toString());

      // Extract year, month, and day
      int year = dateTime.year;
      int month = dateTime.month;
      int day = dateTime.day;

      return year == yesterday.year &&
          month== yesterday.month &&
          day == yesterday.day;
    }).toList();
  }

}