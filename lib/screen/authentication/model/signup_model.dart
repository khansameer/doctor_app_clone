class SignupModel {
  String? message;
  Doctor? doctor;
  String? token;

  SignupModel({this.message, this.doctor, this.token});

  SignupModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    doctor =
    json['doctor'] != null ? Doctor.fromJson(json['doctor']) : null;
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    if (doctor != null) {
      data['doctor'] = doctor!.toJson();
    }
    data['token'] = token;
    return data;
  }
}

class Doctor {
  String? user;
  List<String>? specializations;
  List<ClinicAddresses>? clinicAddresses;
  String? sId;
  int? iV;

  Doctor(
      {this.user,
        this.specializations,
        this.clinicAddresses,
        this.sId,
        this.iV});

  Doctor.fromJson(Map<String, dynamic> json) {
    user = json['user'];
    specializations = json['specializations'].cast<String>();
    if (json['clinicAddresses'] != null) {
      clinicAddresses = <ClinicAddresses>[];
      json['clinicAddresses'].forEach((v) {
        clinicAddresses!.add(ClinicAddresses.fromJson(v));
      });
    }
    sId = json['_id'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user'] = user;
    data['specializations'] = specializations;
    if (clinicAddresses != null) {
      data['clinicAddresses'] =
          clinicAddresses!.map((v) => v.toJson()).toList();
    }
    data['_id'] = sId;
    data['__v'] = iV;
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
