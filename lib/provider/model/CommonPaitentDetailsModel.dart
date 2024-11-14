class CommonPatientDetailsModel {
  bool? success;
  Data? data;

  CommonPatientDetailsModel({this.success, this.data});

  CommonPatientDetailsModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? sId;
  User? user;
  String? createdAt;
  String? updatedAt;

  Data({this.sId, this.user, this.createdAt, this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    if (user != null) {
      data['user'] = user!.toJson();

    }
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}

class User {
  Profile? profile;
  String? firstName;
  String? lastName;
  String? email;
  String? phoneNumber;
  String? gender;
  String? dateOfBirth;

  User(
      {this.profile,
        this.firstName,
        this.lastName,
        this.email,
        this.phoneNumber,
        this.gender,
        this.dateOfBirth});

  User.fromJson(Map<String, dynamic> json) {
    profile =
    json['profile'] != null ? Profile.fromJson(json['profile']) : null;
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    phoneNumber = json['phoneNumber'];
    gender = json['gender'];
    dateOfBirth = json['dateOfBirth'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (profile != null) {
      data['profile'] = profile!.toJson();
    }
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['email'] = email;
    data['phoneNumber'] = phoneNumber;
    data['gender'] = gender;
    data['dateOfBirth'] = dateOfBirth;
    return data;
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
