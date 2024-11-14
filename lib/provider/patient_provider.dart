import 'dart:convert';

import 'package:doctor_app/core/component/component.dart';
import 'package:doctor_app/screen/web_view/model/patient_details_model.dart';
import 'package:doctor_app/service/api_config.dart';
import 'package:doctor_app/service/gloable_status_code.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../screen/web_view/admin_dashboard_view/patient_profile_dialog.dart';
import '../screen/web_view/admin_dashboard_view/patient_profile_dialog.dart';
import '../service/api_services.dart';
import 'model/CommonPaitentDetailsModel.dart';

class PatientProvider with ChangeNotifier {
  bool _isAdding = false;
  bool get isAdding => _isAdding;
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  final _service = ApiService();
  PatientDetailsModel? _patientDetailsModel;

  PatientDetailsModel? get patientDetailsModel => _patientDetailsModel;

  List<Patients>? _filteredPatients;
  List<Patients>? get filteredPatients => _filteredPatients;
  String? _selectedID;

  bool isProfileDialogOpen = false;
  OverlayEntry? overlayEntry;

  void showProfileOverlay({var size, required String patientID, required BuildContext context}) {
    if (!isProfileDialogOpen) {
      isProfileDialogOpen = true;
      notifyListeners();

      overlayEntry = OverlayEntry(
        builder: (BuildContext context) {
          return Positioned(
            top: 100, // Adjust this to position the overlay as needed
            left: (size.width - size.width * 0.2) / 2,
            child: Material(
              color: Colors
                  .transparent, // Ensures only the dialog area is affected
              child: SizedBox(
                width: size.width * 0.22,
                height: 380, // Adjust height as needed
                child: Material(
                  color: Colors.white, // Set the background color of the dialog
                  elevation: 8.0, // Add shadow/elevation
                  borderRadius: BorderRadius.circular(8),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: PatientProfileDialog(patientID: patientID),
                  ),
                ),
              ),
            ),
          );
        },
      );

      Overlay.of(context).insert(overlayEntry!);
    }
  }

  void hideProfileOverlay() {
    if (isProfileDialogOpen && overlayEntry != null) {
      overlayEntry?.remove();
      overlayEntry = null;
      isProfileDialogOpen = false;
      notifyListeners();
    }
  }

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
      print('===error==$globalStatusCode');
      print('===response==${json.decode(response)}');
      if (globalStatusCode == 200 || globalStatusCode == 201) {
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
      print('===error==$e');
      print('===error==$globalStatusCode');
      notifyListeners();
    }
  }

  CommonPatientDetailsModel? _commonPatientDetailsModel;

  CommonPatientDetailsModel? get commonPatientDetailsModel => _commonPatientDetailsModel;

  Future getPatientDetailsBYID({required BuildContext context,String? patientID}) async {
    //String userId = await getUserID();

    _isLoading = true;
    notifyListeners();
    try {
      final response = await _service.callGetMethod(
          url: '${ApiConfig.getPatients}/$patientID/details');
      print('===error==$globalStatusCode');
      print('===response==${json.decode(response)}');
      if (globalStatusCode == 200 || globalStatusCode == 201) {
        _commonPatientDetailsModel =
            CommonPatientDetailsModel.fromJson(json.decode(response));
      } else if (globalStatusCode == 401) {
        commonSessionError(context: context);
      }

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      print('===error==$e');
      print('===error==$globalStatusCode');
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

  void filterFemalePatientsOver30({required String gender}) {
    _filteredPatients = _patientDetailsModel?.patients.where((patient) {
      final age = calculateAge(
          DateTime.parse(patient.dateOfBirth ?? DateTime.now().toString()));
      return patient.gender?.toLowerCase() == gender && age > 30;
    }).toList();
    notifyListeners(); // Use if you're working with a provider or similar state management
  }

  void filterFemalePatientsUnder30({required String gender}) {
    _filteredPatients = _patientDetailsModel?.patients.where((patient) {
      final age = calculateAge(
          DateTime.parse(patient.dateOfBirth ?? DateTime.now().toString()));
      return patient.gender?.toLowerCase() == gender && age < 30;
    }).toList();

    notifyListeners(); // Use if you're working with a provider or similar state management
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

  void getAlLList() {
    try {
      _selectedLetter = null;
      _selectedGender = null;
      _searchQuery = "";
      // Ensure _filteredPatients is set to the original full list of patients.
      _filteredPatients = List.from(_patientDetailsModel?.patients ?? []);
      notifyListeners();
    } catch (e) {
      print('Error retrieving all patients: $e');
    }

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

  int calculateAge(DateTime dateOfBirth) {
    final currentDate = DateTime.now();
    int age = currentDate.year - dateOfBirth.year;
    if (currentDate.month < dateOfBirth.month ||
        (currentDate.month == dateOfBirth.month &&
            currentDate.day < dateOfBirth.day)) {
      age--;
    }
    return age;
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
