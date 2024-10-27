class ProcedureModel {
  String? sId;
  String? doctor;
  String? name;
  int? cost;
  String? description;
  int? iV;

  ProcedureModel(
      {this.sId, this.doctor, this.name, this.cost, this.description, this.iV});

  ProcedureModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    doctor = json['doctor'];
    name = json['name'];
    cost = json['cost'];
    description = json['description'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['doctor'] = doctor;
    data['name'] = name;
    data['cost'] = cost;
    data['description'] = description;
    data['__v'] = iV;
    return data;
  }
}
