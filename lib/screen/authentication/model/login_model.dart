class LoginModel {
  String? message;
  String? token;
  String? userId;
  String? firstName;
  String? lastName;
  String? email;
  String? phoneNumber;
  String? gender;
  String? role;

  LoginModel(
      {this.message,
        this.token,
        this.userId,
        this.firstName,
        this.lastName,
        this.email,
        this.phoneNumber,
        this.gender,
        this.role});

  LoginModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    token = json['token'];
    userId = json['userId'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    phoneNumber = json['phoneNumber'];
    gender = json['gender'];
    role = json['role'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['token'] = token;
    data['userId'] = userId;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['email'] = email;
    data['phoneNumber'] = phoneNumber;
    data['gender'] = gender;
    data['role'] = role;
    return data;
  }
}
