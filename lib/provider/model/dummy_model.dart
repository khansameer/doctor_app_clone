class DummyModel
{
String ?date;
List<SubItem> items;

DummyModel({required this.items,this.date});
}

class SubItem{
  String ? days;
  String? content;
  SubItem({this.content,this.days});

}