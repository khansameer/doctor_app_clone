class WeeklyGraphModel {
  final String day;
  final int count;

  WeeklyGraphModel({required this.day, required this.count});

  factory WeeklyGraphModel.fromJson(Map<String, dynamic> json) {
    return WeeklyGraphModel(
      day: json['day'],
      count: json['count'],
    );
  }
}
