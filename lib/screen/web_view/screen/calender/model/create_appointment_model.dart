class CreateAppointmentModel {
  String? patient;
  String? doctor;
  String? doctorName;
  String? dateTime;
  String? status;
  String? reason;
  int? duration;
  Prescription? prescription;
  VirtualAppointment? virtualAppointment;
  Invoice? invoice;
  String? sId;
  // List<dynamic>? patientFiles;
  String? createdAt;
  String? updatedAt;
  int? iV;

  CreateAppointmentModel(
      {this.patient,
      this.doctor,
      this.doctorName,
      this.dateTime,
      this.status,
      this.reason,
      this.duration,
      this.prescription,
      this.virtualAppointment,
      this.invoice,
      this.sId,
      this.createdAt,
      this.updatedAt,
      this.iV});

  CreateAppointmentModel.fromJson(Map<String, dynamic> json) {
    patient = json['patient'];
    doctor = json['doctor'];
    doctorName = json['doctorName'];
    dateTime = json['dateTime'];
    status = json['status'];
    reason = json['reason'];
    duration = json['duration'];
    prescription = json['prescription'] != null
        ? Prescription.fromJson(json['prescription'])
        : null;
    virtualAppointment = json['virtualAppointment'] != null
        ? VirtualAppointment.fromJson(json['virtualAppointment'])
        : null;
    invoice =
        json['procedure'] != null ? Invoice.fromJson(json['procedure']) : null;
    sId = json['_id'];

    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['patient'] = patient;
    data['doctor'] = doctor;
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
    data['_id'] = sId;

    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}

class Prescription {
  List<Null>? medications;
  String? prescribedDate;

  Prescription({this.medications, this.prescribedDate});

  Prescription.fromJson(Map<String, dynamic> json) {
    prescribedDate = json['prescribedDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

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
        items!.add(Items.fromJson(v));
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
