import 'dart:convert';

import 'package:doctor_app/core/component/component.dart';
import 'package:doctor_app/screen/web_view//model/appointments_model.dart';
import 'package:doctor_app/screen/web_view/model/patient_details_model.dart';
import 'package:doctor_app/screen/web_view/screen/calender/model/create_appointment_model.dart';
import 'package:doctor_app/screen/web_view/screen/calender/model/get_appointments_details_model.dart';

import 'package:doctor_app/service/api_config.dart';
import 'package:doctor_app/service/api_services.dart';
import 'package:doctor_app/service/gloable_status_code.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';



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



  ////////////////////////////////////////AppCode



  DateTime _selectedDate = DateTime.now();

  List<Appointments>? get appointments => _appointmentsModel?.appointments
      ?.where((appointment) =>
  appointment.dateTime?.startsWith(_selectedDate.toString().substring(0, 10)) ?? false)
      .toList();


  DateTime get selectedDate => _selectedDate;
  void setSelectedDate(DateTime date) {
    _selectedDate = date;
    notifyListeners();
  }
  //=============================================================================

  AppointmentsModel? _appointmentsModel;

  AppointmentsModel? get appointmentsModel => _appointmentsModel;

  Future getAppointments({bool? isConsultation=false}) async {
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
  Future getAppointmentsDetailsBYID(String appointmentsID) async {
    // String userId = await getUserID();

    _isFetching = true;
    notifyListeners();
    try {
      final response = await _service.callGetMethod(
          url: '${ApiConfig.createAppointment}/$appointmentsID');

      if (kDebugMode) {
        print('==Appointments==${json.decode(response)}');
      }
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

  List<Patients>? _filteredPatients;
  List<Patients>? get filteredPatients => _filteredPatients;

  Future getPatientDetails() async {
    String userId = await getUserID();

    _isAdding = true;
    notifyListeners();
    try {
      final response = await _service.callGetMethod(
          url: '${ApiConfig.getPatientDetails}/$userId/patients');

      _patientDetailsModel =
          PatientDetailsModel.fromJson(json.decode(response));
      _filteredPatients = _patientDetailsModel?.patients;
      _isAdding = false;
      notifyListeners();
    } catch (e) {
      _isAdding = false;
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

  void filterBYGenders({required String gender}) {
    _filteredPatients = _patientDetailsModel?.patients
        .where((patient) => patient.gender?.toLowerCase() == gender.toLowerCase())
        .toList();
    notifyListeners();
  }

  void searchPatients(String query) {
    if (query.isEmpty) {
      _filteredPatients = _patientDetailsModel?.patients;
    } else {
      _filteredPatients = _patientDetailsModel?.patients.where((patient) {
        return patient.firstName.toString().toLowerCase().contains(query.toLowerCase()) ||
            patient.sId.toString().contains(query) ||
            patient.phoneNumber.toString().contains(query);
      }).toList();
    }
    notifyListeners();
  }
  void getAllPatientsData() {
    _filteredPatients = _patientDetailsModel?.patients; // Reset to show all patients
    notifyListeners();
  }
  void filterByAges({required int age, required bool isUnder}) {
    DateTime now = DateTime.now();
    _filteredPatients = _patientDetailsModel?.patients.where((patient) {
      DateTime dateTime = DateTime.parse(patient.dateOfBirth.toString());
      int patientAge = now.year - dateTime.year;
      if (now.month < dateTime.month || (now.month == dateTime.month && now.day < dateTime.day)) {
        patientAge--;
      }
      return isUnder ? patientAge < age : patientAge >= age;
    }).toList();

    notifyListeners();
  }


  List<Appointments>? getTodayAppointments() {
    DateTime now = DateTime.now().toUtc();
    DateTime today = DateTime(now.year, now.month, now.day);

    // Filter today's appointments
    List<Appointments>? todayAppointments = _appointmentsModel?.appointments?.where((appointment) {
      if (appointment.dateTime == null) return false;

      DateTime dateTime = DateTime.parse(appointment.dateTime!);

      // Check if dateTime is on the same day as today
      return dateTime.isAtSameMomentAs(today) ||
          (dateTime.isAfter(today) && dateTime.isBefore(today.add(Duration(days: 1))));
    }).toList();

    notifyListeners();

    return todayAppointments;
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


  List<String> _names = ['Alice', 'Bob', 'Charlie']; // Initial list of names
  String _searchTerm = '';
  String _selectedName = '';

  List<String> get filteredNames {
    if (_searchTerm.isEmpty) {
      return [];
    }
    return _names
        .where((name) => name.toLowerCase().contains(_searchTerm.toLowerCase()))
        .toList();
  }

  String get selectedName => _selectedName;

  bool get hasSearchStarted => _searchTerm.isNotEmpty;

  void setSearchTerm(String term) {
    _searchTerm = term;
    notifyListeners();
  }

  void addName(String name) {
    _names.add(name);
    setSelectedName(name);
    _searchTerm = '';
    notifyListeners();
  }

  void setSelectedName(String name) {
    _selectedName = name;
    notifyListeners();
  }

  bool get isNameNotFound => filteredNames.isEmpty && _searchTerm.isNotEmpty;




}
