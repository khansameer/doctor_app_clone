class UserDetailsModel {
  User? user;

  UserDetailsModel({this.user});

  UserDetailsModel.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}

class User {
  Profile? profile;
  String? sId;
  String? firstName;
  String? lastName;
  String? email;
  String? password;
  String? phoneNumber;
  String? dateOfBirth;
  String? gender;
  String? role;
  String? status;
  String? createdAt;
  String? updatedAt;
  int? iV;

  User(
      {this.profile,
        this.sId,
        this.firstName,
        this.lastName,
        this.email,
        this.password,
        this.phoneNumber,
        this.dateOfBirth,
        this.gender,
        this.role,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.iV});

  User.fromJson(Map<String, dynamic> json) {
    profile =
    json['profile'] != null ? new Profile.fromJson(json['profile']) : null;
    sId = json['_id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    password = json['password'];
    phoneNumber = json['phoneNumber'];
    dateOfBirth = json['dateOfBirth'];
    gender = json['gender'];
    role = json['role'];
    status = json['status'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (profile != null) {
      data['profile'] = profile!.toJson();
    }
    data['_id'] = sId;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['email'] = email;
    data['password'] = password;
    data['phoneNumber'] = phoneNumber;
    data['dateOfBirth'] = dateOfBirth;
    data['gender'] = gender;
    data['role'] = role;
    data['status'] = status;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
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
