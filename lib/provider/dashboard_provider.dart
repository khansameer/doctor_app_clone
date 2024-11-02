import 'package:doctor_app/core/common/error_page.dart';
import 'package:doctor_app/core/component/component.dart';
import 'package:doctor_app/core/image/image_path.dart';
import 'package:doctor_app/main.dart';

import 'package:doctor_app/provider/model/dummy_model.dart';
import 'package:doctor_app/screen/mobile_view/calender/calender_screen.dart';
import 'package:doctor_app/screen/mobile_view/chat_screen/chat_screen.dart';
import 'package:doctor_app/screen/mobile_view/chat_screen/patient_list_screen.dart';
import 'package:doctor_app/screen/mobile_view/consult/consult_screen.dart';
import 'package:doctor_app/screen/mobile_view/dashboard_model.dart';
import 'package:doctor_app/screen/mobile_view/health_feed/health_feed_screen.dart';
import 'package:doctor_app/screen/mobile_view/home/home_screen.dart';
import 'package:doctor_app/screen/mobile_view/paitent_screen/patients_screen.dart';
import 'package:doctor_app/screen/mobile_view/patient_stories/patient_stories_screen.dart';
import 'package:doctor_app/screen/mobile_view/prime/prime_screen.dart';
import 'package:doctor_app/screen/mobile_view/profile/edit_profile_screen.dart';
import 'package:doctor_app/screen/mobile_view/profile/profile_screen.dart';
import 'package:doctor_app/screen/mobile_view/reach/reach_screen.dart';
import 'package:doctor_app/screen/mobile_view/report/report_screen.dart';
import 'package:doctor_app/screen/mobile_view/weekly_earning/weekly_earning_screen.dart';
import 'package:doctor_app/screen/web_view/screen/calender/admin_calender_screen.dart';
import 'package:doctor_app/screen/web_view/screen/patient_profile_page.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screen/web_view/screen/procedure/procedure_screen.dart';

class DashboardProvider extends ChangeNotifier {
  final bool _isLoading = false;
  bool get isLoading => _isLoading;
  Widget? _dashboardPage;
  Widget? get dashboardPage => _dashboardPage;
  int _selectedIndex = 0;
  set updateDashboardPage(Widget? value) {
    _dashboardPage = value;
    notifyListeners();
  }

  clearPage() {
    _dashboardPage = null;
    notifyListeners();
  }

  int? _hoveredIndex;

  int? get hoveredIndex => _hoveredIndex;

  void setHoveredIndex(int? index) {
    _hoveredIndex = index;
    notifyListeners();
  }

  String? _name;

  String? get name => _name;

  String? _email;

  String? get email => _email;
  void setIndex(int index) {
    _selectedIndex = index;
    notifyListeners();
  }

  String? selectedUser;

  void viewUser(String userId) {
    selectedUser = userId;
    notifyListeners();
  }

  void goBackToList() {
    selectedUser = null;
    notifyListeners();
  }

  getUserName() async {
    _name = await getName();
    notifyListeners();
  }

  getEmail() async {
    _email = await getDoctorEmail();
    notifyListeners();
  }

  final Widget _currentPage = const AdminCalenderScreen(); // Default page

  final Widget _currentPageProfile = const PatientProfilePage(); // Default page

  Widget get currentPageProfile => _currentPageProfile;

  String _getClickPageValue = "all";
  String? get getClickPageValue => _getClickPageValue;

  set settClickPageValue(String value) {
    _getClickPageValue = value;
    notifyListeners();
  }

  Widget _currentPatientPage = const PatientProfilePage(
    title: "all",
  ); // Default page
  Widget get currentPatientPage => _currentPatientPage;

  //for patient new screen  for redirect screen
  void setPatientDetailsPage(
      {required String value, required BuildContext context}) {
    if (kDebugMode) {
      print('==value====$value');
    }
    if (value == "All Patients") {
      _currentPatientPage = const PatientProfilePage(
        title: "all",
      );

      settClickPageValue = "all";
      notifyListeners();
    } else if (value == "Recently Visited") {
      _currentPatientPage = const PatientProfilePage(
        title: "all",
      );
      notifyListeners();
    } else if (value == "All Female Customer") {
      _currentPatientPage = const PatientProfilePage(title: "all_female");

      settClickPageValue = "all_female";
      notifyListeners();
    } else if (value == "All Male Customer") {
      _currentPatientPage = const PatientProfilePage(title: "all_male");
      settClickPageValue = "all_male";
    } else if (value == "Female Customer under 30") {
      _currentPatientPage = const PatientProfilePage(title: "female_under30");

      settClickPageValue = "female_under30";
    } else if (value == "Female Customer Over 30") {
      _currentPatientPage = const PatientProfilePage(title: "female_over30");
      settClickPageValue = "female_over30";
    } else {
      _currentPatientPage = const ErrorPage();
    }
    notifyListeners(); // Notify listeners to rebuild
  }

  //for admin setting page
  Widget _currentAdminSettingPage = const ProcedureScreen(); // Default page
  Widget get currentAdminSettingPage => _currentAdminSettingPage;

