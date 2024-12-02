// To parse this JSON data, do
//
//     final createUser = createUserFromJson(jsonString);

import 'dart:convert';

// Parsing and Serialization
CreateUser createUserFromJson(String str) => CreateUser.fromJson(json.decode(str));
String createUserToJson(CreateUser data) => json.encode(data.toJson());

// Model Class
class CreateUser {
  String? firstName;
  String? lastName;
  String? email;
  String? phoneNumber;
  String? phoneNumber2;
  String? dob;
  String? fatherName;
  String? fatherHusbandMobile;
  String? joiningDate;
  String? address;
  String? homeAddress;
  String? gender;
  String? bloodGroup;
  String? maritalStatus;
  String? profileImage;
  String? manager;
  String? department;
  String? designation;
  String? userType;
  String? longitude;
  String? latitude;
  String? weekOff;
  String? shiftTime;
  String? password;

  CreateUser({
    this.firstName,
    this.lastName,
    this.email,
    this.phoneNumber,
    this.phoneNumber2,
    this.dob,
    this.fatherName,
    this.fatherHusbandMobile,
    this.joiningDate,
    this.address,
    this.homeAddress,
    this.gender,
    this.bloodGroup,
    this.maritalStatus,
    this.profileImage,
    this.manager,
    this.department,
    this.designation,
    this.userType,
    this.longitude,
    this.latitude,
    this.weekOff,
    this.shiftTime,
     this.password,
  });

  // JSON Deserialization
  factory CreateUser.fromJson(Map<String, dynamic> json) => CreateUser(
        firstName: json["first_name"],
        lastName: json["last_name"],
        email: json["email"],
        phoneNumber: json["phone_number"],
        phoneNumber2: json["phone_number2"],
        dob: json["dob"],
        fatherName: json["father_husband_name"],
        fatherHusbandMobile: json["father_husband_mobile"],
        joiningDate: json["joining_date"],
        address: json["address"],
        homeAddress: json["home_address"],
        gender: json["gender"],
        bloodGroup: json["blood_group"],
        maritalStatus: json["marital_status"],
        profileImage: json["profile_image"],
        manager: json["manager"],
        department: json["department"],
        designation: json["designation"],
        userType: json["user_type"],
        longitude: json["longitude"],
        latitude: json["latitude"],
        weekOff: json["week_off"],
        shiftTime: json["shift_time"],
        password: json["password"],
      );

  // JSON Serialization
  Map<String, dynamic> toJson() => {
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "phone_number": phoneNumber,
        "phone_number2": phoneNumber2,
        "dob": dob,
        "father_husband_name": fatherName,
        "father_husband_mobile": fatherHusbandMobile,
        "joining_date": joiningDate,
        "address": address,
        "home_address": homeAddress,
        "gender": gender,
        "blood_group": bloodGroup,
        "marital_status": maritalStatus,
        "profile_image": profileImage,
        "manager": manager,
        "department": department,
        "designation": designation,
        "user_type": userType,
        "longitude": longitude,
        "latitude": latitude,
        "week_off": weekOff,
        "shift_time": shiftTime,
         "password": password,
      };
}
