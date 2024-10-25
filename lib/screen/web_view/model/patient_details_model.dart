class PatientDetailsModel {
  List<Patients> patients=[];
  int? currentPage;
  int? totalPages;
  int? totalPatients;

  PatientDetailsModel(
      {required this.patients, this.currentPage, this.totalPages, this.totalPatients});

  PatientDetailsModel.fromJson(Map<String, dynamic> json) {
    if (json['patients'] != null) {
      patients = <Patients>[];
      json['patients'].forEach((v) {
        patients.add(new Patients.fromJson(v));
      });
    }
    currentPage = json['currentPage'];
    totalPages = json['totalPages'];
    totalPatients = json['totalPatients'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['patients'] = patients.map((v) => v.toJson()).toList();
      data['currentPage'] = currentPage;
    data['totalPages'] = totalPages;
    data['totalPatients'] = totalPatients;
    return data;
  }
}

class Patients {
  String? sId;
  String? firstName;
  String? lastName;
  String? email;
  String? phoneNumber;
  String? dateOfBirth;
  String? gender;

  Patients(
      {this.sId,
        this.firstName,
        this.lastName,
        this.email,
        this.phoneNumber,
        this.dateOfBirth,
        this.gender});

  Patients.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    phoneNumber = json['phoneNumber'];
    dateOfBirth = json['dateOfBirth'];
    gender = json['gender'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['email'] = email;
    data['phoneNumber'] = phoneNumber;
    data['dateOfBirth'] = dateOfBirth;
    data['gender'] = gender;
    return data;
  }
}
