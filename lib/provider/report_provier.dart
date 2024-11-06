import 'package:flutter/cupertino.dart';

class ReportProvider with ChangeNotifier {
  String? _selectedValue;
  String? get selectedValue => _selectedValue;




  String? _name;
  String? get name => _name;
  String? _image;
  String? get image => _image;

  set setName(String name) {
    _name = name;
    notifyListeners();
  }

  set setImage(String image) {
    _image = image;
    notifyListeners();
  }

  set setSelectData(String newPin) {
    _selectedValue = newPin;
    notifyListeners();
  }

  List<Map<String, dynamic>> patientReportCategories = [
    {
      "id": 1,
      "title": "Personal Information",
      "description": "Basic personal details of the patient"
    },
    {
      "id": 2,
      "title": "Medical History",
      "description": "Past medical conditions and treatments"
    },
    {
      "id": 3,
      "title": "Current Medications",
      "description": "List of medications currently being taken"
    },
    {
      "id": 4,
      "title": "Vital Signs",
      "description": "Latest recorded vital signs like BP, heart rate"
    },
    {
      "id": 5,
      "title": "Laboratory Results",
      "description": "Blood tests, urinalysis, and other lab results"
    },
    {
      "id": 6,
      "title": "Current Symptoms",
      "description": "Symptoms reported by the patient"
    },
    {
      "id": 7,
      "title": "Diagnosis",
      "description": "Current diagnosis and differential diagnoses"
    },
    {
      "id": 8,
      "title": "Treatment Plan",
      "description": "Plan for medication, therapy, and lifestyle changes"
    },
    {
      "id": 9,
      "title": "Progress Notes",
      "description": "Daily observations and response to treatments"
    },
    {
      "id": 10,
      "title": "Immunization Records",
      "description": "Vaccination history of the patient"
    },
    {"id": 11, "title": "Allergies", "description": "List of known allergies"},
    {
      "id": 12,
      "title": "Surgical History",
      "description": "Details of any past surgeries"
    },
    {
      "id": 13,
      "title": "Family Medical History",
      "description": "Relevant family medical history"
    },
    {
      "id": 14,
      "title": "Social History",
      "description": "Lifestyle factors like smoking, alcohol, occupation"
    },
    {
      "id": 15,
      "title": "Mental Health History",
      "description": "Psychiatric and psychological history"
    },
    {
      "id": 16,
      "title": "Discharge Summary",
      "description": "Summary of diagnosis, treatment, and follow-up"
    },
    {
      "id": 17,
      "title": "Billing Information",
      "description": "Insurance and billing details"
    },
    {
      "id": 18,
      "title": "Advance Directives",
      "description": "Legal documents for patient care decisions"
    },
    {
      "id": 19,
      "title": "Physician's Notes",
      "description": "Notes from attending doctors"
    },
    {
      "id": 20,
      "title": "Radiology Reports",
      "description": "Imaging reports like X-rays, MRI, and CT scans"
    },
  ];
  final List<Map<String, dynamic>> data = [
    {
      "S.No.": 1,
      "Date": "2024-11-01",
      "Invoice Number": "INV1001",
      "Patient": "John Doe",
      "Treatments & Product": "Dental Cleaning, Mouthwash"
    },
    {
      "S.No.": 2,
      "Date": "2024-10-25",
      "Invoice Number": "INV1002",
      "Patient": "Jane Smith",
      "Treatments & Product": "X-Ray, Toothpaste"
    },
    {
      "S.No.": 3,
      "Date": "2024-10-20",
      "Invoice Number": "INV1003",
      "Patient": "Alice Johnson",
      "Treatments & Product": "Whitening, Dental Floss"
    },
    {
      "S.No.": 4,
      "Date": "2024-10-15",
      "Invoice Number": "INV1004",
      "Patient": "Michael Brown",
      "Treatments & Product": "Filling, Toothbrush"
    },
    {
      "S.No.": 5,
      "Date": "2024-10-10",
      "Invoice Number": "INV1005",
      "Patient": "Emily Davis",
      "Treatments & Product": "Braces Check-up, Mouthwash"
    },
    {
      "S.No.": 6,
      "Date": "2024-10-05",
      "Invoice Number": "INV1006",
      "Patient": "Chris Wilson",
      "Treatments & Product": "Cleaning, Floss"
    },
    {
      "S.No.": 7,
      "Date": "2024-10-01",
      "Invoice Number": "INV1007",
      "Patient": "Sarah Miller",
      "Treatments & Product": "Filling, Fluoride"
    },
    {
      "S.No.": 8,
      "Date": "2024-09-25",
      "Invoice Number": "INV1008",
      "Patient": "Tom Anderson",
      "Treatments & Product": "X-Ray, Mouthwash"
    },
    {
      "S.No.": 9,
      "Date": "2024-09-20",
      "Invoice Number": "INV1009",
      "Patient": "Nancy White",
      "Treatments & Product": "Whitening, Toothpaste"
    },
    {
      "S.No.": 10,
      "Date": "2024-09-15",
      "Invoice Number": "INV1010",
      "Patient": "George Harris",
      "Treatments & Product": "Braces, Mouth Guard"
    },
  ];

  List<String> topMedicalCallCenters = [
    "HealthFirst Call Center",
    "MediCare Support Services",
    "CareLine Medical Assistance",
    "LifeCall Emergency Services",
    "24/7 Health Help Line",
    "Prime Medical Call Support",
    "MedConnect Solutions",
    "WellCare Helpline",
    "VitalAssist Contact Center",
    "HealthLink Patient Support"
  ];
}
