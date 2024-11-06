class DummyModel
{
String ?date;
String ?title;
String ?content;
String ?icon;
String ?rating;
double  ?ratingValue;
List<SubItem> items;

DummyModel({required this.items,this.date,this.icon,this.content,this.title,this.rating,this.ratingValue});
}

class SubItem{
  String ? days;
  String? content;
  SubItem({this.content,this.days});

}