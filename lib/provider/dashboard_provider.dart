
import 'package:doctor_app/core/image/image_path.dart';
import 'package:doctor_app/main.dart';
import 'package:doctor_app/provider/model/dummy_model.dart';
import 'package:doctor_app/screen/dashboard/calender/calender_screen.dart';
import 'package:doctor_app/screen/dashboard/chat_screen/chat_screen.dart';
import 'package:doctor_app/screen/dashboard/chat_screen/patient_list_screen.dart';
import 'package:doctor_app/screen/dashboard/consult/consult_screen.dart';
import 'package:doctor_app/screen/dashboard/dashboard_model.dart';
import 'package:doctor_app/screen/dashboard/health_feed/health_feed_screen.dart';
import 'package:doctor_app/screen/dashboard/home/home_screen.dart';
import 'package:doctor_app/screen/dashboard/paitent_screen/patients_screen.dart';
import 'package:doctor_app/screen/dashboard/patient_stories/patient_stories_screen.dart';
import 'package:doctor_app/screen/dashboard/prime/prime_screen.dart';
import 'package:doctor_app/screen/dashboard/profile/edit_profile_screen.dart';
import 'package:doctor_app/screen/dashboard/profile/profile_screen.dart';
import 'package:doctor_app/screen/dashboard/reach/reach_screen.dart';
import 'package:doctor_app/screen/dashboard/report/report_screen.dart';
import 'package:doctor_app/screen/dashboard/weekly_earning/weekly_earning_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DashboardProvider extends ChangeNotifier {
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

  int _selectedIndex = 0;
  Widget _currentPage=HomeScreen(
    onSelectedPage: (page) {
      final dashboardProvider = Provider.of<DashboardProvider>(navigatorKey.currentState!.context, listen: false);
      dashboardProvider.getPageSelected=page;

    },

  );


  String ?_page;
  String? get page => _page;

  set getPageSelected(String  value) {
    print('==================sameer$value');
    _page = value;
    final provider = Provider.of<DashboardProvider>(navigatorKey.currentState!.context, listen: false);
    if(_page=="Profile"){
      provider.updatePage=const ProfileScreen();
    }
    if(_page=="Home"){
      provider.updatePage= HomeScreen(onSelectedPage: (value){
        final dashboardProvider = Provider.of<DashboardProvider>(navigatorKey.currentState!.context, listen: false);
        dashboardProvider.getPageSelected=value;

      });
    }
    if(_page=="Reach"){
      provider.updatePage=const ReachScreen();
    }

    if(_page=="Patient Stories"){
      provider.updatePage=const PatientStoriesScreen();
    }
    if(_page=="Consult"){
      provider.updatePage=const ConsultScreen();
    }
    if(_page=="Healthfeed"){
      provider.updatePage=const HealthFeedScreen();
    }
    if(_page=="Prime"){
      provider.updatePage=const PrimeScreen();
    }
    if(_page=="Report"){
      provider.updatePage=const ReportScreen();
    }
    if(_page=="Earning"){
      provider.updatePage=const WeeklyEarningScreen();
    }
    if(_page=="Calender"){
      provider.updatePage=const CalenderScreen();
    }
    if(_page=="Patient"){
      provider.updatePage=const PatientsScreen();
    }
    if(_page=="edit_profile"){
      provider.updatePage=const EditProfileScreen();
    }
    if(_page=="chat_user_list"){
      provider.updatePage=const PatientListScreen();
    }
    if(_page=="chat_screen"){
      provider.updatePage=const ChatScreen();
    }
    notifyListeners(); // Notify the listeners to rebuild the UI
  }

  String ? _appBarTitle="Home";
  int get selectedIndex => _selectedIndex;
  String? get appBarTitle => _appBarTitle;
  Widget get currentPage => _currentPage;

  set updatePage(Widget page) {
    _currentPage = page;
    notifyListeners(); // Notify the listeners to rebuild the UI
  }


  void setSelectedIndex(int index) {
    _selectedIndex = index;
    notifyListeners();
  }

  void setAppBarTitle(String value) {
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
    DummyModel(date: "Calender", icon: icMenuCalender, items: []),
    DummyModel(date: "Patient", icon: icMenuPatient, items: []),
  ];

  List<DummyModel> get rayList => _rayList;

  //add Clinic

  final List<DummyModel> _clinicList = [
    DummyModel(
        icon:
            "https://img.freepik.com/free-vector/eye-logo-design-template_23-2150893414.jpg",
        date: "Dadar Eye & Gynaec Centre",
        content: "790 W. Chestnut Avenue, Monrovia, CA 91016",
        items: []),

    DummyModel(
        icon:
        "https://img.freepik.com/free-vector/eye-logo-design-template_23-2150893414.jpg",
        date: "Dadar Eye & Gynaec Centre",
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
        date: "Dadar Eye & Gynaec Centre",
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

  final List<String> items = [
    'Item1',
    'Item2',
    'Item3',
    'Item4',
    'Item5',
    'Item6',
    'Item7',
    'Item8',
  ];

  final List<Booking> _bookings = [
    Booking(
        name: 'Nabajyoti Mandal',
        date: '11\nOCT',
        status: 'CONFIRMED',
        price: 375.0),
    Booking(
        name: 'Vijaylaxmi Das',
        date: '09\nOCT',
        status: 'CONFIRMED',
        price: 0.0),
    Booking(
        name: 'Pranjali Vasudeo',
        date: '09\nOCT',
        status: 'CONFIRMED',
        price: 375.0),
    Booking(
        name: 'Siddharth Das',
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

/*  void setSelectedIndex(int index) {
    _selectedIndex = index;
    notifyListeners(); // Notify the listeners when the index is changed
  }*/

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
