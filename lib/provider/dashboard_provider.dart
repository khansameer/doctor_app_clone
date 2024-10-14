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

}
