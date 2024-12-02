import 'dart:convert';

List<DepartModel> leaveTypeModelFromJson(String str) =>
    List<DepartModel>.from(
        json.decode(str).map((x) => DepartModel.fromJson(x)));

String leaveTypeModelToJson(List<DepartModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DepartModel {
  int? id;
  String? name;

  DepartModel({
    this.id,
    this.name,
  });

  factory DepartModel.fromJson(Map<String, dynamic> json) => DepartModel(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
