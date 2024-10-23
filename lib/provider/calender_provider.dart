import 'dart:convert';

import 'package:doctor_app/core/component/component.dart';
import 'package:doctor_app/screen/admin/model/patient_details_model.dart';
import 'package:doctor_app/screen/admin/new_dashboard/calender/model/get_appointments_details_model.dart';
import 'package:doctor_app/service/api_config.dart';
import 'package:doctor_app/service/api_services.dart';
import 'package:doctor_app/service/gloable_status_code.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

import '../screen/admin/new_dashboard/appointments_model.dart';
import '../screen/admin/new_dashboard/calender/model/create_appointment_model.dart';

class CalenderProvider extends ChangeNotifier {
  //for  remove line

  final _service = ApiService();
  bool _isFetching = false;
  bool get isFetching => _isFetching;

  bool _isAdding = false;
  bool get isAdding => _isAdding;
  String? _selectedValue;

  String? get selectedValue => _selectedValue;

  String? _selectedID;

  String? get selectedID => _selectedID;

  void updateValue(String? data) {
    _selectedValue = data;
    notifyListeners();
  }

  void updateID(String? data) {
    _selectedID = data;
    notifyListeners();
  }

  AppointmentsModel? _appointmentsModel;

  AppointmentsModel? get appointmentsModel => _appointmentsModel;

  Future getAppointments() async {
    String userId = await getUserID();

    _isFetching = true;
    notifyListeners();
    try {
      final response = await _service.callGetMethod(
          url: '${ApiConfig.getDoctorAppointments}/$userId');

      print('==Appointments==${json.decode(response)}');
      _appointmentsModel = AppointmentsModel.fromJson(json.decode(response));

      _isFetching = false;
      notifyListeners();
    } catch (e) {
      _isFetching = false;
      notifyListeners();
    }
  }

  GetAppointmentsDetailsModel? _appointmentsDetailsModel;

  GetAppointmentsDetailsModel? get appointmentsDetailsModel =>
      _appointmentsDetailsModel;
  Future getAppointmentsDetailsBYID(String appointmentsID) async {
    // String userId = await getUserID();

    _isFetching = true;
    notifyListeners();
    try {
      final response = await _service.callGetMethod(
          url: '${ApiConfig.createAppointment}/$appointmentsID');

      print('==Appointments==${json.decode(response)}');
      _appointmentsDetailsModel =
          GetAppointmentsDetailsModel.fromJson(json.decode(response));

      _isFetching = false;
      notifyListeners();
    } catch (e) {
      _isFetching = false;
      notifyListeners();
    }
  }

  PatientDetailsModel? _patientDetailsModel;

  PatientDetailsModel? get patientDetailsModel => _patientDetailsModel;

  Future getPatientDetails() async {
    String userId = await getUserID();

    _isFetching = true;
    notifyListeners();
    try {
      final response = await _service.callGetMethod(
          url: '${ApiConfig.getPatientDetails}/$userId/patients');

      _patientDetailsModel =
          PatientDetailsModel.fromJson(json.decode(response));

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
      _createAppointmentModel =
          CreateAppointmentModel.fromJson(json.decode(response));
      if (globalStatusCode == 200 || globalStatusCode == 201) {
        getAppointments();
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
        getAppointments();
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

  Future uploadPatientFile({
    required BuildContext context,
    required String patientID,
    required Map<String, dynamic> body,
  }) async {
    _isAdding = true;
    notifyListeners();
    try {
      final response = await _service.callPutMethodApiWithToken(
          url: '${ApiConfig.createAppointment}/$patientID/files', body: body);
      _createAppointmentModel =
          CreateAppointmentModel.fromJson(json.decode(response));
      if (globalStatusCode == 200 || globalStatusCode == 201) {
        getAppointments();
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

  List<Patients>? filterBYGender({required String gender}) {
    // Filter the patients inside the existing _patientDetailsModel
    if (_patientDetailsModel != null) {
      return _patientDetailsModel!.patients
          .where((patient) =>
              patient.gender?.toLowerCase() == gender.toLowerCase())
          .toList();
    }
    notifyListeners();
    return [];
  }

  List<Patients>? filterByAge({required int age, required bool isUnder}) {
    if (_patientDetailsModel != null) {
      DateTime now = DateTime.now();

      return _patientDetailsModel!.patients.where((patient) {
        if (patient.gender.toString().toLowerCase() == "female") {
          DateTime dateTime = DateTime.parse(patient.dateOfBirth.toString());
          int patientAge = now.year - dateTime.year;

          // Adjust for cases where the birthday hasn't occurred this year yet
          if (now.month < dateTime.month ||
              (now.month == dateTime.month && now.day < dateTime.day)) {
            patientAge--;
          }

          // Return true if the patient meets the age condition
          return isUnder ? patientAge < age : patientAge >= age;
        }
        return false; // Return false if not female
      }).toList();
    }
    return [];
  }

  /* List<Patients>? filterByAge({required int age, required bool isUnder}) {
    if (_patientDetailsModel != null) {
      DateTime now = DateTime.now();

      return _patientDetailsModel!.patients.where((patient) {
        if (patient.gender.toString().toLowerCase() == "female") {
          DateTime dateTime = DateTime.parse(patient.dateOfBirth.toString());

          String formattedDate =
              formatDate(formatDate: 'yyyy-MM-dd', date: dateTime);
          DateTime dob = DateTime.parse(formattedDate);
          int patientAge = now.year - dob.year;

          // Adjust for cases where the birthday hasn't occurred this year yet
          if (now.month < dob.month ||
              (now.month == dob.month && now.day < dob.day)) {
            patientAge--;
          }
          return isUnder ? patientAge < age : patientAge >= age;
        }

        // Return true if the patient meets the age condition
      }).toList();
    }
    return [];
  }*/

  // Get today's and yesterday's date
  List<Appointments>? getTodayAppointments() {
    DateTime now = DateTime.now().toUtc();
    DateTime today = DateTime(now.year, now.month, now.day);
    return _appointmentsModel?.appointments?.where((appointment) {
      DateTime dateTime =
          DateTime.parse(appointment.dateTime ?? DateTime.now().toString());

      // Extract year, month, and day
      int year = dateTime.year;
      int month = dateTime.month;
      int day = dateTime.day;

      return year == today.year && month == today.month && day == today.day;
    }).toList();
  }

  List<Appointments>? getYesterdayAppointments() {
    DateTime now = DateTime.now().toUtc();
    DateTime yesterday = DateTime(now.year, now.month, now.day)
        .subtract(const Duration(days: 1));
    return _appointmentsModel?.appointments?.where((appointment) {
      DateTime dateTime =
          DateTime.parse(appointment.dateTime ?? DateTime.now().toString());

      // Extract year, month, and day
      int year = dateTime.year;
      int month = dateTime.month;
      int day = dateTime.day;

      return year == yesterday.year &&
          month == yesterday.month &&
          day == yesterday.day;
    }).toList();
  }
}
