// To parse this JSON data, do
//
//     final allEmployeesModel = allEmployeesModelFromJson(jsonString);

import 'dart:convert';

AllEmployeesModel allEmployeesModelFromJson(String str) => AllEmployeesModel.fromJson(json.decode(str));

String allEmployeesModelToJson(AllEmployeesModel data) => json.encode(data.toJson());

class AllEmployeesModel {
    List<Datum>? data;

    AllEmployeesModel({
        this.data,
    });

    factory AllEmployeesModel.fromJson(Map<String, dynamic> json) => AllEmployeesModel(
        data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class Datum {
    int? id;
    String? firstName;
    String? lastName;
    String? email;
    String? phoneNumber;
    String? profileImage;
    int? manager;
    String? address;
    String? userType;

    String? status;
    String? gender;

    Datum({
        this.id,
        this.firstName,
        this.lastName,
        this.email,
        this.phoneNumber,
        this.profileImage,
        this.manager,
        this.status,
        this.gender,
        this.address,
        this.userType,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        email: json["email"],
        phoneNumber: json["phone_number"],
        profileImage: json["profile_image"],
        manager: json["manager"],
        address: json["address"],
        userType: json["user_type"],

        status: json["status"],
        gender: json["gender"],
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
        "user_type": userType,
        "status": status,
        "gender": gender,
    };
}

