class FeedbackModel {
  bool? success;
  Data? data;

  FeedbackModel({this.success, this.data});

  FeedbackModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  List<Feedbacks>? feedbacks;
  Pagination? pagination;

  Data({this.feedbacks, this.pagination});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['feedbacks'] != null) {
      feedbacks = <Feedbacks>[];
      json['feedbacks'].forEach((v) {
        feedbacks!.add(new Feedbacks.fromJson(v));
      });
    }
    pagination = json['pagination'] != null
        ? new Pagination.fromJson(json['pagination'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.feedbacks != null) {
      data['feedbacks'] = this.feedbacks!.map((v) => v.toJson()).toList();
    }
    if (this.pagination != null) {
      data['pagination'] = this.pagination!.toJson();
    }
    return data;
  }
}

class Feedbacks {
  String? id;
  int? rating;
  String? comment;
  bool? isEdited;
  String? createdAt;
  Patient? patient;
  Appointment? appointment;

  Feedbacks(
      {this.id,
        this.rating,
        this.comment,
        this.isEdited,
        this.createdAt,
        this.patient,
        this.appointment});

  Feedbacks.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    rating = json['rating'];
    comment = json['comment'];
    isEdited = json['isEdited'];
    createdAt = json['createdAt'];
    patient =
    json['patient'] != null ? new Patient.fromJson(json['patient']) : null;
    appointment = json['appointment'] != null
        ? new Appointment.fromJson(json['appointment'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['rating'] = this.rating;
    data['comment'] = this.comment;
    data['isEdited'] = this.isEdited;
    data['createdAt'] = this.createdAt;
    if (this.patient != null) {
      data['patient'] = this.patient!.toJson();
    }
    if (this.appointment != null) {
      data['appointment'] = this.appointment!.toJson();
    }
    return data;
  }
}

class Patient {
  String? id;
  String? name;

  Patient({this.id, this.name});

  Patient.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}

class Appointment {
  String? id;
  String? dateTime;
  String? type;

  Appointment({this.id, this.dateTime, this.type});

  Appointment.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    dateTime = json['dateTime'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['dateTime'] = this.dateTime;
    data['type'] = this.type;
    return data;
  }
}

class Pagination {
  int? currentPage;
  int? totalPages;
  int? totalFeedbacks;
  bool? hasNextPage;
  bool? hasPreviousPage;

  Pagination(
      {this.currentPage,
        this.totalPages,
        this.totalFeedbacks,
        this.hasNextPage,
        this.hasPreviousPage});

  Pagination.fromJson(Map<String, dynamic> json) {
    currentPage = json['currentPage'];
    totalPages = json['totalPages'];
    totalFeedbacks = json['totalFeedbacks'];
    hasNextPage = json['hasNextPage'];
    hasPreviousPage = json['hasPreviousPage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['currentPage'] = this.currentPage;
    data['totalPages'] = this.totalPages;
    data['totalFeedbacks'] = this.totalFeedbacks;
    data['hasNextPage'] = this.hasNextPage;
    data['hasPreviousPage'] = this.hasPreviousPage;
    return data;
  }
}