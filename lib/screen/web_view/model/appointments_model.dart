class AppointmentsModel {
  bool? success;
  Data? data;

  AppointmentsModel({this.success, this.data});

  AppointmentsModel.fromJson(Map<String, dynamic> json) {
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
  List<Appointments>? appointments;
  Pagination? pagination;
  Filters? filters;

  Data({this.appointments, this.pagination, this.filters});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['appointments'] != null) {
      appointments = <Appointments>[];
      json['appointments'].forEach((v) {
        appointments!.add(new Appointments.fromJson(v));
      });
    }
    pagination = json['pagination'] != null
        ? new Pagination.fromJson(json['pagination'])
        : null;
    filters =
        json['filters'] != null ? new Filters.fromJson(json['filters']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.appointments != null) {
      data['appointments'] = this.appointments!.map((v) => v.toJson()).toList();
    }
    if (this.pagination != null) {
      data['pagination'] = this.pagination!.toJson();
    }
    if (this.filters != null) {
      data['filters'] = this.filters!.toJson();
    }
    return data;
  }
}

class Appointments {
  String? id;
  String? dateTime;
  String? status;
  String? appointmentType;
  String? reason;
  String? diagnosis;
  String? notes;
  bool? isVirtual;
  Null? meetingLink;
  Null? meetingId;
  Null? followUp;
  Patient? patient;
  Doctor? doctor;

  Appointments(
      {this.id,
      this.dateTime,
      this.status,
      this.appointmentType,
      this.reason,
      this.diagnosis,
      this.notes,
      this.isVirtual,
      this.meetingLink,
      this.meetingId,
      this.followUp,
      this.patient,
      this.doctor});

  Appointments.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    dateTime = json['dateTime'];
    status = json['status'];
    appointmentType = json['appointment_type'];
    reason = json['reason'];
    diagnosis = json['diagnosis'];
    notes = json['notes'];
    isVirtual = json['isVirtual'];
    meetingLink = json['meetingLink'];
    meetingId = json['meetingId'];
    followUp = json['followUp'];
    patient =
        json['patient'] != null ? new Patient.fromJson(json['patient']) : null;
    doctor =
        json['doctor'] != null ? new Doctor.fromJson(json['doctor']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['dateTime'] = this.dateTime;
    data['status'] = this.status;
    data['appointment_type'] = this.appointmentType;
    data['reason'] = this.reason;
    data['diagnosis'] = this.diagnosis;
    data['notes'] = this.notes;
    data['isVirtual'] = this.isVirtual;
    data['meetingLink'] = this.meetingLink;
    data['meetingId'] = this.meetingId;
    data['followUp'] = this.followUp;
    if (this.patient != null) {
      data['patient'] = this.patient!.toJson();
    }
    if (this.doctor != null) {
      data['doctor'] = this.doctor!.toJson();
    }
    return data;
  }
}

class Patient {
  String? id;
  String? name;
  String? email;
  String? phoneNumber;
  dynamic dateOfBirth;
  String? gender;
//  Profile? profile;

  Patient({
    this.id,
    this.name,
    this.email,
    this.phoneNumber,
    this.dateOfBirth,
    this.gender,
  });

  Patient.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phoneNumber = json['phoneNumber'];
    dateOfBirth = json['dateOfBirth'];
    gender = json['gender'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phoneNumber'] = this.phoneNumber;
    data['dateOfBirth'] = this.dateOfBirth;
    data['gender'] = this.gender;

    return data;
  }
}

class Doctor {
  String? id;
  String? name;
  String? email;
  String? phoneNumber;
  String? specialization;

  Doctor(
      {this.id, this.name, this.email, this.phoneNumber, this.specialization});

  Doctor.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phoneNumber = json['phoneNumber'];
    specialization = json['specialization'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phoneNumber'] = this.phoneNumber;
    data['specialization'] = this.specialization;
    return data;
  }
}

class Pagination {
  int? currentPage;
  int? totalPages;
  int? totalAppointments;
  bool? hasNextPage;
  bool? hasPreviousPage;
  int? limit;

  Pagination(
      {this.currentPage,
      this.totalPages,
      this.totalAppointments,
      this.hasNextPage,
      this.hasPreviousPage,
      this.limit});

  Pagination.fromJson(Map<String, dynamic> json) {
    currentPage = json['currentPage'];
    totalPages = json['totalPages'];
    totalAppointments = json['totalAppointments'];
    hasNextPage = json['hasNextPage'];
    hasPreviousPage = json['hasPreviousPage'];
    limit = json['limit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['currentPage'] = this.currentPage;
    data['totalPages'] = this.totalPages;
    data['totalAppointments'] = this.totalAppointments;
    data['hasNextPage'] = this.hasNextPage;
    data['hasPreviousPage'] = this.hasPreviousPage;
    data['limit'] = this.limit;
    return data;
  }
}

class Filters {
  String? status;
  String? appointmentType;
  DateRange? dateRange;

  Filters({this.status, this.appointmentType, this.dateRange});

  Filters.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    appointmentType = json['appointment_type'];
    dateRange = json['dateRange'] != null
        ? new DateRange.fromJson(json['dateRange'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['appointment_type'] = this.appointmentType;
    if (this.dateRange != null) {
      data['dateRange'] = this.dateRange!.toJson();
    }
    return data;
  }
}

class DateRange {
  Null? startDate;
  Null? endDate;

  DateRange({this.startDate, this.endDate});

  DateRange.fromJson(Map<String, dynamic> json) {
    startDate = json['startDate'];
    endDate = json['endDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['startDate'] = this.startDate;
    data['endDate'] = this.endDate;
    return data;
  }
}
