class GetAppointmentsDetailsModel {
  String? sId;
  Patient? patient;
  Patient? doctor;
  String? doctorName;
  String? dateTime;
  String? status;
  String? reason;
  int? duration;
  Prescription? prescription;
  VirtualAppointment? virtualAppointment;
  Invoice? invoice;
  /* List<Null>? patientFiles;*/
  String? createdAt;
  String? updatedAt;
  int? iV;

  GetAppointmentsDetailsModel(
      {this.sId,
      this.patient,
      this.doctor,
      this.doctorName,
      this.dateTime,
      this.status,
      this.reason,
      this.duration,
      this.prescription,
      this.virtualAppointment,
      this.invoice,
      // this.patientFiles,
      this.createdAt,
      this.updatedAt,
      this.iV});

  GetAppointmentsDetailsModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    patient =
        json['patient'] != null ? new Patient.fromJson(json['patient']) : null;
    doctor =
        json['doctor'] != null ? new Patient.fromJson(json['doctor']) : null;
    doctorName = json['doctorName'];
    dateTime = json['dateTime'];
    status = json['status'];
    reason = json['reason'];
    duration = json['duration'];
    prescription = json['prescription'] != null
        ? new Prescription.fromJson(json['prescription'])
        : null;
    virtualAppointment = json['virtualAppointment'] != null
        ? new VirtualAppointment.fromJson(json['virtualAppointment'])
        : null;
    invoice = json['procedure'] != null
        ? new Invoice.fromJson(json['procedure'])
        : null;
    /*if (json['patientFiles'] != null) {
      patientFiles = <Null>[];
      json['patientFiles'].forEach((v) {
        patientFiles!.add(Null.fromJson(v));
      });
    }*/
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    if (patient != null) {
      data['patient'] = patient!.toJson();
    }
    if (doctor != null) {
      data['doctor'] = doctor!.toJson();
    }
    data['doctorName'] = doctorName;
    data['dateTime'] = dateTime;
    data['status'] = status;
    data['reason'] = reason;
    data['duration'] = duration;
    if (prescription != null) {
      data['prescription'] = prescription!.toJson();
    }
    if (virtualAppointment != null) {
      data['virtualAppointment'] = virtualAppointment!.toJson();
    }
    if (invoice != null) {
      data['procedure'] = invoice!.toJson();
    }
    /* if (this.patientFiles != null) {
      data['patientFiles'] = this.patientFiles!.map((v) => v.toJson()).toList();
    }*/
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}

class Patient {
  String? sId;
  String? firstName;
  String? lastName;
  String? email;
  String? phoneNumber;

  Patient(
      {this.sId, this.firstName, this.lastName, this.email, this.phoneNumber});

  Patient.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    phoneNumber = json['phoneNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['email'] = email;
    data['phoneNumber'] = phoneNumber;
    return data;
  }
}

class Prescription {
  List<Null>? medications;
  String? prescribedDate;

  Prescription({this.medications, this.prescribedDate});

  Prescription.fromJson(Map<String, dynamic> json) {
    /*if (json['medications'] != null) {
      medications = <Null>[];
      json['medications'].forEach((v) {
        medications!.add(new Null.fromJson(v));
      });
    }*/
    prescribedDate = json['prescribedDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    /*if (medications != null) {
      data['medications'] = medications!.map((v) => v.toJson()).toList();
    }*/
    data['prescribedDate'] = prescribedDate;
    return data;
  }
}

class VirtualAppointment {
  bool? isVirtual;

  VirtualAppointment({this.isVirtual});

  VirtualAppointment.fromJson(Map<String, dynamic> json) {
    isVirtual = json['isVirtual'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['isVirtual'] = isVirtual;
    return data;
  }
}

class Invoice {
  List<Items>? items;
  int? totalCost;
  int? finalAmount;
  int? totalDiscount;
  bool? paid;

  Invoice(
      {this.items,
      this.totalCost,
      this.finalAmount,
      this.totalDiscount,
      this.paid});

  Invoice.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(new Items.fromJson(v));
      });
    }
    totalCost = json['totalCost'];
    finalAmount = json['finalAmount'];
    totalDiscount = json['totalDiscount'];
    paid = json['paid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (items != null) {
      data['items'] = items!.map((v) => v.toJson()).toList();
    }
    data['totalCost'] = totalCost;
    data['finalAmount'] = finalAmount;
    data['totalDiscount'] = totalDiscount;
    data['paid'] = paid;
    return data;
  }
}

class Items {
  String? procedure;
  int? cost;
  int? discount;
  String? sId;

  Items({this.procedure, this.cost, this.discount, this.sId});

  Items.fromJson(Map<String, dynamic> json) {
    procedure = json['Consultation'];
    cost = json['cost'];
    discount = json['discount'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Consultation'] = procedure;
    data['cost'] = cost;
    data['discount'] = discount;
    data['_id'] = sId;
    return data;
  }
}
