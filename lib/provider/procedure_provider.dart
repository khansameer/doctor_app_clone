import 'dart:convert';

import 'package:doctor_app/core/component/component.dart';
import 'package:doctor_app/service/gloable_status_code.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

import '../screen/web_view/screen/procedure/model/procedure_model.dart';
import '../service/api_config.dart';
import '../service/api_services.dart';

class ProcedureProvider extends ChangeNotifier {
  final _service = ApiService();
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _isDelete = false;
  bool get isDelete => _isDelete;
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
      if (kDebugMode) {
        print('======${response.toString()}');
      }

      _isLoading = false;
      notifyListeners();
      return response;
    } catch (e) {
      _isLoading = false;
      notifyListeners();
    }
  }

  List<ProcedureModel> _procedureList = [];

  List<ProcedureModel> get procedureList => _procedureList;
  Future getProcedureCharges({required BuildContext context}) async {
    _isLoading = true;
    notifyListeners();
    try {
      String userID = await getUserID();
      final response = await _service.callGetMethod(
          url: '${ApiConfig.addProcedureCharges}/doctor/$userID');
      List<dynamic> body = jsonDecode(response);

      if (globalStatusCode == 200 || globalStatusCode == 201) {
        _procedureList =
            body.map((dynamic item) => ProcedureModel.fromJson(item)).toList();
      } else if (globalStatusCode == 401) {
        commonSessionError(context: context);
      } else {
        _procedureList = [];
      }

      _isLoading = false;
      notifyListeners();
      return response;
    } catch (e) {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future deleteProcedureCharges(
      {required BuildContext context, required String id}) async {
    _isDelete = true;
    notifyListeners();
    try {
      //String userID = await getUserID();
      final response = await _service.callDeleteMethods(
          url: '${ApiConfig.addProcedureCharges}/$id');

      print('===addProcedureCharges ==z$globalStatusCode');

      if (globalStatusCode == 200 || globalStatusCode == 201) {
        getProcedureCharges(context: context);
      } else if (globalStatusCode == 401) {
        commonSessionError(context: context);
      } else {
        //_procedureList = [];
      }

      _isDelete = false;
      notifyListeners();
      return response;
    } catch (e) {
      _isDelete = false;
      notifyListeners();
    }
  }
}
