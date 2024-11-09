import 'dart:convert';

import 'package:doctor_app/service/api_config.dart';
import 'package:doctor_app/service/gloable_status_code.dart';
import 'package:flutter/cupertino.dart';

import '../core/component/component.dart';
import '../service/api_services.dart';
class Address {
  String address1;
  String address2;
  String phoneNumber;
  String city;
  String state;
  String country;
  String zipcode;

  Address({
    required this.address1,
    required this.address2,
    required this.phoneNumber,
    required this.city,
    required this.state,
    required this.country,
    required this.zipcode,
  });

  // To create a map from the Address object (useful for JSON conversion)
  Map<String, dynamic> toMap() {
    return {
      'address1': address1,
      'address2': address2,
      'phoneNumber': phoneNumber,
      'city': city,
      'state': state,
      'country': country,
      'zipcode': zipcode,
    };
  }

  // To create an Address object from a map (useful for JSON parsing)
  factory Address.fromMap(Map<String, dynamic> map) {
    return Address(
      address1: map['address1'],
      address2: map['address2'],
      phoneNumber: map['phoneNumber'],
      city: map['city'],
      state: map['state'],
      country: map['country'],
      zipcode: map['zipcode'],
    );
  }
}

class AddressProvider with ChangeNotifier{
  final _service = ApiService();
  bool _isFetching = false;
  bool _isAdding = false;
  bool get isAdding => _isAdding;
  bool get isFetching => _isFetching;


  Future getAddress({required BuildContext context}) async {
    String userId = await getUserID();

    _isFetching = true;
    notifyListeners();
    try {
      final response = await _service.callGetMethod(
          url: '${ApiConfig.getDoctor}/$userId/edit');

      if (globalStatusCode == 200 || globalStatusCode == 201) {
        print(json.decode(response));
        /*  _patientDetailsModel =
            PatientDetailsModel.fromJson(json.decode(response));
        _filteredPatients = _patientDetailsModel?.patients;*/
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


  // List of 20 dummy addresses
  List<Address> dummyAddresses = [
    Address(
      address1: '1234 Elm St',
      address2: 'Apt 5B',
      phoneNumber: '+1 234-567-8901',
      city: 'New York',
      state: 'NY',
      country: 'USA',
      zipcode: '10001',
    ),
    Address(
      address1: '5678 Oak Ave',
      address2: 'Suite 4C',
      phoneNumber: '+1 345-678-9012',
      city: 'Los Angeles',
      state: 'CA',
      country: 'USA',
        zipcode: '90001',
    ),
    Address(
      address1: '91011 Pine Rd',
      address2: 'Unit 7D',
      phoneNumber: '+1 456-789-0123',
      city: 'Chicago',
      state: 'IL',
      country: 'USA',
      zipcode: '60601',
    ),

    // Continue with more entries...
  ];



  void deleteItem(int index) {
    dummyAddresses.removeAt(index);
    notifyListeners(); // Notifies listeners to rebuild UI
  }
}