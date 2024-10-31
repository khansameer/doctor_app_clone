import 'dart:convert';

import 'package:doctor_app/core/component/component.dart';
import 'package:doctor_app/screen/web_view/model/patient_details_model.dart';
import 'package:doctor_app/service/api_config.dart';
import 'package:doctor_app/service/gloable_status_code.dart';
import 'package:flutter/cupertino.dart';

import '../service/api_services.dart';

class PatientProvider with ChangeNotifier {
  bool _isAdding = false;
  bool get isAdding => _isAdding;
  final _service = ApiService();
  PatientDetailsModel? _patientDetailsModel;

  PatientDetailsModel? get patientDetailsModel => _patientDetailsModel;

  List<Patients>? _filteredPatients;
  List<Patients>? get filteredPatients => _filteredPatients;
  String? _selectedID;

  String? get selectedID => _selectedID;
  void updateID(String? data) {
    _selectedID = data;
    notifyListeners();
  }

  Future getPatientDetails({required BuildContext context}) async {
    String userId = await getUserID();

    _isAdding = true;
    notifyListeners();
    try {
      final response = await _service.callGetMethod(
          url: '${ApiConfig.getPatientDetails}/$userId/patients');

      if (globalStatusCode == 200 || globalStatusCode == 200) {
        _patientDetailsModel =
            PatientDetailsModel.fromJson(json.decode(response));
        _filteredPatients = _patientDetailsModel?.patients;
      } else if (globalStatusCode == 401) {
        commonSessionError(context: context);
      }

      _isAdding = false;
      notifyListeners();
    } catch (e) {
      _isAdding = false;
      notifyListeners();
    }
  }

  String? _selectedGender;
  String _searchQuery = "";
  String? _selectedLetter;
  List<Patients>? get patients {
    return _filteredPatients?.where((patient) {
      final matchesLetter = _selectedLetter == null ||
          patient.firstName
              .toString()
              .toUpperCase()
              .startsWith(_selectedLetter!);
      final matchesGender = _selectedGender == null ||
          patient.gender.toString().toLowerCase() == _selectedGender;
      final matchesQuery = patient.firstName
          .toString()
          .toLowerCase()
          .contains(_searchQuery.toLowerCase());
      return matchesLetter && matchesGender && matchesQuery;
    }).toList();
  }

  Set<String>? get availableLetters {
    return _filteredPatients
        ?.map((patient) => patient.firstName.toString()[0].toUpperCase())
        .toSet();
  }

  void selectLetter(String? letter) {
    _selectedLetter = letter;
    print('=========latter$letter');
    notifyListeners();
  }

  void filterByGender(String? gender) {
    _selectedGender = gender;
    notifyListeners();
  }

  void updateSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  void clearFilter() {
    _selectedLetter = null;
    _selectedGender = null;
    _searchQuery = "";
    notifyListeners();
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
      /* _createAppointmentModel =
          CreateAppointmentModel.fromJson(json.decode(response));*/
      if (globalStatusCode == 200 || globalStatusCode == 201) {
        // getAppointments(context: context);
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
}
