import 'dart:convert';

import 'package:doctor_app/service/api_config.dart';
import 'package:doctor_app/service/api_services.dart';
import 'package:flutter/cupertino.dart';

import '../core/component/component.dart';
import '../service/gloable_status_code.dart';
import 'model/PrescriptionDetailsModel.dart';

class Prescription {
  final String tablet;
  final String frequency;
  final String duration;
  final String instructions;

  Prescription(
      {required this.tablet,
      required this.frequency,
      required this.duration,
      required this.instructions});
}

class PrescriptionProvider with ChangeNotifier {
  final _service = ApiService();
  bool _isFetching = false;
  bool _isAdding = false;
  bool get isAdding => _isAdding;
  bool get isFetching => _isFetching;

  List<String> whenToTake = ["Morning", "Afternoon", "Night"];
  List<String> _selectedDaysTake = [];

  List<String> get selectedDaysTake => _selectedDaysTake;

  void setSelectedDaysTake(List<String> items) {
    _selectedDaysTake = items;
    print('Updated selectedDaysTake: $_selectedDaysTake'); // Debug print
    notifyListeners();
  }

  Future addPrescription({
    required BuildContext context,
    required Map<String, dynamic> body,
  }) async {
    _isAdding = true;
    notifyListeners();
    try {
      final response = await _service.callPostMethodApiWithToken(
          url: ApiConfig.addPrescription, body: body);
      print("=========addPrescription=========${globalStatusCode}");
      if (globalStatusCode == 200 || globalStatusCode == 201) {
        print("=========addPrescription=========${json.decode(response)}");
        getPrescription(context: context);
        notifyListeners();

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


  Future editPrescription({
    required BuildContext context,
    required String id,
    required Map<String, dynamic> body,
  }) async {
    _isAdding = true;
    notifyListeners();
    try {
      final response = await _service.callPutMethodApiWithToken(
          url: '${ApiConfig.addPrescription}/$id', body: body);

      if (globalStatusCode == 200 || globalStatusCode == 201) {
        print(json.decode(response));
        getPrescription(context: context);
        notifyListeners();
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


  PrescriptionDetailsModel? _prescriptionDetailsModel;

  PrescriptionDetailsModel? get prescriptionDetailsModel =>
      _prescriptionDetailsModel;

  Future getPrescription({
    required BuildContext context,
  }) async {
    _isFetching = true;
    notifyListeners();
    try {
      final response = await _service.callGetMethodApiWithToken(
        url: ApiConfig.addPrescription,
      );

      if (globalStatusCode == 200 || globalStatusCode == 201) {
        _prescriptionDetailsModel =
            PrescriptionDetailsModel.fromJson(json.decode(response));
        print('===length==${_prescriptionDetailsModel?.medications?.length}');
        print(json.decode(response));
      } else if (globalStatusCode == 401) {
        commonSessionError(context: context);
      }

      _isFetching = false;
      notifyListeners();
    } catch (e) {
      _isFetching = false;
      notifyListeners();
    }
  }

  Future deletePrescription({
    required BuildContext context,
    String? id,
  }) async {
    _isAdding = true;
    notifyListeners();
    try {
      final response = await _service.callDeleteMethods(
        url: '${ApiConfig.addPrescription}/$id',
      );
      print('====$response');
      print(globalStatusCode);
      if (globalStatusCode == 200 || globalStatusCode == 201) {
        print(json.decode(response));
        getPrescription(context: context);
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
}
