// To parse this JSON data, do
//
//     final createUser = createUserFromJson(jsonString);

import 'dart:convert';

CreateUser createUserFromJson(String str) => CreateUser.fromJson(json.decode(str));

String createUserToJson(CreateUser data) => json.encode(data.toJson());

class CreateUser {
    String? firstName;
    String? lastName;
    String? email;
    String? phoneNumber;
    String? profileImage;
    String? manager;
    String? address;
    String? userType;
    String? password;
    String? designation;
    String? gender;

    CreateUser({
        this.firstName,
        this.lastName,
        this.email,
        this.phoneNumber,
        this.profileImage,
        this.manager,
        this.address,
        this.userType,
        this.password,
        this.gender,
        this.designation
    });

    factory CreateUser.fromJson(Map<String, dynamic> json) => CreateUser(
        firstName: json["first_name"],
        lastName: json["last_name"],
        email: json["email"],
        phoneNumber: json["phone_number"],
        profileImage: json["profile_image"],
        manager: json["manager"],
        address: json["address"],
        userType: json["user_type"],
        designation: json["designation"],
        password: json["password"],
        gender: json["gender"],
    );

    Map<String, dynamic> toJson() => {
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "phone_number": phoneNumber,
        "profile_image": profileImage,
        "manager": manager,
        "address": address,
        "user_type": userType,
        "designation": designation,
        "password": password,
        "gender": gender,
    };
}
