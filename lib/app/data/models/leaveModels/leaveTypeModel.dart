import 'dart:convert';

List<LeaveTypeModel> leaveTypeModelFromJson(String str) =>
    List<LeaveTypeModel>.from(
        json.decode(str).map((x) => LeaveTypeModel.fromJson(x)));

String leaveTypeModelToJson(List<LeaveTypeModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class LeaveTypeModel {
  int? id;
  String? name;

  LeaveTypeModel({
    this.id,
    this.name,
  });

  factory LeaveTypeModel.fromJson(Map<String, dynamic> json) => LeaveTypeModel(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
