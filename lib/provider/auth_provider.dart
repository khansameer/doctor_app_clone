import 'dart:async';
import 'dart:convert';
import 'package:doctor_app/screen/authentication/model/login_model.dart';
import 'package:doctor_app/screen/authentication/model/signup_model.dart';
import 'package:doctor_app/screen/authentication/model/specializations_model.dart';
import 'package:doctor_app/service/api_config.dart';
import 'package:doctor_app/service/api_services.dart';
import 'package:doctor_app/service/gloable_status_code.dart';
import 'package:doctor_app/shared_preferences/preference_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../core/component/component.dart';
import '../core/route/route.dart';

enum Gender { male, female }

class AuthProviders extends ChangeNotifier {
  final _service = ApiService();
  bool _isFetching = false;
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  bool get isFetching => _isFetching;
  bool _isAdding = false;

  bool get isAdding => _isAdding;
  bool _isPasswordVisible = false;

  bool get isPasswordVisible => _isPasswordVisible;
  bool _isConfirmPasswordVisible = false;

  bool get isConfirmPasswordVisible => _isConfirmPasswordVisible;

  String _pin = '';

  String get pin => _pin;

  final _tetFName = TextEditingController();
  final _tetLName = TextEditingController();
  final _tetEmail = TextEditingController();
  final _tetPhoneNO = TextEditingController();
  final _tetPassword = TextEditingController();
  final _tetConfirmPassword = TextEditingController();
  final _tetDob = TextEditingController();
  TextEditingController get tetFName => _tetFName;
  TextEditingController get tetLName => _tetLName;
  TextEditingController get tetEmail => _tetEmail;
  TextEditingController get tetPhoneNO => _tetPhoneNO;
  TextEditingController get tetPassword => _tetPassword;
  TextEditingController get tetDob => _tetDob;
  TextEditingController get tetConfirmPassword => _tetConfirmPassword;

  final List<String> itemGenderList = [
    'Male',
    'Female',
    'Other',
  ];

  String? _selectedGender;

  String? get selectedGender => _selectedGender;

  set setGenderValue(String newPin) {
    _selectedGender = newPin;
    notifyListeners();
  }

  void togglePasswordVisibility() {
    _isPasswordVisible = !_isPasswordVisible;
    notifyListeners();
  }

  void toggleConfirmPasswordVisibility() {
    _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
    notifyListeners();
  }

/*  Gender _selectedGender = Gender.male; // Default selection

  Gender get selectedGender => _selectedGender;

  void selectGender(Gender gender) {
    _selectedGender = gender;
    notifyListeners();
  }*/

  //Date Picker

  DateTime _selectedDate = DateTime.now();

  DateTime get selectedDate => _selectedDate;

  String get formattedDate => DateFormat("MM-dd-yyyy").format(_selectedDate);

  void updateDate(DateTime newDate) {
    _selectedDate = newDate;
    notifyListeners();
  }

  redirectToLogin({required BuildContext context}) {
    Timer(const Duration(seconds: 3), () async {
      if (await PreferenceHelper.getBool(key: PreferenceHelper.isLOGIN) ==
          true) {
        if (kIsWeb) {
          pushNamedAndRemoveUntil(
              context: context, routeName: RouteName.adminDashboardScreen);
        } else {
          print('======csaaaa}');
          pushNamedAndRemoveUntil(
              context: context, routeName: RouteName.dashboardScreen);
        }
      } else {
        Navigator.pushNamedAndRemoveUntil(
            context, RouteName.loginScreen, (route) => false);
      }
      /* Navigator.pushNamedAndRemoveUntil(
          context, RouteName.loginScreen, (route) => false);*/
    });
  }

  String? _selectedValue;
  String? get selectedValue => _selectedValue;
  set selectionValue(String newPin) {
    _selectedValue = newPin;
    notifyListeners();
  }

  String? _selectedValueHeight;
  String? get selectedValueHeight => _selectedValueHeight;
  set selectionValueHeightValue(String newPin) {
    _selectedValueHeight = newPin;
    notifyListeners();
  }
  // for weight

  String? _selectedValueWight;
  String? get selectedValueWight => _selectedValueWight;
  set selectionValueWeightValue(String newPin) {
    _selectedValueWight = newPin;
    notifyListeners();
  }

  void resetFields() {
    _tetFName.clear();
    _tetLName.clear();
    _tetEmail.clear();
    _tetPhoneNO.clear();
    _tetDob.clear();
    _tetConfirmPassword.clear();
    _tetPassword.clear();
    // Clear other fields as needed
    notifyListeners(); // Notify listeners after resetting fields
  }

  @override
  void dispose() {
    _tetFName.dispose();
    _tetLName.dispose();
    _tetEmail.dispose();
    _tetPhoneNO.dispose();
    _tetDob.dispose();
    _tetConfirmPassword.dispose();
    _tetPassword.dispose();
    // Dispose other controllers
    super.dispose();
  }
  //==================================================================================================Api===================================================================

