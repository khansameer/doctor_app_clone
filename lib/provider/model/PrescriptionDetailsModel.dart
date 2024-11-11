class PrescriptionDetailsModel {
  List<Medications>? medications;
  int? total;
  int? pages;
  int? currentPage;

  PrescriptionDetailsModel(
      {this.medications, this.total, this.pages, this.currentPage});

  PrescriptionDetailsModel.fromJson(Map<String, dynamic> json) {
    if (json['medications'] != null) {
      medications = <Medications>[];
      json['medications'].forEach((v) {
        medications!.add(Medications.fromJson(v));
      });
    }
    total = json['total'];
    pages = json['pages'];
    currentPage = json['currentPage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (medications != null) {
      data['medications'] = medications!.map((v) => v.toJson()).toList();
    }
    data['total'] = total;
    data['pages'] = pages;
    data['currentPage'] = currentPage;
    return data;
  }
}

class Medications {
  Frequency? frequency;
  Duration? duration;
  String? sId;
  String? doctor;
  String? name;
  String? instructions;
  bool? isCommon;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Medications(
      {this.frequency,
      this.duration,
      this.sId,
      this.doctor,
      this.name,
      this.instructions,
      this.isCommon,
      this.createdAt,
      this.updatedAt,
      this.iV});

  Medications.fromJson(Map<String, dynamic> json) {
    frequency = json['frequency'] != null
        ? Frequency.fromJson(json['frequency'])
        : null;
    duration =
        json['duration'] != null ? Duration.fromJson(json['duration']) : null;
    sId = json['_id'];
    doctor = json['doctor'];
    name = json['name'];
    instructions = json['instructions'];
    isCommon = json['isCommon'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (frequency != null) {
      data['frequency'] = frequency!.toJson();
    }
    if (duration != null) {
      data['duration'] = duration!.toJson();
    }
    data['_id'] = sId;
    data['doctor'] = doctor;
    data['name'] = name;
    data['instructions'] = instructions;
    data['isCommon'] = isCommon;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}

class Frequency {
  int? timesPerDay;
  List<String>? whenToTake;

  Frequency({this.timesPerDay, this.whenToTake});

  Frequency.fromJson(Map<String, dynamic> json) {
    timesPerDay = json['timesPerDay'];
    whenToTake = json['whenToTake'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['timesPerDay'] = timesPerDay;
    data['whenToTake'] = whenToTake;
    return data;
  }
}

class Duration {
  int? value;
  String? unit;

  Duration({this.value, this.unit});

  Duration.fromJson(Map<String, dynamic> json) {
    value = json['value'];
    unit = json['unit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['value'] = value;
    data['unit'] = unit;
    return data;
  }
}
