// To parse this JSON data, do
//
//     final staffListModel = staffListModelFromJson(jsonString);

import 'dart:convert';

StaffListModel staffListModelFromJson(String str) => StaffListModel.fromJson(json.decode(str));

String staffListModelToJson(StaffListModel data) => json.encode(data.toJson());

class StaffListModel {
    List<Staff>? staffs;
    int? status;

    StaffListModel({
        this.staffs,
        this.status,
    });

    factory StaffListModel.fromJson(Map<String, dynamic> json) => StaffListModel(
        staffs: json["staffs"] == null ? [] : List<Staff>.from(json["staffs"]!.map((x) => Staff.fromJson(x))),
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "staffs": staffs == null ? [] : List<dynamic>.from(staffs!.map((x) => x.toJson())),
        "status": status,
    };
}

class Staff {
    int? id;
    String? firstName;
    String? lastName;
    String? email;
    String? phoneNumber;
    String? profileImage;
    int? manager;
    String? address;
    String? status;
    String? userType;

    Staff({
        this.id,
        this.firstName,
        this.lastName,
        this.email,
        this.phoneNumber,
        this.profileImage,
        this.manager,
        this.address,
        this.status,
        this.userType,
    });

    factory Staff.fromJson(Map<String, dynamic> json) => Staff(
        id: json["id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        email: json["email"],
        phoneNumber: json["phone_number"],
        profileImage: json["profile_image"],
        manager: json["manager"],
        address: json["address"],
        status: json["status"],
        userType: json["user_type"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "phone_number": phoneNumber,
        "profile_image": profileImage,
        "manager": manager,
        "address": address,
        "status": status,
        "user_type": userType,
    };
}
