import 'package:doctor_app/provider/model/dummy_model.dart';
import 'package:flutter/cupertino.dart';

class DashboardProvider extends ChangeNotifier {
  List<DummyModel> get itemNotification => _itemNotification;
  final List<DummyModel> _itemNotification = [
    DummyModel(
        date: "Saturday, 5 October 2024",
        items: [
          SubItem(content: "A 18 years old Male from Kolkata has asked a question about Eye check up", days: "8 days Ago"),
          SubItem(content: "You have 3 consult questions assigned to you"),

        ]),
    DummyModel(
        date: "Saturday, 5 October 2024",
        items: [
          SubItem(content: "A 18 years old Male from Kolkata has asked a question about Eye check up", days: "8 days Ago"),
          SubItem(content: "You have 3 consult questions assigned to you"),
        ]),
    DummyModel(
        date: "Saturday, 5 October 2024",
        items: [
          SubItem(content: "A 18 years old Male from Kolkata has asked a question about Eye check up", days: "8 days Ago"),
          SubItem(content: "You have 3 consult questions assigned to you"),
        ]),
    DummyModel(
        date: "Saturday, 5 October 2024",
        items: [
          SubItem(content: "A 18 years old Male from Kolkata has asked a question about Eye check up", days: "8 days Ago"),
          SubItem(content: "You have 3 consult questions assigned to you"),

        ]),
    DummyModel(
        date: "Saturday, 5 October 2024",
        items: [
          SubItem(content: "A 18 years old Male from Kolkata has asked a question about Eye check up", days: "8 days Ago"),
          SubItem(content: "You have 3 consult questions assigned to you"),
        ]),
    DummyModel(
        date: "Saturday, 5 October 2024",
        items: [
          SubItem(content: "A 18 years old Male from Kolkata has asked a question about Eye check up", days: "8 days Ago"),
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
      DummyModel(
          date: "Profile",
          icon: "https://www.parker.com/search/img/icons/Category/Parker-Support-Icons_Category-Compliance.png",
          items: []),
    DummyModel(
        date: "Reach",
        icon: "https://strigo.ca/svg/icones/megaphone.svg",
        items: []),
    DummyModel(
        date: "Patient Stories",
        icon: "https://cdn-icons-png.flaticon.com/512/7835/7835679.png",
        items: []),
    DummyModel(
        date: "Healthfeed",
        icon: "https://cdn-icons-png.flaticon.com/512/11121/11121716.png",
        items: []),
    DummyModel(
        icon: "https://strigo.ca/svg/icones/megaphone.svg",
        date: "Prime",
        items: []),
    DummyModel(
        date: "Report",

        icon: "https://cdn-icons-png.flaticon.com/512/979/979241.png",
        items: []),
    DummyModel(
        date: "Earning",
        icon: "https://www.grundon.com/content/uploads/2022/11/1-Efficient-and-cost-effective.svg  ",
        items: []),

  ];
  List<DummyModel> get appList => _appList;
  final List<DummyModel> _rayList = [
    DummyModel(
        date: "Calender",
        icon: "https://cdn-icons-png.freepik.com/512/12745/12745841.png?ga=GA1.1.1975054063.1728902814",
        items: []),
    DummyModel(
        date: "Patient",
        icon: "https://cdn-icons-png.flaticon.com/512/5762/5762410.png",
        items: []),


  ];
  List<DummyModel> get rayList => _rayList;
  //add Clinic


  final List<DummyModel> _clinicList= [
    DummyModel(
      icon: "https://img.freepik.com/free-vector/eye-logo-design-template_23-2150893414.jpg",
        date: "Dadar Eye & Gynaec Centre",
        content: "Dadar East, Mumbai",
        items: []),
    DummyModel(
        icon: "https://images1-fabric.practo.com/547c04abc4c5bf75f8a96363d898701731923d0230983.jpg",
        date: "Clear Vision Eye Clinic",
        content: "Wadala, Mumbai",
        items: []),


  ];
  List<DummyModel> get clinicList => _clinicList;


}
