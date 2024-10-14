class DummyModel
{
String ?date;
String ?content;
String ?icon;
List<SubItem> items;

DummyModel({required this.items,this.date,this.icon,this.content});
}

class SubItem{
  String ? days;
  String? content;
  SubItem({this.content,this.days});

}