  set setAdminSettingPagePage(String value) {
    if (value == "Procedure Catalog") {
      _currentAdminSettingPage = const ProcedureScreen();
    } else if (value == "Clinic Address") {
      _currentAdminSettingPage = const ErrorPage();
    } else {
      _currentAdminSettingPage = const ErrorPage();
    }
    notifyListeners(); // Notify listeners to rebuild
  }

  //for admin dashboard screen
  String? _pageApp = "Home";
  String? get page => _pageApp;
  Widget _currentAppPage = HomeScreen(onSelectedPage: (value) {
    final dashboardProvider = Provider.of<DashboardProvider>(
        navigatorKey.currentState!.context,
        listen: false);
    dashboardProvider.updateAppPage = value;
  });

  Widget? get currentAppPage => _currentAppPage;
  set updateAppPage(String value) {
    _pageApp = value;
    if (_pageApp == "Profile") {
      _currentAppPage = const ProfileScreen();
      notifyListeners();
    }
    if (_pageApp == "Home") {
      _currentAppPage = HomeScreen(onSelectedPage: (value) {
        final dashboardProvider = Provider.of<DashboardProvider>(
            navigatorKey.currentState!.context,
            listen: false);
        dashboardProvider.updateAppPage = value;
      });
    }
    if (_pageApp == "Reach") {
      _currentAppPage = const ReachScreen();
      notifyListeners();
    }
    if (_pageApp == "Chat") {
      _currentAppPage = const ChatScreen();
      notifyListeners();
    }

    if (_pageApp == "Patient Stories") {
      _currentAppPage = const PatientStoriesScreen();
    }
    if (_pageApp == "Consult") {
      _currentAppPage = const ConsultScreen();
    }
    if (_pageApp == "Healthfeed") {
      _currentAppPage = const HealthFeedScreen();
    }
    if (_pageApp == "Prime") {
      _currentAppPage = const PrimeScreen();
    }

    if (_pageApp == "Report") {
      _currentAppPage = const ReportScreen();
    }
    if (_pageApp == "Earning") {
      _currentAppPage = const WeeklyEarningScreen();
    }
    if (_pageApp == "Calendar") {
      _currentAppPage = const CalenderScreen();
    }
    if (_pageApp == "Patient") {
      _currentAppPage = const PatientsScreen();
    }
    if (_pageApp == "edit_profile") {
      _currentAppPage = const EditProfileScreen();
    }
    if (_pageApp == "chat_user_list") {
      _currentAppPage = const PatientListScreen();
    }
    if (_pageApp == "chat_screen") {
      _currentAppPage = const ChatScreen();
    }
    if (_pageApp == "Profile") {
      _currentAppPage = const EditProfileScreen();
    }

    notifyListeners();
  }

  String? _appBarTitle = "Home";

  int get selectedIndex => _selectedIndex;

  String? get appBarTitle => _appBarTitle;

  Widget get currentPage => _currentPage;

  void setSelectedIndex(int index) {
    _selectedIndex = index;

    notifyListeners();
  }

  void setAppBarTitle(String? value) {
    _appBarTitle = value;
    notifyListeners();
  }

  List<DummyModel> get itemNotification => _itemNotification;
  final List<DummyModel> _itemNotification = [
    DummyModel(date: "Saturday, 5 October 2024", items: [
      SubItem(
          content:
              "A 18 years old Male from Kolkata has asked a question about Eye check up",
          days: "8 days Ago"),
      SubItem(content: "You have 3 consult questions assigned to you"),
    ]),
    DummyModel(date: "Saturday, 5 October 2024", items: [
      SubItem(
          content:
              "A 18 years old Male from Kolkata has asked a question about Eye check up",
          days: "8 days Ago"),
      SubItem(content: "You have 3 consult questions assigned to you"),
    ]),
    DummyModel(date: "Saturday, 5 October 2024", items: [
      SubItem(
          content:
              "A 18 years old Male from Kolkata has asked a question about Eye check up",
          days: "8 days Ago"),
      SubItem(content: "You have 3 consult questions assigned to you"),
    ]),
    DummyModel(date: "Saturday, 5 October 2024", items: [
      SubItem(
          content:
              "A 18 years old Male from Kolkata has asked a question about Eye check up",
          days: "8 days Ago"),
      SubItem(content: "You have 3 consult questions assigned to you"),
    ]),
    DummyModel(date: "Saturday, 5 October 2024", items: [
      SubItem(
          content:
              "A 18 years old Male from Kolkata has asked a question about Eye check up",
          days: "8 days Ago"),
      SubItem(content: "You have 3 consult questions assigned to you"),
    ]),
    DummyModel(date: "Saturday, 5 October 2024", items: [
      SubItem(
          content:
              "A 18 years old Male from Kolkata has asked a question about Eye check up",
          days: "8 days Ago"),
      SubItem(content: "You have 3 consult questions assigned to you"),
    ]),
  ];

  //Setting page switch

  bool _isOn = false;

  bool get isOn => _isOn;

  void toggleSwitch() {
    _isOn = !_isOn;
    notifyListeners();
  }

  //load App List

