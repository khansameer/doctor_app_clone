class RegisterModel {
  String? userId;
  String? name;
  String? email;
  String? token;

  RegisterModel({this.userId, this.name, this.email, this.token});

  RegisterModel.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    name = json['name'];
    email = json['email'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId'] = userId;
    data['name'] = name;
    data['email'] = email;
    data['token'] = token;
    return data;
  }
}
