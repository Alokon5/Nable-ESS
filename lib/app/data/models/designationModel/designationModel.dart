import 'dart:convert';

List<DesignationModel> leaveTypeModelFromJson(String str) =>
    List<DesignationModel>.from(
        json.decode(str).map((x) => DesignationModel.fromJson(x)));

String leaveTypeModelToJson(List<DesignationModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DesignationModel {
  int? id;
  String? name;

  DesignationModel({
    this.id,
    this.name,
  });

  factory DesignationModel.fromJson(Map<String, dynamic> json) => DesignationModel(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
