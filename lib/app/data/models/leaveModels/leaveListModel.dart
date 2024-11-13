// To parse this JSON data, do
//
//     final leaveTypeModel = leaveTypeModelFromJson(jsonString);

import 'dart:convert';

List<LeaveListModel> leaveTypeModelFromJson(String str) =>
    List<LeaveListModel>.from(
        json.decode(str).map((x) => LeaveListModel.fromJson(x)));

String leaveTypeModelToJson(List<LeaveListModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class LeaveListModel {
  int? id;
  String? title;
  String? description;
  String? fromDate;
  String? toDate;
  String? status;
  LeaveType? leaveType;
  String? attachment;
  CreatedBy? createdBy;
  String? created_date;

  LeaveListModel(
      {this.id,
      this.title,
      this.description,
      this.fromDate,
      this.toDate,
      this.status,
      this.leaveType,
      this.attachment,
      this.createdBy,
      this.created_date});

  factory LeaveListModel.fromJson(Map<String, dynamic> json) => LeaveListModel(
        id: json["id"],
        title: json["title"]!,
        description: json["description"]!,
        fromDate: json["from_date"],
        toDate: json["to_date"] == null
            ? "2023-07-04T15:32:01.593995Z"
            : json["to_date"].toString(),
        status: json["status"],
        leaveType: json["leave_type"] == null
            ? LeaveType(id: 0, name: "Not Found")
            : LeaveType.fromJson(json["leave_type"]),
        attachment: json["attachment"],
        created_date: json["created_date"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "from_date": fromDate,
        "to_date": toDate,
        "status": status,
        "leave_type": leaveType?.toJson(),
        "attachment": attachment,
        "created_date": created_date,
      };
}

class CreatedBy {
  int? id;

  String? email;
  String? firstName;
  String? lastName;

  String? phoneNumber;
  String? address;
  String? gender;
  String? status;
  String? profileImage;
  String? userType;

  CreatedBy({
    this.id,
    this.email,
    this.firstName,
    this.lastName,
    this.phoneNumber,
    this.address,
    this.gender,
    this.status,
    this.profileImage,
    this.userType,
  });

  factory CreatedBy.fromJson(Map<String, dynamic> json) => CreatedBy(
        id: json["id"],
        email: json["email"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        phoneNumber: json["phone_number"],
        address: json["address"],
        gender: json["gender"],
        status: json["status"],
        profileImage: json["profile_image"],
        userType: json["user_type"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "first_name": firstName,
        "last_name": lastName,
        "phone_number": phoneNumber,
        "address": address,
        "gender": gender,
        "status": status,
        "profile_image": profileImage,
        "user_type": userType,
      };
}

class LeaveType {
  int? id;
  String? name;

  LeaveType({
    this.id,
    this.name,
  });

  factory LeaveType.fromJson(Map<String, dynamic> json) => LeaveType(
        id: json["id"],
        name: json["name"]!,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
