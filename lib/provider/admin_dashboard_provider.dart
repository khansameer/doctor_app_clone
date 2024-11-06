import 'package:doctor_app/core/image/image_path.dart';
import 'package:flutter/material.dart';
import '../screen/web_view/admin_dashboard_view/paitent_view/admin_all_list_screen.dart';

class Patient {
  final String name;
  final String description;
  final String? time;
  final String? gender;
  final String? price;
  final String? latestMessage;
  final String? profile;
  final bool? isActive;
  final int? messageCount;

  Patient(
      {required this.name,
      required this.description,
      required this.time,
      this.price,
      this.latestMessage,
      this.profile,
      this.messageCount,
      this.gender,
      this.isActive = true});
}

class AdminDashboardProvider with ChangeNotifier {
  int? _hoveredChat;

  int? get hoveredChat => _hoveredChat;

  void setHoveredChat(int? index) {
    _hoveredChat = index;
    notifyListeners();
  }

  int? _hoveredVideoCall;

  int? get hoveredVideoCall => _hoveredVideoCall;

  void setHoveredVideoCall(int? index) {
    _hoveredVideoCall = index;
    notifyListeners();
  }

  int? _hoveredEdit;

  int? get hoveredEdit => _hoveredEdit;

  void setHoveredEdit(int? index) {
    _hoveredEdit = index;
    notifyListeners();
  }

  int? _hoveredProfile;

  int? get hoveredProfile => _hoveredProfile;

  void setHoveredProfile(int? index) {
    _hoveredProfile = index;
    notifyListeners();
  }


  int _currentIndex = 0;
  int get currentIndex => _currentIndex;

  void nextItem(int itemCount) {
    if (_currentIndex < itemCount - 1) {
      _currentIndex++;
      notifyListeners();
    }
  }

  void previousItem() {
    if (_currentIndex > 0) {
      _currentIndex--;
      notifyListeners();
    }
  }

