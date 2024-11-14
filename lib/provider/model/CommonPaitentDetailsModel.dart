class CommonPatientDetailsModel {
  bool success;
  Data data;

  CommonPatientDetailsModel({required this.success, required this.data});

  factory CommonPatientDetailsModel.fromJson(Map<String, dynamic> json) {
    return CommonPatientDetailsModel(
      success: json['success'],
      data: Data.fromJson(json['data']),
    );
  }
}

class Data {
  String id;
  User user;
  Profile profile;
  List<dynamic> healthGoals;
  List<dynamic> healthIssues;
  List<dynamic> symptoms;
  List<Appointment> appointment;
  String createdAt;
  String updatedAt;

  Data({
    required this.id,
    required this.user,
    required this.profile,
    required this.healthGoals,
    required this.healthIssues,
    required this.symptoms,
    required this.appointment,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      id: json['_id'],
      user: User.fromJson(json['user']),
      profile: Profile.fromJson(json['profile']),
      healthGoals: json['healthGoals'],
      healthIssues: json['healthIssues'],
      symptoms: json['symptoms'],
      appointment: (json['appointment'] as List)
          .map((e) => Appointment.fromJson(e))
          .toList(),
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }
}

class User {
  ProfileInfo profile;
  String firstName;
  String lastName;
  String email;
  String phoneNumber;
  String gender;
  DateTime dateOfBirth;

  User({
    required this.profile,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNumber,
    required this.gender,
    required this.dateOfBirth,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      profile: ProfileInfo.fromJson(json['profile']),
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
      phoneNumber: json['phoneNumber'],
      gender: json['gender'],
      dateOfBirth: DateTime.parse(json['dateOfBirth']),
    );
  }
}

class ProfileInfo {
  String profilePicture;

  ProfileInfo({required this.profilePicture});

  factory ProfileInfo.fromJson(Map<String, dynamic> json) {
    return ProfileInfo(
      profilePicture: json['profilePicture'],
    );
  }
}

class Profile {
  String height;
  String weight;
  List<dynamic> allergies;
  List<dynamic> chronicConditions;
  EmergencyContact emergencyContact;
  InsuranceInfo insuranceInfo;
  String bmi;

  Profile({
    required this.height,
    required this.weight,
    required this.allergies,
    required this.chronicConditions,
    required this.emergencyContact,
    required this.insuranceInfo,
    required this.bmi,
  });

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      height: json['height'],
      weight: json['weight'],
      allergies: json['allergies'],
      chronicConditions: json['chronicConditions'],
      emergencyContact: EmergencyContact.fromJson(json['emergencyContact']),
      insuranceInfo: InsuranceInfo.fromJson(json['insuranceInfo']),
      bmi: json['bmi'],
    );
  }
}

class EmergencyContact {
  EmergencyContact();

  factory EmergencyContact.fromJson(Map<String, dynamic> json) {
    return EmergencyContact();
  }
}

class InsuranceInfo {
  InsuranceInfo();

  factory InsuranceInfo.fromJson(Map<String, dynamic> json) {
    return InsuranceInfo();
  }
}

class Appointment {
  Prescription prescription;
  VirtualAppointment virtualAppointment;
  Invoice invoice;
  String id;
  String patient;
  String doctor;
  String doctorName;
  DateTime dateTime;
  String status;
  String appointmentType;
  String description;
  int duration;
  List<dynamic> patientFiles;
  String createdAt;
  String updatedAt;

  Appointment({
    required this.prescription,
    required this.virtualAppointment,
    required this.invoice,
    required this.id,
    required this.patient,
    required this.doctor,
    required this.doctorName,
    required this.dateTime,
    required this.status,
    required this.appointmentType,
    required this.description,
    required this.duration,
    required this.patientFiles,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Appointment.fromJson(Map<String, dynamic> json) {
    return Appointment(
      prescription: Prescription.fromJson(json['prescription']),
      virtualAppointment:
      VirtualAppointment.fromJson(json['virtualAppointment']),
      invoice: Invoice.fromJson(json['invoice']),
      id: json['_id'],
      patient: json['patient'],
      doctor: json['doctor'],
      doctorName: json['doctorName'],
      dateTime: DateTime.parse(json['dateTime']),
      status: json['status'],
      appointmentType: json['appointment_type'],
      description: json['description'],
      duration: json['duration'],
      patientFiles: json['patientFiles'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }
}

class Prescription {
  List<dynamic> medications;
  DateTime prescribedDate;

  Prescription({required this.medications, required this.prescribedDate});

  factory Prescription.fromJson(Map<String, dynamic> json) {
    return Prescription(
      medications: json['medications'],
      prescribedDate: DateTime.parse(json['prescribedDate']),
    );
  }
}

class VirtualAppointment {
  bool isVirtual;

  VirtualAppointment({required this.isVirtual});

  factory VirtualAppointment.fromJson(Map<String, dynamic> json) {
    return VirtualAppointment(
      isVirtual: json['isVirtual'],
    );
  }
}

class Invoice {
  List<InvoiceItem> items;
  int totalCost;
  int finalAmount;
  int totalDiscount;
  bool paid;

  Invoice({
    required this.items,
    required this.totalCost,
    required this.finalAmount,
    required this.totalDiscount,
    required this.paid,
  });

  factory Invoice.fromJson(Map<String, dynamic> json) {
    return Invoice(
      items: (json['items'] as List)
          .map((item) => InvoiceItem.fromJson(item))
          .toList(),
      totalCost: json['totalCost'],
      finalAmount: json['finalAmount'],
      totalDiscount: json['totalDiscount'],
      paid: json['paid'],
    );
  }
}

class InvoiceItem {
  String procedure;
  int cost;
  int discount;
  String id;

  InvoiceItem({
    required this.procedure,
    required this.cost,
    required this.discount,
    required this.id,
  });

  factory InvoiceItem.fromJson(Map<String, dynamic> json) {
    return InvoiceItem(
      procedure: json['procedure'],
      cost: json['cost'],
      discount: json['discount'],
      id: json['_id'],
    );
  }
}
