import 'package:doctor_app/core/image/image_path.dart';
import 'package:flutter/cupertino.dart';

class DummyModel{
  String? date;
  String? time;
  String ? title;
  String ? price;

  DummyModel({this.date, this.time, this.title,this.price});
}
class BillingProvider with ChangeNotifier{

  List<DummyModel> paymentList=[
    DummyModel(title: "Salary",date:"2022-10-21" ,time:"11:43 AM",price: '+\$3481.25'),
    DummyModel(title: "Buying shoe covers",date:"2022-10-21" ,time:"02:32 PM",price: '-\$2.155'),
    DummyModel(title: "Collection of material for analysis",date:"2022-10-21" ,time:"03:40 PM",price: '+\$10.85'),
    DummyModel(title: "Cinema tickets",date:"2022-10-21" ,time:"06:11 PM",price: '-\$20.00'),
    DummyModel(title: "Morbi leo risus",date:"2024-11-12" ,time:"01:59 PM",price: '-\$514.15'),
    DummyModel(title: "Morbi leo risus",date:"2024-11-12" ,time:"01:59 PM",price: '+\$14.85'),
    DummyModel(title: "Morbi leo risus",date:"2024-11-12" ,time:"01:59 PM",price: '+\$11.85'),
    DummyModel(title: "Morbi leo risus",date:"2024-11-12" ,time:"01:59 PM",price: '+\$10.85'),
    DummyModel(title: "Morbi leo risus",date:"2024-11-12" ,time:"01:59 PM",price: '-\$10.85'),

    DummyModel(title: "Morbi leo risus",date:"2024-11-12" ,time:"01:59 PM",price: '-\$514.15'),
    DummyModel(title: "Morbi leo risus",date:"2024-11-12" ,time:"01:59 PM",price: '+\$14.85'),
    DummyModel(title: "Morbi leo risus",date:"2024-11-12" ,time:"01:59 PM",price: '+\$11.85'),
    DummyModel(title: "Morbi leo risus",date:"2024-11-12" ,time:"01:59 PM",price: '+\$10.85'),
    DummyModel(title: "Morbi leo risus",date:"2024-11-12" ,time:"01:59 PM",price: '-\$10.85'),



  ];


  int _selectedIndex = -1;

  int get selectedIndex => _selectedIndex;

  void selectCard(int index) {
    _selectedIndex = index;
    notifyListeners();
  }




  final List<Map<String, String>> cards = [
    {'type': 'Visa', 'name': 'New', 'icon': icVisa},
    {'type': 'Visa', 'name': 'My New Visa','icon': icVisa},
    {'type': 'MasterCard', 'name': 'Main payment card','icon': icMaster},
    {'type': 'Visa', 'name': 'Visa Card','icon': icVisa},

  ];





}