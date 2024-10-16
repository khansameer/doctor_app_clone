class SpecializationsModel {
  String? sId;
  String? name;
  String? status;
  int? iV;

  SpecializationsModel({this.sId, this.name, this.status, this.iV});

  SpecializationsModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    status = json['status'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['name'] = name;
    data['status'] = status;
    data['__v'] = iV;
    return data;
  }
}
