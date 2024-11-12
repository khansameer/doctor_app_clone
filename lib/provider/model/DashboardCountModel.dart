class DashboardCountModel {
  int? completed;
  int? rescheduled;
  int? missed;
  int? upcoming;

  DashboardCountModel(
      {this.completed, this.rescheduled, this.missed, this.upcoming});

  DashboardCountModel.fromJson(Map<String, dynamic> json) {
    completed = json['completed'];
    rescheduled = json['rescheduled'];
    missed = json['missed'];
    upcoming = json['upcoming'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['completed'] = completed;
    data['rescheduled'] = rescheduled;
    data['missed'] = missed;
    data['upcoming'] = upcoming;
    return data;
  }
}
