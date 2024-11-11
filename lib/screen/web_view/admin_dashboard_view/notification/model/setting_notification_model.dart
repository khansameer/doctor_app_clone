class SettingNotificationModel {
  Email? email;
  Email? sms;
  Email? push;
  String? sId;
  String? user;
  String? createdAt;
  String? updatedAt;

  SettingNotificationModel(
      {this.email,
        this.sms,
        this.push,
        this.sId,
        this.user,
        this.createdAt,
        this.updatedAt});

  SettingNotificationModel.fromJson(Map<String, dynamic> json) {
    email = json['email'] != null ? new Email.fromJson(json['email']) : null;
    sms = json['sms'] != null ? new Email.fromJson(json['sms']) : null;
    push = json['push'] != null ? new Email.fromJson(json['push']) : null;
    sId = json['_id'];
    user = json['user'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.email != null) {
      data['email'] = this.email!.toJson();
    }
    if (this.sms != null) {
      data['sms'] = this.sms!.toJson();
    }
    if (this.push != null) {
      data['push'] = this.push!.toJson();
    }
    data['_id'] = this.sId;
    data['user'] = this.user;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}

class Email {
  bool? appointments;
  bool? reminders;
  bool? prescriptions;
  bool? reports;
  bool? marketing;

  Email(
      {this.appointments,
        this.reminders,
        this.prescriptions,
        this.reports,
        this.marketing});

  Email.fromJson(Map<String, dynamic> json) {
    appointments = json['appointments'];
    reminders = json['reminders'];
    prescriptions = json['prescriptions'];
    reports = json['reports'];
    marketing = json['marketing'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['appointments'] = this.appointments;
    data['reminders'] = this.reminders;
    data['prescriptions'] = this.prescriptions;
    data['reports'] = this.reports;
    data['marketing'] = this.marketing;
    return data;
  }
}