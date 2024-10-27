import 'dart:convert';

import 'package:doctor_app/core/component/component.dart';
import 'package:doctor_app/service/gloable_status_code.dart';
import 'package:flutter/cupertino.dart';

import '../service/api_config.dart';
import '../service/api_services.dart';

class ProcedureProvider extends ChangeNotifier {
  final _service = ApiService();
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  Future addProcedureCharges(
      {required Map<String, dynamic> body,
      required BuildContext context}) async {
    _isLoading = true;
    notifyListeners();
    try {
      final response = await _service.callPostMethodApiWithToken(
          url: ApiConfig.addProcedureCharges, body: body);
      if (globalStatusCode == 200 || globalStatusCode == 201) {
      } else if (globalStatusCode == 401) {
        commonSessionError(context: context);
      }
      print('======${response.toString()}');

      _isLoading = false;
      notifyListeners();
      return response;
    } catch (e) {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future getProcedureCharges({required BuildContext context}) async {
    _isLoading = true;
    notifyListeners();
    try {
      String userID = await getUserID();
      final response = await _service.callGetMethod(
          url: '${ApiConfig.addProcedureCharges}/doctor/$userID');
      // List<dynamic> body = jsonDecode(response);

      print('=====z${jsonDecode(response)}');

      /*if (globalStatusCode == 200 || globalStatusCode == 201) {
        _specializationsList = body
            .map((dynamic item) => SpecializationsModel.fromJson(item))
            .toList();
      } else if (globalStatusCode == 401) {
        commonSessionError(context: context);
      } else {
        _specializationsList = [];
      }*/

      _isLoading = false;
      notifyListeners();
      return response;
    } catch (e) {
      _isLoading = false;
      notifyListeners();
    }
  }
}
