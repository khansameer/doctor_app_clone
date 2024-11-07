import 'package:flutter/cupertino.dart';
class Prescription {
  final String tablet;
  final String frequency;
  final String duration;
  final String instructions;

  Prescription({required this.tablet, required this.frequency, required this.duration, required this.instructions});
}
class PrescriptionProvider with ChangeNotifier{
  final List<Prescription> prescriptions = [
    Prescription(
        tablet: 'Paracetamol 500mg',
        frequency: 'Twice a day',
        duration: '5 days',
        instructions: 'Take one tablet after meals. Do not exceed the prescribed dosage.'),
    Prescription(
        tablet: 'Amoxicillin 250mg',
        frequency: 'Three times a day',
        duration: '7 days',
        instructions: 'Take one tablet every 8 hours. Complete the full course even if you feel better.'),
    Prescription(
        tablet: 'Lisinopril 10mg',
        frequency: 'Once a day',
        duration: 'Ongoing',
        instructions: 'Take in the morning, with or without food. Monitor blood pressure regularly.'),
    Prescription(
        tablet: 'Metformin 500mg',
        frequency: 'Twice a day',
        duration: '14 days',
        instructions: 'Take with meals to reduce stomach upset. Monitor blood sugar levels.'),
    Prescription(
        tablet: 'Ibuprofen 400mg',
        frequency: 'Every 6 hours',
        duration: '3 days',
        instructions: 'Take with food to avoid gastric irritation. Do not exceed 3 doses in 24 hours.'),
    Prescription(
        tablet: 'Atorvastatin 20mg',
        frequency: 'Once a day',
        duration: 'Ongoing',
        instructions: 'Take in the evening. Avoid grapefruit while on this medication.'),
    Prescription(
        tablet: 'Cetirizine 10mg',
        frequency: 'Once a day',
        duration: '10 days',
        instructions: 'Take at night. May cause drowsiness, so avoid driving after taking it.'),
    Prescription(
        tablet: 'Omeprazole 20mg',
        frequency: 'Once a day',
        duration: '7 days',
        instructions: 'Take in the morning before breakfast. Do not crush or chew the tablet.'),
    Prescription(
        tablet: 'Salbutamol Inhaler 100mcg',
        frequency: 'As needed',
        duration: 'Ongoing',
        instructions: 'Inhale 1-2 puffs during asthma attacks. Wait 1 minute before using again.'),
    Prescription(
        tablet: 'Diazepam 5mg',
        frequency: 'Once a day',
        duration: '7 days',
        instructions: 'Take at night for sleep. May cause drowsiness. Do not operate heavy machinery.'),
  ];
}