class DoctorDetailsModel {
  String? id;
  String? firstName;
  String? lastName;
  String? email;
  String? phoneNumber;
  String? dateOfBirth;
  String? gender;
  String? profilePicture;


  DoctorDetailsModel({this.id, this.firstName, this.lastName, this.email, this.phoneNumber, this.dateOfBirth, this.gender, this.profilePicture,});

  DoctorDetailsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    phoneNumber = json['phoneNumber'];
    dateOfBirth = json['dateOfBirth'];
    gender = json['gender'];
    profilePicture = json['profilePicture'];



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
    data['profilePicture'] = profilePicture;

    return data;
  }
}