  void updateIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }

  final List<Patient> _patients = [
    Patient(
      isActive: false,
      price: "19.15",
      messageCount: 0,
      latestMessage: "Great!",
      name: 'Corey Aguilar',
      gender: 'male',
      description: 'Shortness of breath',
      time: '9:30 AM',
      profile: icPatientUser1,
    ),
    Patient(
      price: "35.15",
      name: 'Samantha Lee',
      gender: 'male',
      messageCount: 10,
      description: 'Chest pain',
      time: '10:30 AM',
      profile: icPatientUser2,
    ),
    Patient(
      price: "52.15",
      isActive: false,
      name: 'Michael Smith',
      gender: 'male',
      description: 'Routine check-up',
      time: '11:30 PM',
      messageCount: 12,
      profile: icPatientUser3,
    ),
    Patient(
      price: "96.15",
      name: 'Linda Johnson',
      gender: 'female',
      messageCount: 8,
      description: 'Fatigue',
      time: '01:00 PM',
      profile: icPatientUser4,
    ),
    Patient(
      price: "44.15",
      isActive: false,
      name: 'James Williams',
      gender: 'female',
      messageCount: 11,
      description: 'Swelling',
      time: '2:30 PM',
      profile: icPatientUser5,
    ),
    Patient(
        price: "55.15",
        name: 'Patricia Brown',
        gender: 'female',
        messageCount: 23,
        description: 'Nausea',
        time: '3:00 PM',
        profile: icPatientUser6),
    Patient(
        price: "50.15",
        isActive: false,
        name: 'Robert Jones',
        gender: 'male',
        messageCount: 18,
        description: 'Heartburn',
        time: '4:30 PM',
        profile: icPatientUser7),
    Patient(
        price: "78.15",
        name: 'Jennifer Garcia',
        gender: 'male',
        messageCount: 12,
        description: 'Follow-up visit',
        time: '5:30 PM',
        profile: icPatientUser8),
    Patient(
        price: "90.15",
        isActive: false,
        messageCount: 12,
        name: 'David Martinez',
        gender: 'male',
        description: 'Irregular Hearbeat',
        time: '6:30 PM',
        profile: icPatientUser9),
    Patient(
        price: "25.15",
        name: 'Sarah Robinson',
        messageCount: 1,
        gender: 'male',
        description: 'Follow-up visit',
        time: '7:30 PM',
        profile: icPatientUser10),
    Patient(
        price: "29.90",
        name: 'Thomas Clark',
        messageCount: 5,
        gender: 'male',
        description: 'Follow-up visit',
        time: '8:30 PM',
        profile: icPatientUser11),
  ];

  String? _selectedGender;
  String _searchQuery = "";
  String? _selectedLetter;
  List<Patient> get patients {
    return _patients.where((patient) {
      final matchesLetter =
          _selectedLetter == null || patient.name.startsWith(_selectedLetter!);
      final matchesGender =
          _selectedGender == null || patient.gender == _selectedGender;
      final matchesQuery =
          patient.name.toLowerCase().contains(_searchQuery.toLowerCase());
      return matchesLetter && matchesGender && matchesQuery;
    }).toList();
  }

  Set<String> get availableLetters {
    return _patients.map((patient) => patient.name[0].toUpperCase()).toSet();
  }

  void selectLetter(String? letter) {
    _selectedLetter = letter;
    notifyListeners();
  }

  void filterByGender(String? gender) {
    _selectedGender = gender;
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

  int _selectedIndex = 0;

  int get selectedIndex => _selectedIndex;

  void setTab(int index) {
    _selectedIndex = index;
    notifyListeners();
  }

  Widget _currentPatientPage = const AdminAllListScreen(
    title: "all",
  );
  Widget get currentPatientPage => _currentPatientPage;
  void setPatientDetailsPage(
      {required String value, required BuildContext context}) {
    if (value == "all") {
      _currentPatientPage = const AdminAllListScreen(
        title: "all",
      );

      notifyListeners();
    } else if (value == "female") {
      _currentPatientPage = const AdminAllListScreen(title: "all_female");

      notifyListeners();
    } else if (value == "male") {
      _currentPatientPage = const AdminAllListScreen(title: "all_male");
    } else {
      /*_currentPatientPage = const AdminAllListScreen();*/
    }
    notifyListeners(); // Notify listeners to rebuild
  }

  //doctor note
  List<Map<String, String>> patientDoctorNotes = [
    {
      "noteID": "DN001",
      "patientID": "P001",
      "patientName": "Alice Johnson",
      "date": "2024-10-01",
      "doctorName": "Dr. Emily Smith",
      "note": "Patient advised to increase fluid intake and rest."
    },
    {
      "noteID": "DN002",
      "patientID": "P002",
      "patientName": "James Williams",
      "date": "2024-10-02",
      "doctorName": "Dr. John Doe",
      "note": "Follow-up in two weeks for blood pressure monitoring."
    },
    {
      "noteID": "DN003",
      "patientID": "P003",
      "patientName": "Sophia Brown",
      "date": "2024-10-03",
      "doctorName": "Dr. Sarah Brown",
      "note": "Patient experiencing mild side effects from medication."
    },
    {
      "noteID": "DN004",
      "patientID": "P004",
      "patientName": "Liam Jones",
      "date": "2024-10-04",
      "doctorName": "Dr. William Green",
      "note": "Advised to reduce salt intake and increase exercise."
    },
    {
      "noteID": "DN005",
      "patientID": "P005",
      "patientName": "Olivia Garcia",
      "date": "2024-10-05",
      "doctorName": "Dr. Angela White",
      "note": "Symptoms improving; continue with current treatment."
    },
    {
      "noteID": "DN006",
      "patientID": "P006",
      "patientName": "Mason Miller",
      "date": "2024-10-06",
      "doctorName": "Dr. Michael Lee",
      "note": "Referred to a specialist for further evaluation."
    },
    {
      "noteID": "DN007",
      "patientID": "P007",
      "patientName": "Emma Martinez",
      "date": "2024-10-07",
      "doctorName": "Dr. Jennifer Adams",
      "note": "Prescribed new medication for pain management."
    },
    {
      "noteID": "DN008",
      "patientID": "P008",
      "patientName": "Noah Rodriguez",
      "date": "2024-10-08",
      "doctorName": "Dr. David Clark",
      "note": "Scheduled an X-ray to check for fractures."
    },
    {
      "noteID": "DN009",
      "patientID": "P009",
      "patientName": "Isabella Hernandez",
      "date": "2024-10-09",
      "doctorName": "Dr. Karen Lewis",
      "note": "Recommended physical therapy twice a week."
    },
    {
      "noteID": "DN010",
      "patientID": "P010",
      "patientName": "Ethan Lee",
      "date": "2024-10-10",
      "doctorName": "Dr. George Walker",
      "note": "Ordered lab tests to check cholesterol levels."
    },
    {
      "noteID": "DN011",
      "patientID": "P011",
      "patientName": "Ava Young",
      "date": "2024-10-11",
      "doctorName": "Dr. Mary Hall",
      "note": "Patient to monitor blood sugar levels daily."
    },
    {
      "noteID": "DN012",
      "patientID": "P012",
      "patientName": "Lucas Allen",
      "date": "2024-10-12",
      "doctorName": "Dr. Richard King",
      "note": "Scheduled follow-up for possible allergy testing."
    },
    {
      "noteID": "DN013",
      "patientID": "P013",
      "patientName": "Mia Scott",
      "date": "2024-10-13",
      "doctorName": "Dr. Barbara Wright",
      "note": "Advised on breathing exercises for stress relief."
    },
    {
      "noteID": "DN014",
      "patientID": "P014",
      "patientName": "Jacob Torres",
      "date": "2024-10-14",
      "doctorName": "Dr. Joseph Lopez",
      "note": "Recommended daily walks for improved circulation."
    },
    {
      "noteID": "DN015",
      "patientID": "P015",
      "patientName": "Amelia Nelson",
      "date": "2024-10-15",
      "doctorName": "Dr. Charles Hill",
      "note": "Discussed dietary changes for weight management."
    },
    {
      "noteID": "DN016",
      "patientID": "P016",
      "patientName": "Michael Perez",
      "date": "2024-10-16",
      "doctorName": "Dr. Matthew Baker",
      "note": "Prescribed antibiotics for bacterial infection."
    },
    {
      "noteID": "DN017",
      "patientID": "P017",
      "patientName": "Charlotte Rivera",
      "date": "2024-10-17",
      "doctorName": "Dr. Laura Cooper",
      "note": "Patient to increase daily water intake."
    },
    {
      "noteID": "DN018",
      "patientID": "P018",
      "patientName": "Henry Carter",
      "date": "2024-10-18",
      "doctorName": "Dr. Lisa Ramirez",
      "note": "Follow-up scheduled to monitor recovery."
    },
    {
      "noteID": "DN019",
      "patientID": "P019",
      "patientName": "Ella Howard",
      "date": "2024-10-19",
      "doctorName": "Dr. Brian Peterson",
      "note": "Suggested stress-reduction techniques."
    },
    {
      "noteID": "DN020",
      "patientID": "P020",
      "patientName": "Alexander Evans",
      "date": "2024-10-20",
      "doctorName": "Dr. Megan Collins",
      "note": "Patient recovering well; follow-up in one month."
    },
  ];
  List<Map<String, dynamic>> demographicsDetails = [
    {
      "patientID": "P001",
      "name": "Alice Johnson",
      "age": 34,
      "gender": "Female",
      "address": "123 Main St, Springfield",
      "contactNumber": "+1-234-567-8901",
      "email": "alice.johnson@example.com",
      "maritalStatus": "Married",
      "ethnicity": "Caucasian",
      "language": "English",
    },
    {
      "patientID": "P002",
      "name": "James Williams",
      "age": 45,
      "gender": "Male",
      "address": "456 Oak St, Springfield",
      "contactNumber": "+1-234-567-8902",
      "email": "james.williams@example.com",
      "maritalStatus": "Single",
      "ethnicity": "African American",
      "language": "English",
    },
    {
      "patientID": "P003",
      "name": "Sophia Brown",
      "age": 29,
      "gender": "Female",
      "address": "789 Pine St, Springfield",
      "contactNumber": "+1-234-567-8903",
      "email": "sophia.brown@example.com",
      "maritalStatus": "Single",
      "ethnicity": "Hispanic",
      "language": "Spanish",
    },
    {
      "patientID": "P004",
      "name": "Liam Jones",
      "age": 50,
      "gender": "Male",
      "address": "101 Maple St, Springfield",
      "contactNumber": "+1-234-567-8904",
      "email": "liam.jones@example.com",
      "maritalStatus": "Married",
      "ethnicity": "Caucasian",
      "language": "English",
    },
    {
      "patientID": "P005",
      "name": "Olivia Garcia",
      "age": 27,
      "gender": "Female",
      "address": "202 Birch St, Springfield",
      "contactNumber": "+1-234-567-8905",
      "email": "olivia.garcia@example.com",
      "maritalStatus": "Single",
      "ethnicity": "Hispanic",
      "language": "Spanish",
    },
    {
      "patientID": "P006",
      "name": "Mason Miller",
      "age": 60,
      "gender": "Male",
      "address": "303 Cedar St, Springfield",
      "contactNumber": "+1-234-567-8906",
      "email": "mason.miller@example.com",
      "maritalStatus": "Married",
      "ethnicity": "Asian",
      "language": "Mandarin",
    },
    {
      "patientID": "P007",
      "name": "Emma Martinez",
      "age": 31,
      "gender": "Female",
      "address": "404 Elm St, Springfield",
      "contactNumber": "+1-234-567-8907",
      "email": "emma.martinez@example.com",
      "maritalStatus": "Single",
      "ethnicity": "Hispanic",
      "language": "Spanish",
    },
    {
      "patientID": "P008",
      "name": "Noah Rodriguez",
      "age": 22,
      "gender": "Male",
      "address": "505 Cherry St, Springfield",
      "contactNumber": "+1-234-567-8908",
      "email": "noah.rodriguez@example.com",
      "maritalStatus": "Single",
      "ethnicity": "Latino",
      "language": "English",
    },
    {
      "patientID": "P009",
      "name": "Isabella Hernandez",
      "age": 36,
      "gender": "Female",
      "address": "606 Poplar St, Springfield",
      "contactNumber": "+1-234-567-8909",
      "email": "isabella.hernandez@example.com",
      "maritalStatus": "Married",
      "ethnicity": "Latino",
      "language": "English",
    },
    {
      "patientID": "P010",
      "name": "Ethan Lee",
      "age": 41,
      "gender": "Male",
      "address": "707 Willow St, Springfield",
      "contactNumber": "+1-234-567-8910",
      "email": "ethan.lee@example.com",
      "maritalStatus": "Married",
      "ethnicity": "Asian",
      "language": "Korean",
    },
    {
      "patientID": "P011",
      "name": "Ava Young",
      "age": 24,
      "gender": "Female",
      "address": "808 Walnut St, Springfield",
      "contactNumber": "+1-234-567-8911",
      "email": "ava.young@example.com",
      "maritalStatus": "Single",
      "ethnicity": "Caucasian",
      "language": "English",
    },
    {
      "patientID": "P012",
      "name": "Lucas Allen",
      "age": 54,
      "gender": "Male",
      "address": "909 Beech St, Springfield",
      "contactNumber": "+1-234-567-8912",
      "email": "lucas.allen@example.com",
      "maritalStatus": "Married",
      "ethnicity": "African American",
      "language": "English",
    },
    {
      "patientID": "P013",
      "name": "Mia Scott",
      "age": 48,
      "gender": "Female",
      "address": "1010 Linden St, Springfield",
      "contactNumber": "+1-234-567-8913",
      "email": "mia.scott@example.com",
      "maritalStatus": "Divorced",
      "ethnicity": "Caucasian",
      "language": "English",
    },
    {
      "patientID": "P014",
      "name": "Jacob Torres",
      "age": 38,
      "gender": "Male",
      "address": "1111 Spruce St, Springfield",
      "contactNumber": "+1-234-567-8914",
      "email": "jacob.torres@example.com",
      "maritalStatus": "Married",
      "ethnicity": "Hispanic",
      "language": "Spanish",
    },
    {
      "patientID": "P015",
      "name": "Amelia Nelson",
      "age": 32,
      "gender": "Female",
      "address": "1212 Maple St, Springfield",
      "contactNumber": "+1-234-567-8915",
      "email": "amelia.nelson@example.com",
      "maritalStatus": "Single",
      "ethnicity": "Caucasian",
      "language": "English",
    },
    {
      "patientID": "P016",
      "name": "Michael Perez",
      "age": 67,
      "gender": "Male",
      "address": "1313 Oak St, Springfield",
      "contactNumber": "+1-234-567-8916",
      "email": "michael.perez@example.com",
      "maritalStatus": "Widowed",
      "ethnicity": "Latino",
      "language": "Spanish",
    },
    {
      "patientID": "P017",
      "name": "Charlotte Rivera",
      "age": 26,
      "gender": "Female",
      "address": "1414 Cedar St, Springfield",
      "contactNumber": "+1-234-567-8917",
      "email": "charlotte.rivera@example.com",
      "maritalStatus": "Single",
      "ethnicity": "Latino",
      "language": "English",
    },
    {
      "patientID": "P018",
      "name": "Henry Carter",
      "age": 53,
      "gender": "Male",
      "address": "1515 Elm St, Springfield",
      "contactNumber": "+1-234-567-8918",
      "email": "henry.carter@example.com",
      "maritalStatus": "Married",
      "ethnicity": "African American",
      "language": "English",
    },
    {
      "patientID": "P019",
      "name": "Ella Howard",
      "age": 44,
      "gender": "Female",
      "address": "1616 Pine St, Springfield",
      "contactNumber": "+1-234-567-8919",
      "email": "ella.howard@example.com",
      "maritalStatus": "Married",
      "ethnicity": "Caucasian",
      "language": "English",
    },
    {
      "patientID": "P020",
      "name": "Alexander Evans",
      "age": 37,
      "gender": "Male",
      "address": "1717 Birch St, Springfield",
      "contactNumber": "+1-234-567-8920",
      "email": "alexander.evans@example.com",
      "maritalStatus": "Single",
      "ethnicity": "Caucasian",
      "language": "English",
    },
  ];
  List<Map<String, dynamic>> patientReports = [
    {
      "reportID": "R001",
      "patientID": "P001",
      "patientName": "Alice Johnson",
      "date": "2024-10-01",
      "reportType": "Blood Test",
      "doctorName": "Dr. Emily Smith",
      "summary": "Normal hemoglobin and cholesterol levels."
    },
    {
      "reportID": "R002",
      "patientID": "P002",
      "patientName": "James Williams",
      "date": "2024-10-03",
      "reportType": "X-Ray",
      "doctorName": "Dr. John Doe",
      "summary": "No fractures detected in the chest X-ray."
    },
    {
      "reportID": "R003",
      "patientID": "P003",
      "patientName": "Sophia Brown",
      "date": "2024-10-05",
      "reportType": "MRI",
      "doctorName": "Dr. Sarah Brown",
      "summary": "Mild inflammation in the knee joint."
    },
    {
      "reportID": "R004",
      "patientID": "P004",
      "patientName": "Liam Jones",
      "date": "2024-10-07",
      "reportType": "CT Scan",
      "doctorName": "Dr. William Green",
      "summary": "No abnormalities in the abdominal region."
    },
    {
      "reportID": "R005",
      "patientID": "P005",
      "patientName": "Olivia Garcia",
      "date": "2024-10-09",
      "reportType": "Urine Test",
      "doctorName": "Dr. Angela White",
      "summary": "No signs of infection; all levels are normal."
    },
    {
      "reportID": "R006",
      "patientID": "P006",
      "patientName": "Mason Miller",
      "date": "2024-10-11",
      "reportType": "Blood Pressure Check",
      "doctorName": "Dr. Michael Lee",
      "summary": "Blood pressure slightly elevated; recommend follow-up."
    },
    {
      "reportID": "R007",
      "patientID": "P007",
      "patientName": "Emma Martinez",
      "date": "2024-10-13",
      "reportType": "Electrocardiogram (ECG)",
      "doctorName": "Dr. Jennifer Adams",
      "summary": "ECG shows regular heart rhythm."
    },
    {
      "reportID": "R008",
      "patientID": "P008",
      "patientName": "Noah Rodriguez",
      "date": "2024-10-15",
      "reportType": "Lipid Profile",
      "doctorName": "Dr. David Clark",
      "summary": "High LDL levels; advised dietary changes."
    },
    {
      "reportID": "R009",
      "patientID": "P009",
      "patientName": "Isabella Hernandez",
      "date": "2024-10-17",
      "reportType": "Allergy Test",
      "doctorName": "Dr. Karen Lewis",
      "summary": "Positive reaction to pollen and dust mites."
    },
    {
      "reportID": "R010",
      "patientID": "P010",
      "patientName": "Ethan Lee",
      "date": "2024-10-19",
      "reportType": "Vision Test",
      "doctorName": "Dr. George Walker",
      "summary": "20/20 vision; no corrective lenses needed."
    },
  ];
  List<Map<String, dynamic>> appointmentDetails = [
    {
      "appointmentID": "A001",
      "patientID": "P001",
      "patientName": "Alice Johnson",
      "date": "2024-10-30",
      "time": "10:00 AM",
      "doctorName": "Dr. Emily Smith",
      "reason": "Routine Check-up",
      "status": "Scheduled"
    },
    {
      "appointmentID": "A002",
      "patientID": "P002",
      "patientName": "James Williams",
      "date": "2024-10-30",
      "time": "11:30 AM",
      "doctorName": "Dr. John Doe",
      "reason": "Back Pain Consultation",
      "status": "Scheduled"
    },
    {
      "appointmentID": "A003",
      "patientID": "P003",
      "patientName": "Sophia Brown",
      "date": "2024-10-30",
      "time": "01:00 PM",
      "doctorName": "Dr. Sarah Brown",
      "reason": "Physical Therapy",
      "status": "Completed"
    },
    {
      "appointmentID": "A004",
      "patientID": "P004",
      "patientName": "Liam Jones",
      "date": "2024-10-31",
      "time": "09:30 AM",
      "doctorName": "Dr. William Green",
      "reason": "Diabetes Follow-up",
      "status": "Scheduled"
    },
    {
      "appointmentID": "A005",
      "patientID": "P005",
      "patientName": "Olivia Garcia",
      "date": "2024-10-31",
      "time": "10:45 AM",
      "doctorName": "Dr. Angela White",
      "reason": "Allergy Consultation",
      "status": "Rescheduled"
    },
    {
      "appointmentID": "A006",
      "patientID": "P006",
      "patientName": "Mason Miller",
      "date": "2024-11-01",
      "time": "02:00 PM",
      "doctorName": "Dr. Michael Lee",
      "reason": "Blood Pressure Check",
      "status": "Completed"
    },
    {
      "appointmentID": "A007",
      "patientID": "P007",
      "patientName": "Emma Martinez",
      "date": "2024-11-01",
      "time": "03:30 PM",
      "doctorName": "Dr. Jennifer Adams",
      "reason": "Dermatology Consultation",
      "status": "Cancelled"
    },
    {
      "appointmentID": "A008",
      "patientID": "P008",
      "patientName": "Noah Rodriguez",
      "date": "2024-11-02",
      "time": "08:00 AM",
      "doctorName": "Dr. David Clark",
      "reason": "Cardiology Check-up",
      "status": "Scheduled"
    },
    {
      "appointmentID": "A009",
      "patientID": "P009",
      "patientName": "Isabella Hernandez",
      "date": "2024-11-02",
      "time": "10:15 AM",
      "doctorName": "Dr. Karen Lewis",
      "reason": "Vision Test",
      "status": "Scheduled"
    },
    {
      "appointmentID": "A010",
      "patientID": "P010",
      "patientName": "Ethan Lee",
      "date": "2024-11-02",
      "time": "12:30 PM",
      "doctorName": "Dr. George Walker",
      "reason": "General Consultation",
      "status": "Completed"
    },
  ];
  List<Map<String, dynamic>> followUpDetails = [
    {
      "patientID": "P001",
      "patientName": "Alice Johnson",
      "lastAppointmentDate": "2024-10-15",
      "nextFollowUpDate": "2024-11-15",
      "doctorName": "Dr. Emily Smith",
      "reason": "Routine Check-up Follow-up"
    },
    {
      "patientID": "P002",
      "patientName": "James Williams",
      "lastAppointmentDate": "2024-10-10",
      "nextFollowUpDate": "2024-11-10",
      "doctorName": "Dr. John Doe",
      "reason": "Back Pain Progress Review"
    },
    {
      "patientID": "P003",
      "patientName": "Sophia Brown",
      "lastAppointmentDate": "2024-10-20",
      "nextFollowUpDate": "2024-11-20",
      "doctorName": "Dr. Sarah Brown",
      "reason": "Knee Therapy Follow-up"
    },
    {
      "patientID": "P004",
      "patientName": "Liam Jones",
      "lastAppointmentDate": "2024-10-22",
      "nextFollowUpDate": "2024-11-22",
      "doctorName": "Dr. William Green",
      "reason": "Diabetes Management Follow-up"
    },
    {
      "patientID": "P005",
      "patientName": "Olivia Garcia",
      "lastAppointmentDate": "2024-10-18",
      "nextFollowUpDate": "2024-11-18",
      "doctorName": "Dr. Angela White",
      "reason": "Allergy Treatment Review"
    },
  ];
  List<Map<String, dynamic>> billingInfo = [
    {
      "billID": "B001",
      "patientID": "P001",
      "patientName": "Alice Johnson",
      "appointmentDate": "2024-10-15",
      "amountDue": 150.00,
      "amountPaid": 150.00,
      "paymentStatus": "Paid",
      "billingDate": "2024-10-16",
      "paymentMethod": "Credit Card"
    },
    {
      "billID": "B002",
      "patientID": "P002",
      "patientName": "James Williams",
      "appointmentDate": "2024-10-10",
      "amountDue": 200.00,
      "amountPaid": 100.00,
      "paymentStatus": "Partial Payment",
      "billingDate": "2024-10-11",
      "paymentMethod": "Cash"
    },
    {
      "billID": "B003",
      "patientID": "P003",
      "patientName": "Sophia Brown",
      "appointmentDate": "2024-10-20",
      "amountDue": 300.00,
      "amountPaid": 300.00,
      "paymentStatus": "Paid",
      "billingDate": "2024-10-21",
      "paymentMethod": "Insurance"
    },
    {
      "billID": "B004",
      "patientID": "P004",
      "patientName": "Liam Jones",
      "appointmentDate": "2024-10-22",
      "amountDue": 250.00,
      "amountPaid": 0.00,
      "paymentStatus": "Unpaid",
      "billingDate": "2024-10-23",
      "paymentMethod": "Credit Card"
    },
    {
      "billID": "B005",
      "patientID": "P005",
      "patientName": "Olivia Garcia",
      "appointmentDate": "2024-10-18",
      "amountDue": 175.00,
      "amountPaid": 175.00,
      "paymentStatus": "Paid",
      "billingDate": "2024-10-19",
      "paymentMethod": "Debit Card"
    },
  ];

  // for chat

  int _selectedUserIndex = 0;

  int get selectedUserIndex => _selectedUserIndex;

  void selectUser(int index) {
    _selectedUserIndex = index;
    notifyListeners();
  }

  Patient? _chatUserInfo;
  Patient? get chatUserInfo => _chatUserInfo;

  void chatUserInfoValue(Patient data) {
    _chatUserInfo = data;
    notifyListeners();
  }

  List<ChatMessage> chatMessages = [
    ChatMessage(
        sender: "Alice",
        message: "Hey, how are you?",
        date: "2024-10-01 09:00",
        sentByUser: false),
    ChatMessage(
        sender: "User",
        message: "I'm good, thanks! How about you?",
        date: "2024-10-01 09:01",
        sentByUser: true),
    ChatMessage(
        sender: "Alice",
        message: "Doing well! Been busy with work.",
        date: "2024-10-01 09:02",
        sentByUser: false),
    ChatMessage(
        sender: "Bob",
        message: "Let's meet tomorrow?",
        date: "2024-10-01 10:15",
        sentByUser: false),
    ChatMessage(
        sender: "User",
        message: "Sure, what time?",
        date: "2024-10-01 10:16",
        sentByUser: true),
    ChatMessage(
        sender: "Bob",
        message: "How about 3 PM?",
        date: "2024-10-01 10:17",
        sentByUser: false),
    ChatMessage(
        sender: "Charlie",
        message: "Can you send the file?",
        date: "2024-10-02 11:20",
        sentByUser: false),
    ChatMessage(
        sender: "User",
        message: "Just sent it over!",
        date: "2024-10-02 11:21",
        sentByUser: true),
    ChatMessage(
        sender: "Charlie",
        message: "Got it, thanks!",
        date: "2024-10-02 11:22",
        sentByUser: false),
    ChatMessage(
        sender: "Diana",
        message: "Thank you!",
        date: "2024-10-03 08:45",
        sentByUser: false),
    ChatMessage(
        sender: "User",
        message: "Anytime!",
        date: "2024-10-03 08:46",
        sentByUser: true),
    ChatMessage(
        sender: "Edward",
        message: "I'll check on that.",
        date: "2024-10-03 09:30",
        sentByUser: false),
    ChatMessage(
        sender: "User",
        message: "Sounds good.",
        date: "2024-10-03 09:31",
        sentByUser: true),
    ChatMessage(
        sender: "Fiona",
        message: "See you later!",
        date: "2024-10-03 15:20",
        sentByUser: false),
    ChatMessage(
        sender: "User",
        message: "Take care!",
        date: "2024-10-03 15:21",
        sentByUser: true),
    ChatMessage(
        sender: "George",
        message: "Can we reschedule?",
        date: "2024-10-04 12:05",
        sentByUser: false),
    ChatMessage(
        sender: "User",
        message: "Let me check my schedule.",
        date: "2024-10-04 12:06",
        sentByUser: true),
    ChatMessage(
        sender: "George",
        message: "Thanks!",
        date: "2024-10-04 12:07",
        sentByUser: false),
    ChatMessage(
        sender: "Hannah",
        message: "Happy birthday!",
        date: "2024-10-05 08:00",
        sentByUser: false),
    ChatMessage(
        sender: "User",
        message: "Thank you so much!",
        date: "2024-10-05 08:01",
        sentByUser: true),
    ChatMessage(
        sender: "Isaac",
        message: "I'll be there in 10 mins.",
        date: "2024-10-05 13:00",
        sentByUser: false),
    ChatMessage(
        sender: "User",
        message: "Great, see you soon.",
        date: "2024-10-05 13:01",
        sentByUser: true),
    ChatMessage(
        sender: "Julia",
        message: "Got it, thanks!",
        date: "2024-10-06 09:30",
        sentByUser: false),
    ChatMessage(
        sender: "User",
        message: "You're welcome!",
        date: "2024-10-06 09:31",
        sentByUser: true),
    ChatMessage(
        sender: "Alice",
        message: "Did you finish the report?",
        date: "2024-10-06 10:00",
        sentByUser: false),
    ChatMessage(
        sender: "User",
        message: "Almost done.",
        date: "2024-10-06 10:01",
        sentByUser: true),
    ChatMessage(
        sender: "Bob",
        message: "See you at 3 PM?",
        date: "2024-10-07 14:45",
        sentByUser: false),
    ChatMessage(
        sender: "User",
        message: "Yes, on my way.",
        date: "2024-10-07 14:46",
        sentByUser: true),
    ChatMessage(
        sender: "Charlie",
        message: "Thanks for the help.",
        date: "2024-10-08 11:30",
        sentByUser: false),
    ChatMessage(
        sender: "User",
        message: "Happy to help!",
        date: "2024-10-08 11:31",
        sentByUser: true),
    ChatMessage(
        sender: "Diana",
        message: "Can you check this for me?",
        date: "2024-10-08 12:15",
        sentByUser: false),
    ChatMessage(
        sender: "User",
        message: "Sure, give me a minute.",
        date: "2024-10-08 12:16",
        sentByUser: true),
    ChatMessage(
        sender: "Edward",
        message: "See you at the meeting.",
        date: "2024-10-09 09:15",
        sentByUser: false),
    ChatMessage(
        sender: "User",
        message: "I'll be there!",
        date: "2024-10-09 09:16",
        sentByUser: true),
    ChatMessage(
        sender: "Fiona",
        message: "Thanks again!",
        date: "2024-10-09 16:30",
        sentByUser: false),
    ChatMessage(
        sender: "User",
        message: "You're welcome!",
        date: "2024-10-09 16:31",
        sentByUser: true),
    ChatMessage(
        sender: "George",
        message: "Is there an update?",
        date: "2024-10-10 11:00",
        sentByUser: false),
    ChatMessage(
        sender: "User",
        message: "I'll send it shortly.",
        date: "2024-10-10 11:01",
        sentByUser: true),
    ChatMessage(
        sender: "Hannah",
        message: "Congratulations!",
        date: "2024-10-10 12:00",
        sentByUser: false),
    ChatMessage(
        sender: "User",
        message: "Thank you!",
        date: "2024-10-10 12:01",
        sentByUser: true),
    ChatMessage(
        sender: "Isaac",
        message: "Let's catch up soon.",
        date: "2024-10-11 10:30",
        sentByUser: false),
    ChatMessage(
        sender: "User",
        message: "Absolutely!",
        date: "2024-10-11 10:31",
        sentByUser: true),
    ChatMessage(
        sender: "Julia",
        message: "Do you need help with that?",
        date: "2024-10-11 15:00",
        sentByUser: false),
    ChatMessage(
        sender: "User",
        message: "I think I got it, thanks!",
        date: "2024-10-11 15:01",
        sentByUser: true),
    ChatMessage(
        sender: "Alice",
        message: "Let's touch base next week.",
        date: "2024-10-12 11:00",
        sentByUser: false),
    ChatMessage(
        sender: "User",
        message: "Works for me.",
        date: "2024-10-12 11:01",
        sentByUser: true),
    ChatMessage(
        sender: "Bob",
        message: "Lunch on Friday?",
        date: "2024-10-12 14:30",
        sentByUser: false),
    ChatMessage(
        sender: "User",
        message: "Yes, looking forward to it.",
        date: "2024-10-12 14:31",
        sentByUser: true),
    ChatMessage(
        sender: "Charlie",
        message: "Got the documents.",
        date: "2024-10-13 09:45",
        sentByUser: false),
    ChatMessage(
        sender: "User",
        message: "Great!",
        date: "2024-10-13 09:46",
        sentByUser: true),
  ];

  bool _isHovered = false;

  bool get isHovered => _isHovered;

  void setHover(bool value) {
    _isHovered = value;
    notifyListeners();
  }
}

class ChatUser {
  final String name;
  final String latestMessage;
  final String? profile;
  final int messageCount;

  ChatUser(
      {required this.name,
      this.profile,
      required this.latestMessage,
      required this.messageCount});
}

class ChatMessage {
  final String sender;
  final String message;
  final String date;
  final bool sentByUser;

  ChatMessage({
    required this.sender,
    required this.message,
    required this.date,
    required this.sentByUser,
  });
}
