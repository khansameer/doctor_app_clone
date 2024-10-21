class AppointmentsModel {
  List<Appointments> appointments=[];
  int? currentPage;
  int? totalPages;
  int? totalAppointments;

  AppointmentsModel(
      {required this.appointments,
        this.currentPage,
        this.totalPages,
        this.totalAppointments});

  AppointmentsModel.fromJson(Map<String, dynamic> json) {
    if (json['appointments'] != null) {
      appointments = <Appointments>[];
      json['appointments'].forEach((v) {
        appointments.add(Appointments.fromJson(v));
      });
      var list = json['appointments'] as List;
      List<AppointmentsModel> appointmentsList =
      list.map((i) => AppointmentsModel.fromJson(i)).toList();
    }

    currentPage = json['currentPage'];
    totalPages = json['totalPages'];
    totalAppointments = json['totalAppointments'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['appointments'] = appointments.map((v) => v.toJson()).toList();
      data['currentPage'] = currentPage;
    data['totalPages'] = totalPages;
    data['totalAppointments'] = totalAppointments;
    return data;
  }
}

class Appointments {
  String? sId;
  Patient? patient;
  String? dateTime;
  String? status;
  String? reason;

  Appointments(
      {this.sId, this.patient, this.dateTime, this.status, this.reason});

  Appointments.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    patient =
    json['patient'] != null ? new Patient.fromJson(json['patient']) : null;
    dateTime = json['dateTime'];
    status = json['status'];
    reason = json['reason'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    if (patient != null) {
      data['patient'] = patient!.toJson();
    }
    data['dateTime'] = dateTime;
    data['status'] = status;
    data['reason'] = reason;
    return data;
  }
}

class Patient {
  String? sId;
  String? email;

  Patient({this.sId, this.email});

  Patient.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['email'] = email;
    return data;
  }
}
