class DoctorDetailsModel {
  String? id;
  String? firstName;
  String? lastName;
  String? email;
  String? phoneNumber;
  String? dateOfBirth;
  String? gender;
  List<Specializations>? specializations;
  List<ClinicAddresses>? clinicAddresses;
  String? licenseNumber;
  Profile? profile;

  DoctorDetailsModel(
      {this.id,
      this.firstName,
      this.lastName,
      this.email,
      this.phoneNumber,
      this.dateOfBirth,
      this.gender,
      this.specializations,
      this.clinicAddresses,
      this.licenseNumber,
      this.profile});

  DoctorDetailsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    phoneNumber = json['phoneNumber'];
    dateOfBirth = json['dateOfBirth'];
    gender = json['gender'];
    if (json['specializations'] != null) {
      specializations = <Specializations>[];
      json['specializations'].forEach((v) {
        specializations!.add(new Specializations.fromJson(v));
      });
    }
    if (json['clinicAddresses'] != null) {
      clinicAddresses = <ClinicAddresses>[];
      json['clinicAddresses'].forEach((v) {
        clinicAddresses!.add(new ClinicAddresses.fromJson(v));
      });
    }
    licenseNumber = json['licenseNumber'];
    profile =
        json['profile'] != null ? new Profile.fromJson(json['profile']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['email'] = email;
    data['phoneNumber'] = phoneNumber;
    data['dateOfBirth'] = dateOfBirth;
    data['gender'] = gender;
    if (specializations != null) {
      data['specializations'] =
          specializations!.map((v) => v.toJson()).toList();
    }
    if (clinicAddresses != null) {
      data['clinicAddresses'] =
          clinicAddresses!.map((v) => v.toJson()).toList();
    }
    data['licenseNumber'] = licenseNumber;
    if (profile != null) {
      data['profile'] = profile!.toJson();
    }
    return data;
  }
}

class Specializations {
  String? sId;
  String? name;

  Specializations({this.sId, this.name});

  Specializations.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['name'] = name;
    return data;
  }
}

class ClinicAddresses {
  String? address;
  String? city;
  String? state;
  String? zipCode;
  String? sId;

  ClinicAddresses(
      {this.address, this.city, this.state, this.zipCode, this.sId});

  ClinicAddresses.fromJson(Map<String, dynamic> json) {
    address = json['address'];
    city = json['city'];
    state = json['state'];
    zipCode = json['zipCode'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['address'] = address;
    data['city'] = city;
    data['state'] = state;
    data['zipCode'] = zipCode;
    data['_id'] = sId;
    return data;
  }
}

class Profile {
  List<Qualification>? qualification;
  int? experience;
  List<dynamic>? availability;
  List<dynamic>? hospitalAffiliations;

  Profile(
      {this.qualification,
      this.experience,
      this.availability,
      this.hospitalAffiliations});

  Profile.fromJson(Map<String, dynamic> json) {
    if (json['qualification'] != null) {
      qualification = <Qualification>[];
      json['qualification'].forEach((v) {
        qualification!.add(Qualification.fromJson(v));
      });
    }
    experience = json['experience'];
    if (json['availability'] != null) {
      availability = <Null>[];
      json['availability'].forEach((v) {
        //  availability!.add(new Null.fromJson(v));
      });
    }
    if (json['hospitalAffiliations'] != null) {
      hospitalAffiliations = <Null>[];
      json['hospitalAffiliations'].forEach((v) {
        //hospitalAffiliations!.add(new Null.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (qualification != null) {
      data['qualification'] = qualification!.map((v) => v.toJson()).toList();
    }
    data['experience'] = experience;
    if (availability != null) {
      data['availability'] = availability!.map((v) => v.toJson()).toList();
    }
    if (hospitalAffiliations != null) {
      data['hospitalAffiliations'] =
          hospitalAffiliations!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Qualification {
  String? degree;
  String? institution;
  int? year;
  String? sId;

  Qualification({this.degree, this.institution, this.year, this.sId});

  Qualification.fromJson(Map<String, dynamic> json) {
    degree = json['degree'];
    institution = json['institution'];
    year = json['year'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['degree'] = degree;
    data['institution'] = institution;
    data['year'] = year;
    data['_id'] = sId;
    return data;
  }
}
