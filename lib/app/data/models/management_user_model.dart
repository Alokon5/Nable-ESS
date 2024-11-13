import 'dart:convert';

ManagemenetUserModel managemenetUserModelFromJson(String str) =>
    ManagemenetUserModel.fromJson(json.decode(str));

String managemenetUserModelToJson(ManagemenetUserModel data) =>
    json.encode(data.toJson());

class ManagemenetUserModel {
  String? name;
  String? email;
  String? uid;
  String? photoUrl;
  String? phoneNumber;
  bool? emailVerified;
  String? role;

  ManagemenetUserModel({
    this.name,
    this.email,
    this.uid,
    this.photoUrl,
    this.phoneNumber,
    this.emailVerified,
    this.role,
  });

  ManagemenetUserModel copyWith({
    String? name,
    String? email,
    String? uid,
    String? photoUrl,
    String? phoneNumber,
    bool? emailVerified,
    String? role,
  }) =>
      ManagemenetUserModel(
        name: name ?? this.name,
        email: email ?? this.email,
        uid: uid ?? this.uid,
        photoUrl: photoUrl ?? this.photoUrl,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        emailVerified: emailVerified ?? this.emailVerified,
        role: role ?? this.role,
      );

  factory ManagemenetUserModel.fromJson(Map<String, dynamic> json) =>
      ManagemenetUserModel(
        name: json["name"],
        email: json["email"],
        uid: json["uid"],
        photoUrl: json["photoUrl"],
        phoneNumber: json["phoneNumber"],
        emailVerified: json["emailVerified"],
        role: json["role"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "uid": uid,
        "photoUrl": photoUrl,
        "phoneNumber": phoneNumber,
        "emailVerified": emailVerified,
        "role": role,
      };
}
