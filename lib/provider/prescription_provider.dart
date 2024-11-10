import 'dart:convert';

import 'package:doctor_app/service/api_config.dart';
import 'package:doctor_app/service/api_services.dart';
import 'package:flutter/cupertino.dart';

import '../core/component/component.dart';
import '../service/gloable_status_code.dart';

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
  final List<Prescription> prescriptions = [
    Prescription(
        tablet: 'Paracetamol 500mg',
        frequency: 'Twice a day',
        duration: '5 days',
        instructions:
            'Take one tablet after meals. Do not exceed the prescribed dosage.'),
    Prescription(
        tablet: 'Amoxicillin 250mg',
        frequency: 'Three times a day',
        duration: '7 days',
        instructions:
            'Take one tablet every 8 hours. Complete the full course even if you feel better.'),
    Prescription(
        tablet: 'Lisinopril 10mg',
        frequency: 'Once a day',
        duration: 'Ongoing',
        instructions:
            'Take in the morning, with or without food. Monitor blood pressure regularly.'),
    Prescription(
        tablet: 'Metformin 500mg',
        frequency: 'Twice a day',
        duration: '14 days',
        instructions:
            'Take with meals to reduce stomach upset. Monitor blood sugar levels.'),
    Prescription(
        tablet: 'Ibuprofen 400mg',
        frequency: 'Every 6 hours',
        duration: '3 days',
        instructions:
            'Take with food to avoid gastric irritation. Do not exceed 3 doses in 24 hours.'),
    Prescription(
        tablet: 'Atorvastatin 20mg',
        frequency: 'Once a day',
        duration: 'Ongoing',
        instructions:
            'Take in the evening. Avoid grapefruit while on this medication.'),
    Prescription(
        tablet: 'Cetirizine 10mg',
        frequency: 'Once a day',
        duration: '10 days',
        instructions:
            'Take at night. May cause drowsiness, so avoid driving after taking it.'),
    Prescription(
        tablet: 'Omeprazole 20mg',
        frequency: 'Once a day',
        duration: '7 days',
        instructions:
            'Take in the morning before breakfast. Do not crush or chew the tablet.'),
    Prescription(
        tablet: 'Salbutamol Inhaler 100mcg',
        frequency: 'As needed',
        duration: 'Ongoing',
        instructions:
            'Inhale 1-2 puffs during asthma attacks. Wait 1 minute before using again.'),
    Prescription(
        tablet: 'Diazepam 5mg',
        frequency: 'Once a day',
        duration: '7 days',
        instructions:
            'Take at night for sleep. May cause drowsiness. Do not operate heavy machinery.'),
  ];

  List<String> whenToTake = ["morning", "afternoon", "night"];
  List<String> _selectedItems = [];

  List<String> get selectedItems => _selectedItems;

  void setSelectedItems(List<String> items) {
    _selectedItems = items;
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

      if (globalStatusCode == 200 || globalStatusCode == 201) {
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
}
