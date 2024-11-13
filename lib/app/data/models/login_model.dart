// To parse this JSON data, do
//
//     final loginModel = loginModelFromJson(jsonString);

import 'dart:convert';

LoginModel loginModelFromJson(String str) =>
    LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  Data? data;
  String? token;

  LoginModel({
    this.data,
    this.token,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
        "token": token,
      };
}

class Data {
  int? id;
  String? firstName;
  String? lastName;
  String? email;
  String? phoneNumber;
  String? profileImage;
  int? manager;
  String? address;
  String? userType;

  Data({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.phoneNumber,
    this.profileImage,
    this.manager,
    this.address,
    this.userType,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        email: json["email"],
        phoneNumber: json["phone_number"],
        profileImage: json["profile_image"],
        manager: json["manager"],
        address: json["address"],
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
        "user_type": userType,
      };
}
