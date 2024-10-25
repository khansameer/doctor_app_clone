class AppointmentsModel {
  List<Appointments>? appointments;
  int? currentPage;
  int? totalPages;
  int? totalAppointments;

  AppointmentsModel(
      {this.appointments,
        this.currentPage,
        this.totalPages,
        this.totalAppointments});

  AppointmentsModel.fromJson(Map<String, dynamic> json) {
    if (json['appointments'] != null) {
      appointments = <Appointments>[];
      json['appointments'].forEach((v) {
        appointments!.add(Appointments.fromJson(v));
      });
    }
    currentPage = json['currentPage'];
    totalPages = json['totalPages'];
    totalAppointments = json['totalAppointments'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (appointments != null) {
      data['appointments'] = appointments!.map((v) => v.toJson()).toList();
    }
    data['currentPage'] = currentPage;
    data['totalPages'] = totalPages;
    data['totalAppointments'] = totalAppointments;
    return data;
  }
}

class Appointments {
  String? sId;
  String? patient;
  String? doctor;
  String? dateTime;
  String? status;
  String? reason;
  String? doctorName;
  String? patientName;
  String? patientEmail;
  String? patientPhoneNumber;

  Appointments(
      {this.sId,
        this.patient,
        this.doctor,
        this.dateTime,
        this.status,
        this.reason,
        this.doctorName,
        this.patientName,
        this.patientEmail,
        this.patientPhoneNumber});

  Appointments.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    patient = json['patient'];
    doctor = json['doctor'];
    dateTime = json['dateTime'];
    status = json['status'];
    reason = json['reason'];
    doctorName = json['doctorName'];
    patientName = json['patientName'];
    patientEmail = json['patientEmail'];
    patientPhoneNumber = json['patientPhoneNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['_id'] = sId;
    data['patient'] = patient;
    data['doctor'] = doctor;
    data['dateTime'] = dateTime;
    data['status'] = status;
    data['reason'] = reason;
    data['doctorName'] = doctorName;
    data['patientName'] = patientName;
    data['patientEmail'] = patientEmail;
    data['patientPhoneNumber'] = patientPhoneNumber;
    return data;
  }
}
