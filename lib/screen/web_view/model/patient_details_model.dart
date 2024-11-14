class PatientDetailsModel {
  List<Patients> patients = [];
  int? currentPage;
  int? totalPages;
  int? totalPatients;

  PatientDetailsModel(
      {required this.patients,
      this.currentPage,
      this.totalPages,
      this.totalPatients});

  PatientDetailsModel.fromJson(Map<String, dynamic> json) {
    if (json['patients'] != null) {
      patients = <Patients>[];
      json['patients'].forEach((v) {
        patients.add(Patients.fromJson(v));
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
  Profile? profile;
  Patients(
      {this.sId,
      this.firstName,
      this.lastName,
      this.email,
      this.phoneNumber,
      this.dateOfBirth,
      this.gender,
      this.profile});

  Patients.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    phoneNumber = json['phoneNumber'];
    dateOfBirth = json['dateOfBirth'];
    gender = json['gender'];
    profile =
        json['profile'] != null ? new Profile.fromJson(json['profile']) : null;
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
    if (profile != null) {
      data['profile'] = profile!.toJson();
    }
    return data;
  }
  String get mappedGender {
    if (gender != null) {
      if (gender!.toLowerCase() == 'male') {
        return 'Male';
      } else if (gender!.toLowerCase() == 'female') {
        return 'Female';
      } else {
        return 'Other';
      }
    }
    return 'Other'; // default to 'Other' if gender is null or doesn't match
  }
}

class Profile {
  String? profilePicture;

  Profile({this.profilePicture});

  Profile.fromJson(Map<String, dynamic> json) {
    profilePicture = json['profilePicture'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['profilePicture'] = profilePicture;
    return data;
  }
}