  LoginModel? _loginModel;

  LoginModel? get loginModel => _loginModel;
  Future<void> callLoginApi(
      {required BuildContext context,
      required Map<String, dynamic> body,
      required bool isLogin}) async {
    _isFetching = true;
    notifyListeners();
    try {
      final response = await _service.callPostMethodApi(
          url: isLogin ? ApiConfig.login : ApiConfig.registerUser, body: body);
      _loginModel = LoginModel.fromJson(json.decode(response));

      if (globalStatusCode == 200) {
        if (_loginModel?.token != null && _loginModel?.userId != null) {
          await PreferenceHelper.setString(
              key: PreferenceHelper.name,
              value: "${_loginModel?.firstName} ${_loginModel?.lastName}");
          await PreferenceHelper.setString(
              key: PreferenceHelper.email, value: '${_loginModel?.email}');
          await PreferenceHelper.setString(
              key: PreferenceHelper.authToken, value: '${_loginModel?.token}');
          await PreferenceHelper.setString(
              key: PreferenceHelper.userID, value: '${_loginModel?.userId}');
          await PreferenceHelper.setBool(
              key: PreferenceHelper.isLOGIN, value: true);
        }
      } else {
        /*showCommonDialog(
            context: context,
            title: "Error",
            content: _loginModel?.message != null
                ? '${_loginModel?.message.toString()}'
                : "Something went wrong please try again after sometime.",
            isMessage: true);*/
      }
    } catch (e) {
      // _registerModel = RegisterModel(message: 'server_error'.tr());
    }
    _isFetching = false;
    notifyListeners();
  }

  //==============================================================Get specializations List==================================================

  List<SpecializationsModel> _specializationsList = [];

  List<SpecializationsModel> get specializationsList => _specializationsList;

  List<SpecializationsModel> _selectedSpecializations = [];

  List<SpecializationsModel> get selectedSpecializations =>
      _selectedSpecializations;
  List<String> _selectedItems = [];

  List<String> get selectedItems => _selectedItems;

  void setSelectedItems(List<String> items) {
    _selectedItems = items;
    notifyListeners();
  }

  bool isItemSelected(String item) {
    return _selectedItems.contains(item);
  }

  Future getSpecializationsList() async {
    _isLoading = true;
    notifyListeners();
    try {
      final response =
          await _service.callGetMethod(url: ApiConfig.getSpecializations);
      List<dynamic> body = jsonDecode(response);
      _specializationsList = body
          .map((dynamic item) => SpecializationsModel.fromJson(item))
          .toList();

      _isLoading = false;
      notifyListeners();
      return response;
    } catch (e) {
      _isLoading = false;
      notifyListeners();
    }
  }

  //

  Future addProcedureCharges(
    Map<String, dynamic> body,
  ) async {
    _isLoading = true;
    notifyListeners();
    try {
      final response = await _service.callPostMethodApiWithToken(
          url: ApiConfig.addProcedurCharges, body: body);
      print('======${response.toString()}');
      /* List<dynamic> body = jsonDecode(response);
      _specializationsList = body
          .map((dynamic item) => SpecializationsModel.fromJson(item))
          .toList();*/

      _isLoading = false;
      notifyListeners();
      return response;
    } catch (e) {
      _isLoading = false;
      notifyListeners();
    }
  }

  //
  void toggleSelection(SpecializationsModel specialization) {
    if (_selectedSpecializations.contains(specialization)) {
      _selectedSpecializations.remove(specialization);
    } else {
      _selectedSpecializations.add(specialization);
    }
    notifyListeners();
  }

  void clearSelection() {
    _selectedSpecializations.clear();
    notifyListeners();
  }

  SignupModel? _signupModel;

  SignupModel? get signupModel => _signupModel;

  Future<void> signupAPI(
      {required Map<String, dynamic> body,
      required BuildContext context}) async {
    _isAdding = true;
    notifyListeners();
    try {
      final response = await _service.callPostMethodApiWithToken(
          url: ApiConfig.addDoctor, body: body);

      _signupModel = SignupModel.fromJson(json.decode(response));

      if (globalStatusCode == 200 || globalStatusCode == 201) {
        if (_signupModel?.doctor?.sId != null) {}
      } else {
        showCommonDialog(
            context: context,
            title: "Error",
            content: '${_signupModel?.message.toString()}',
            isMessage: true);
      }

      _isAdding = false;
      notifyListeners();
    } catch (e) {
      _isAdding = false;
      notifyListeners();
      if (kDebugMode) {
        print('=====fail ${e.toString()}');
      }
      // _registerModel = RegisterModel(message: 'server_error'.tr());
    }
    _isAdding = false;
    notifyListeners();
  }
}