  final List<DummyModel> _appList = [
    DummyModel(date: "Profile", icon: icMenuProfile, items: []),
    DummyModel(date: "Reach", icon: icMenuReach, items: []),
    DummyModel(date: "Patient Stories", icon: icPatientStories, items: []),
    DummyModel(date: "Consult", icon: icMenuConsult, items: []),
    DummyModel(date: "Healthfeed", icon: icMenuHealthFeed, items: []),
    DummyModel(icon: icMenuPrime, date: "Prime", items: []),
    DummyModel(date: "Report", icon: icMenuReport, items: []),
    DummyModel(date: "Earning", icon: icMenuEarning, items: []),
  ];

  List<DummyModel> get appList => _appList;
  final List<DummyModel> _rayList = [
    DummyModel(date: "Calendar", icon: icMenuCalender, items: []),
    DummyModel(date: "Patient", icon: icMenuPatient, items: []),
  ];

  List<DummyModel> get rayList => _rayList;

  //add Clinic

  final List<DummyModel> _clinicList = [
    DummyModel(
        icon:
            "https://img.freepik.com/free-vector/eye-logo-design-template_23-2150893414.jpg",
        date: "123 Main St, Springfield",
        content: "790 W. Chestnut Avenue, Monrovia, CA 91016",
        items: []),
    DummyModel(
        icon:
            "https://img.freepik.com/free-vector/eye-logo-design-template_23-2150893414.jpg",
        date: "123 Main St, Springfield",
        content: "790 W. Chestnut Avenue, Monrovia, CA 91016",
        items: []),
    DummyModel(
        icon:
            "https://images1-fabric.practo.com/547c04abc4c5bf75f8a96363d898701731923d0230983.jpg",
        date: "Clear Vision Eye Clinic",
        content: "790 W. Chestnut Avenue, Monrovia, CA 91016",
        items: []),
    DummyModel(
        icon:
            "https://img.freepik.com/free-vector/eye-logo-design-template_23-2150893414.jpg",
        date: "123 Main St, Springfield",
        content: "790 W. Chestnut Avenue, Monrovia, CA 91016",
        items: []),
  ];

  List<DummyModel> get clinicList => _clinicList;

//====================Calender View

  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();
  final Map<DateTime, List<String>> _events = {
    DateTime.utc(2024, 10, 16): ['Doctor Appointment', 'Eye Checkup'],
    DateTime.utc(2024, 10, 18): ['Team Meeting'],
    DateTime.utc(2024, 10, 20): ['Team Meeting'],
    DateTime.utc(2024, 10, 25): ['Team Meeting'],
  };

  DateTime get selectedDay => _selectedDay;

  DateTime get focusedDay => _focusedDay;

  Map<DateTime, List<String>> get events => _events;

  // Get events for a specific day
  List<String> getEventsForDay(DateTime day) {
    return _events[day] ?? [];
  }

  // Set selected day and notify listeners
  void setSelectedDay(DateTime selectedDay, DateTime focusedDay) {
    _selectedDay = selectedDay;
    _focusedDay = focusedDay;
    notifyListeners();
  }

  // Add new event (for example, could be used with Add Appointment button)
  void addEvent(DateTime day, String event) {
    if (_events[day] != null) {
      _events[day]!.add(event);
    } else {
      _events[day] = [event];
    }
    notifyListeners();
  }

  //form dropdown

  String? _selectedValue;

  String? get selectedValue => _selectedValue;

  set selectionValue(String newPin) {
    _selectedValue = newPin;
    notifyListeners();
  }

  final List<Booking> _bookings = [
    Booking(
        name: 'Alice Johnson',
        date: '11\nOCT',
        status: 'CONFIRMED',
        price: 375.0),
    Booking(
        name: 'James Williams',
        date: '09\nOCT',
        status: 'CONFIRMED',
        price: 0.0),
    Booking(
        name: 'Sophia Brown',
        date: '09\nOCT',
        status: 'CONFIRMED',
        price: 375.0),
    Booking(
        name: 'Liam Jones',
        date: '08\nOCT',
        status: 'CANCELLED',
        price: 375.0,
        isCancelled: true),
  ];

  List<Booking> get bookings => _bookings;

  String? _selectedMenu;

  String? get selectedMenu => _selectedMenu;

  void setSelectedMenu(String? index) {
    _selectedMenu = index;
    notifyListeners(); // Notify the listeners when the index is changed
  }

  final List<DashboardModel> navigationItems = [
    DashboardModel(
      icon: const Icon(Icons.home),
      selectedIcon: const Icon(Icons.home),
      label: "Home",
    ),
    DashboardModel(
      icon: const Icon(Icons.chat),
      selectedIcon: const Icon(Icons.chat),
      label: "Q&A",
    ),
    DashboardModel(
      icon: const Icon(Icons.mark_unread_chat_alt),
      selectedIcon: const Icon(Icons.mark_unread_chat_alt),
      label: "Chat",
    ),
  ];

  //
}

class Booking {
  final String name;
  final String date;
  final String status;
  final double price;
  final bool isCancelled;

  Booking({
    required this.name,
    required this.date,
    required this.status,
    required this.price,
    this.isCancelled = false,
  });
}
