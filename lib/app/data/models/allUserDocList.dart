// To parse this JSON data, do
//
//     final allDocList = allDocListFromJson(jsonString);

import 'dart:convert';

List<AllDocList> allDocListFromJson(String str) =>
    List<AllDocList>.from(json.decode(str).map((x) => AllDocList.fromJson(x)));

String allDocListToJson(List<AllDocList> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AllDocList {
  int? id;
  String? document;
  String? documentName;
  DateTime? createdAt;
  User? user;

  AllDocList({
    this.id,
    this.document,
    this.documentName,
    this.createdAt,
    this.user,
  });

  factory AllDocList.fromJson(Map<String, dynamic> json) => AllDocList(
        id: json["id"],
        document: json["document"],
        documentName: json["document_name"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        user: json["user"] == null ? null : User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "document": document,
        "document_name": documentName,
        // "created_at":
        //     "${createdAt!.year.toString().padLeft(4, '0')}-${createdAt!.month.toString().padLeft(2, '0')}-${createdAt!.day.toString().padLeft(2, '0')}",
        "user": user?.toJson(),
      };
}

class User {
  int? id;
  String? password;
  DateTime? lastLogin;
  String? email;
  String? firstName;
  String? lastName;
  DateTime? dateJoined;
  String? phoneNumber;
  String? address;
  String? gender;
  String? status;
  dynamic profileImage;
  String? userType;
  bool? isStaff;
  bool? isActive;
  bool? isSuperuser;
  String? otp;
  int? manager;
  dynamic department;
  int? designation;
  List<dynamic>? groups;
  List<dynamic>? userPermissions;

  User({
    this.id,
    this.password,
    this.lastLogin,
    this.email,
    this.firstName,
    this.lastName,
    this.dateJoined,
    this.phoneNumber,
    this.address,
    this.gender,
    this.status,
    this.profileImage,
    this.userType,
    this.isStaff,
    this.isActive,
    this.isSuperuser,
    this.otp,
    this.manager,
    this.department,
    this.designation,
    this.groups,
    this.userPermissions,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        password: json["password"],
        lastLogin: json["last_login"] == null
            ? null
            : DateTime.parse(json["last_login"]),
        email: json["email"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        dateJoined: json["date_joined"] == null
            ? null
            : DateTime.parse(json["date_joined"]),
        phoneNumber: json["phone_number"],
        address: json["address"],
        gender: json["gender"],
        status: json["status"],
        profileImage: json["profile_image"],
        userType: json["user_type"],
        isStaff: json["is_staff"],
        isActive: json["is_active"],
        isSuperuser: json["is_superuser"],
        otp: json["otp"],
        manager: json["manager"],
        department: json["department"],
        designation: json["designation"],
        groups: json["groups"] == null
            ? []
            : List<dynamic>.from(json["groups"]!.map((x) => x)),
        userPermissions: json["user_permissions"] == null
            ? []
            : List<dynamic>.from(json["user_permissions"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "password": password,
        "last_login": lastLogin?.toIso8601String(),
        "email": email,
        "first_name": firstName,
        "last_name": lastName,
        "date_joined": dateJoined?.toIso8601String(),
        "phone_number": phoneNumber,
        "address": address,
        "gender": gender,
        "status": status,
        "profile_image": profileImage,
        "user_type": userType,
        "is_staff": isStaff,
        "is_active": isActive,
        "is_superuser": isSuperuser,
        "otp": otp,
        "manager": manager,
        "department": department,
        "designation": designation,
        "groups":
            groups == null ? [] : List<dynamic>.from(groups!.map((x) => x)),
        "user_permissions": userPermissions == null
            ? []
            : List<dynamic>.from(userPermissions!.map((x) => x)),
      };
}
