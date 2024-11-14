import 'dart:convert';

import 'package:doctor_app/core/string/string_utils.dart';
import 'package:doctor_app/service/api_config.dart';
import 'package:doctor_app/service/gloable_status_code.dart';
import 'package:flutter/cupertino.dart';

import '../core/component/component.dart';
import '../service/api_services.dart';
import 'model/GetAddressModel.dart';


class AddressProvider with ChangeNotifier {
  final _service = ApiService();
  bool _isFetching = false;
  bool _isAdding = false;
  bool get isAdding => _isAdding;
  bool get isFetching => _isFetching;
  bool _isDeleting = false;
  bool get isDeleting => _isDeleting;
  int? _hoverEdit;

  int? get hoverEdit => _hoverEdit;

  void setHoverEdit(int? index) {
    _hoverEdit = index;
    notifyListeners();
  }

  int? _hoverDelete;

  int? get hoverDelete => _hoverDelete;

  void setHoverDelete(int? index) {
    _hoverDelete = index;
    notifyListeners();
  }

  GetAddressModel? _getAddressModel;
  GetAddressModel? get getAddressModel => _getAddressModel;


  Future getAddress({required BuildContext context}) async {
    String userId = await getUserID();

    _isFetching = true;
    notifyListeners();
    try {
      final response = await _service.callGetMethod(
          url: '${ApiConfig.getDoctor}/$userId/addresses');

      if (globalStatusCode == 200 || globalStatusCode == 201) {
        print('=======Myaddrtesss ${json.decode(response)}');
        _getAddressModel =
            GetAddressModel.fromJson(json.decode(response));


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

  Future addAddress({
    required BuildContext context,
    required Map<String, dynamic> body,
  }) async {
    String userId = await getUserID();

    _isAdding = true;
    notifyListeners();
    try {
      final response = await _service.callPostMethodApiWithToken(
          url: '${ApiConfig.getDoctor}/$userId/addresses', body: body);

      if (globalStatusCode == 200 || globalStatusCode == 201) {
        getAddress(context: context);
        print(json.decode(response));
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


  Future updateAddress({
    required BuildContext context,
    String? addressID,
    required Map<String, dynamic> body,
  }) async {
    String userId = await getUserID();

    _isAdding = true;
    notifyListeners();
    try {
      final response = await _service.callPutMethodApiWithToken(
          url: '${ApiConfig.getDoctor}/$userId/addresses/$addressID', body: body);

      if (globalStatusCode == 200 || globalStatusCode == 201) {
        print(json.decode(response));
        getAddress(context: context);
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

  Future deleteAddress({
    required BuildContext context,
    String? addressID,
  }) async {
    String userId = await getUserID();

    _isDeleting = true;
    notifyListeners();
    try {
      final response = await _service.callDeleteMethods(
          url: '${ApiConfig.getDoctor}/$userId/addresses/$addressID');

      if (globalStatusCode == 200 || globalStatusCode == 201) {
        print(json.decode(response));
        getAddress(context: context);
        notifyListeners();
      } else if (globalStatusCode == 401) {
        commonSessionError(context: context);
      }

      _isDeleting = false;
      notifyListeners();
    } catch (e) {
      _isDeleting = false;
      notifyListeners();
    }
  }

  // List of 20 dummy addresses

  void deleteItem(int index) {
   // dummyAddresses.removeAt(index);
    notifyListeners(); // Notifies listeners to rebuild UI
  }
}
