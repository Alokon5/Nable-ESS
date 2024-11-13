// To parse this JSON data, do
//
//     final requestedLeaveModel = requestedLeaveModelFromJson(jsonString);

import 'dart:convert';

RequestedLeaveModel requestedLeaveModelFromJson(String str) => RequestedLeaveModel.fromJson(json.decode(str));

String requestedLeaveModelToJson(RequestedLeaveModel data) => json.encode(data.toJson());

class RequestedLeaveModel {
    int? id;
    String? title;
    String? description;
    String? fromDate;
    String? toDate;
    String? status;
    bool? seen;
    LeaveType? leaveType;
    dynamic attachment;
    CreatedBy? createdBy;

    RequestedLeaveModel({
        this.id,
        this.title,
        this.description,
        this.fromDate,
        this.toDate,
        this.status,
        this.seen,
        this.leaveType,
        this.attachment,
        this.createdBy,
    });

    factory RequestedLeaveModel.fromJson(Map<String, dynamic> json) => RequestedLeaveModel(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        fromDate: json["from_date"] ,
        toDate: json["to_date"] ,
        seen: json["seen"] ,
        status: json["status"],
        leaveType: json["leave_type"] == null ? null : LeaveType.fromJson(json["leave_type"]),
        attachment: json["attachment"],
        createdBy: json["created_by"] == null ? null : CreatedBy.fromJson(json["created_by"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "from_date": fromDate!,
        "to_date": toDate,
        "status": status,
        "seen":seen,
        "leave_type": leaveType?.toJson(),
        "attachment": attachment,
        "created_by": createdBy?.toJson(),
    };
}

class CreatedBy {
    int? id;
    String? password;
    String? lastLogin;
    String? email;
    String? firstName;
    String? lastName;
    String? dateJoined;
    String? phoneNumber;
    String? address;
    String? gender;
    String? status;
    String? profileImage;
    String? userType;
    bool? isStaff;
    bool? isActive;
    bool? isSuperuser;
    int? manager;
    dynamic department;
    dynamic designation;
    List<dynamic>? groups;
    List<dynamic>? userPermissions;

    CreatedBy({
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
        this.manager,
        this.department,
        this.designation,
        this.groups,
        this.userPermissions,
    });

    factory CreatedBy.fromJson(Map<String, dynamic> json) => CreatedBy(
        id: json["id"],
        password: json["password"],
        lastLogin: json["last_login"],
        email: json["email"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        dateJoined: json["date_joined"] ,
        phoneNumber: json["phone_number"],
        address: json["address"],
        gender: json["gender"],
        status: json["status"],
        profileImage: json["profile_image"],
        userType: json["user_type"],
        isStaff: json["is_staff"],
        isActive: json["is_active"],
        isSuperuser: json["is_superuser"],
        manager: json["manager"],
        department: json["department"],
        designation: json["designation"],
        groups: json["groups"] == null ? [] : List<dynamic>.from(json["groups"]!.map((x) => x)),
        userPermissions: json["user_permissions"] == null ? [] : List<dynamic>.from(json["user_permissions"]!.map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "password": password,
        "last_login": lastLogin,
        "email": email,
        "first_name": firstName,
        "last_name": lastName,
        "date_joined": dateJoined,
        "phone_number": phoneNumber,
        "address": address,
        "gender": gender,
        "status": status,
        "profile_image": profileImage,
        "user_type": userType,
        "is_staff": isStaff,
        "is_active": isActive,
        "is_superuser": isSuperuser,
        "manager": manager,
        "department": department,
        "designation": designation,
        "groups": groups == null ? [] : List<dynamic>.from(groups!.map((x) => x)),
        "user_permissions": userPermissions == null ? [] : List<dynamic>.from(userPermissions!.map((x) => x)),
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
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
    };
}
