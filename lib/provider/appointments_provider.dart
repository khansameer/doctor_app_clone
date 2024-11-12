import 'dart:convert';

import 'package:doctor_app/core/component/component.dart';
import 'package:doctor_app/screen/web_view//model/appointments_model.dart';
import 'package:doctor_app/screen/web_view/screen/calender/model/create_appointment_model.dart';
import 'package:doctor_app/screen/web_view/screen/calender/model/get_appointments_details_model.dart';

import 'package:doctor_app/service/api_config.dart';
import 'package:doctor_app/service/api_services.dart';
import 'package:doctor_app/service/gloable_status_code.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class AppointmentsProvider extends ChangeNotifier {
  final _service = ApiService();
  bool _isFetching = false;
  bool get isFetching => _isFetching;

  bool _isAdding = false;
  bool get isAdding => _isAdding;
  String? _selectedValue;

  String? get selectedValue => _selectedValue;

  void updateValue(String? data) {
    _selectedValue = data;
    notifyListeners();
  }

  String? _selectAPTName;
  String? get selectAPTName => _selectAPTName;

  void setAptName(String? data) {
    _selectAPTName = data;
    notifyListeners();
  }

  String? _selectGender;
  String? get selectGender => _selectGender;

  void setGenderValue(String? data) {
    _selectGender = data;
    notifyListeners();
  }

  List<String> appointmentType = [
    "Routine Checkup",
  //  "Emergency",
    "Consultation",
    "Sick Visit",
    "Examination",
  ];
  String? _selectedID;

  String? get selectedID => _selectedID;
  void updateID(String? data) {
    _selectedID = data;
    notifyListeners();
  }

  ////////////////////////////////////////AppCode

  DateTime _selectedDate = DateTime.now();

  List<Appointments>? get appointments => _appointmentsModel?.data?.appointments
      ?.where((appointment) =>
          appointment.dateTime
              ?.startsWith(_selectedDate.toString().substring(0, 10)) ??
          false)
      .toList();

  DateTime get selectedDate => _selectedDate;
  void setSelectedDate(DateTime date) {
    _selectedDate = date;
    notifyListeners();
  }
  //=============================================================================

  AppointmentsModel? _appointmentsModel;

  AppointmentsModel? get appointmentsModel => _appointmentsModel;

  Future getAppointments(
      {bool? isConsultation = false, required BuildContext context}) async {
    String userId = await getUserID();

    _isFetching = true;
    notifyListeners();
    try {
      final response = await _service.callGetMethod(
          url: '${ApiConfig.getDoctorAppointments}/$userId');

      if (kDebugMode) {
        print('==Appointments==${json.decode(response)}');
      }

      _appointmentsModel = AppointmentsModel.fromJson(json.decode(response));

      if (globalStatusCode == 401) {
        commonSessionError(context: context);
      }

      _isFetching = false;
      notifyListeners();
    } catch (e) {
      _isFetching = false;
      notifyListeners();
    }
  }

  GetAppointmentsDetailsModel? _appointmentsDetailsModel;
  List<Appointments>? get todayAppointments => getTodayAppointments();

  GetAppointmentsDetailsModel? get appointmentsDetailsModel =>
      _appointmentsDetailsModel;
  Future getAppointmentsDetailsBYID(
      {required String appointmentsID, required BuildContext context}) async {
    // String userId = await getUserID();

    _isFetching = true;
    notifyListeners();
    try {
      final response = await _service.callGetMethod(
          url: '${ApiConfig.createAppointment}/$appointmentsID');

      if (globalStatusCode == 200 || globalStatusCode == 201) {
        _appointmentsDetailsModel =
            GetAppointmentsDetailsModel.fromJson(json.decode(response));
      } else if (globalStatusCode == 401) {
        commonSessionError(context: context);
      }
      if (kDebugMode) {
        print('==Appointments==${json.decode(response)}');
      }

      _isFetching = false;
      notifyListeners();
    } catch (e) {
      _isFetching = false;
      notifyListeners();
    }
  }

  CreateAppointmentModel? _createAppointmentModel;

  CreateAppointmentModel? get createAppointmentModel => _createAppointmentModel;
  Future createAppointment({
    required BuildContext context,
    required Map<String, dynamic> body,
  }) async {
    _isAdding = true;
    notifyListeners();
    try {
      final response = await _service.callPostMethodApiWithToken(
          url: ApiConfig.createAppointment, body: body);

      print('==globalStatusCode==%${globalStatusCode}');
      _createAppointmentModel =
          CreateAppointmentModel.fromJson(json.decode(response));
      if (globalStatusCode == 200 || globalStatusCode == 201) {
        getAppointments(context: context);
      } else if (globalStatusCode == 401) {
        commonSessionError(context: context);
      } else {
        showCommonDialog(
            context: context,
            title: "Error",
            content: "Something went wrong please try again after sometime.",
            isMessage: true);
      }

      _isAdding = false;
      notifyListeners();
    } catch (e) {
      _isAdding = false;
      notifyListeners();
    }
  }

  Future updateAppointmentData({
    required BuildContext context,
    required String appointmentsID,
    required Map<String, dynamic> body,
  }) async {
    _isAdding = true;
    notifyListeners();
    try {
      final response = await _service.callPutMethodApiWithToken(
          url: '${ApiConfig.createAppointment}/$appointmentsID', body: body);
      _createAppointmentModel =
          CreateAppointmentModel.fromJson(json.decode(response));
      if (globalStatusCode == 200 || globalStatusCode == 201) {
        getAppointments(context: context);
      } else if (globalStatusCode == 401) {
        commonSessionError(context: context);
      } else {
        showCommonDialog(
            context: context,
            title: "Error",
            content: "Something went wrong please try again after sometime.",
            isMessage: true);
      }

      _isAdding = false;
      notifyListeners();
    } catch (e) {
      _isAdding = false;
      notifyListeners();
    }
  }

  List<Appointments>? getTodayAppointments() {
    DateTime now = DateTime.now().toUtc();
    DateTime today = DateTime(now.year, now.month, now.day);

    // Filter today's appointments
    List<Appointments>? todayAppointments =
        _appointmentsModel?.data?.appointments?.where((appointment) {
      if (appointment.dateTime == null) return false;

      DateTime dateTime = DateTime.parse(appointment.dateTime!);

      // Check if dateTime is on the same day as today
      return dateTime.isAtSameMomentAs(today) ||
          (dateTime.isAfter(today) &&
              dateTime.isBefore(today.add(const Duration(days: 1))));
    }).toList();

    notifyListeners();

    return todayAppointments;
  }
}
