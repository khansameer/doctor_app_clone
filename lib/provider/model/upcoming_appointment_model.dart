class UpComingAppointmentModel {
  List<Appointments> ?appointments;
  Pagination? pagination;
  Filters? filters;

  UpComingAppointmentModel({required this.appointments, this.pagination, this.filters});

  UpComingAppointmentModel.fromJson(Map<String, dynamic> json) {
    if (json['appointments'] != null) {
      appointments = <Appointments>[];
      json['appointments'].forEach((v) {
        appointments?.add(Appointments.fromJson(v));
      });
    }
    pagination = json['pagination'] != null
        ? Pagination.fromJson(json['pagination'])
        : null;
    filters =
    json['filters'] != null ? Filters.fromJson(json['filters']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (appointments != null) {
      data['appointments'] = appointments!.map((v) => v.toJson()).toList();
    }
    if (pagination != null) {
      data['pagination'] = pagination!.toJson();
    }
    if (filters != null) {
      data['filters'] = filters!.toJson();
    }
    return data;
  }
}

class Appointments {
  String? id;
  String? dateTime;
  String? status;
  String? appointmentType;
  bool? isVirtual;
  Patient? patient;
  Doctor? doctor;

  Appointments(
      {this.id,
        this.dateTime,
        this.status,
        this.appointmentType,
        this.isVirtual,
        this.patient,
        this.doctor});

  Appointments.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    dateTime = json['dateTime'];
    status = json['status'];
    appointmentType = json['appointment_type'];
    isVirtual = json['isVirtual'];
    patient =
    json['patient'] != null ? Patient.fromJson(json['patient']) : null;
    doctor =
    json['doctor'] != null ? Doctor.fromJson(json['doctor']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['dateTime'] = dateTime;
    data['status'] = status;
    data['appointment_type'] = appointmentType;
    data['isVirtual'] = isVirtual;
    if (patient != null) {
      data['patient'] = patient!.toJson();
    }
    if (doctor != null) {
      data['doctor'] = doctor!.toJson();
    }
    return data;
  }
}

class Patient {
  String? id;
  String? name;
  String? email;
  String? phoneNumber;
  String? profilePicture;
  String? gender;

  Patient({this.id, this.name, this.email, this.phoneNumber});

  Patient.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phoneNumber = json['phoneNumber'];
    profilePicture = json['profilePicture'];
    gender = json['gender'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['phoneNumber'] = phoneNumber;
    data['profilePicture'] = profilePicture;
    data['gender'] = gender;
    return data;
  }
}

class Doctor {
  String? id;
  String? name;

  Doctor({this.id, this.name});

  Doctor.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}

class Pagination {
  int? currentPage;
  int? totalPages;
  int? totalAppointments;
  bool? hasNextPage;
  bool? hasPreviousPage;

  Pagination(
      {this.currentPage,
        this.totalPages,
        this.totalAppointments,
        this.hasNextPage,
        this.hasPreviousPage});

  Pagination.fromJson(Map<String, dynamic> json) {
    currentPage = json['currentPage'];
    totalPages = json['totalPages'];
    totalAppointments = json['totalAppointments'];
    hasNextPage = json['hasNextPage'];
    hasPreviousPage = json['hasPreviousPage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['currentPage'] = currentPage;
    data['totalPages'] = totalPages;
    data['totalAppointments'] = totalAppointments;
    data['hasNextPage'] = hasNextPage;
    data['hasPreviousPage'] = hasPreviousPage;
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
        ? DateRange.fromJson(json['dateRange'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['appointment_type'] = appointmentType;
    if (dateRange != null) {
      data['dateRange'] = dateRange!.toJson();
    }
    return data;
  }
}

class DateRange {
  String? startDate;
  String? endDate;

  DateRange({this.startDate, this.endDate});

  DateRange.fromJson(Map<String, dynamic> json) {
    startDate = json['startDate'];
    endDate = json['endDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['startDate'] = startDate;
    data['endDate'] = endDate;
    return data;
  }
}
