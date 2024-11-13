import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  String? uid;
  String? displayName;
  String? email;
  String? photoUrl;
  int? phoneNumber;
  String? token;

  String? lati;
  String? longi;

  bool? checkIn;

  int? id;

  String? role;
  String? createdAt;
  String? createdBy;
  String? firstName;
  String? lastName;
  String? designation;

  String? uploadedTime;
  String? joinedDate;
  String? videoPath;
  String? videoTitle;
  String? videoDescription;
  String? groupIdentifier;
  // String? videoThumbaile;
  // bool? emailVerified;

  UserModel(
      {this.uid,
      this.id,
      this.displayName,
      this.email,
      this.photoUrl,
      this.phoneNumber,
      // this.emailVerified,
      this.role,
      this.firstName,
      this.lastName,
      this.designation,
      this.createdAt,
      this.token,
      this.createdBy,
      this.uploadedTime,
      this.joinedDate,
      this.videoPath,
      this.videoTitle,
      this.videoDescription,
      this.groupIdentifier,
      //latiLongi
      this.lati,
      this.longi,
      this.checkIn});

  UserModel copyWith(
          {String? uid,
          int? id,
          String? displayName,
          String? email,
          String? firstName,
          String? lastName,
          String? designation,
          String? photoUrl,
          int? phoneNumber,
          String? role,
          String? createdAt,
          String? createdBy,
          String? joinedDate,
          String? uploadedTime,
          String? videoPath,
          String? videoTitle,
          String? videoDescription,
          String? groupIdentifier,
          String? token,
          //latiLongi
          String? lati,
          String? longi,
          bool? checkIn
          // bool? emailVerified,
          }) =>
      UserModel(
        uid: uid ?? this.uid,
        id: id ?? this.id,
        displayName: displayName ?? this.displayName,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        designation: designation ?? this.designation,
        email: email ?? this.email,
        photoUrl: photoUrl ?? this.photoUrl,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        role: role ?? this.role,
        token: token ?? this.token,
        createdAt: createdAt ?? this.createdAt,
        createdBy: createdBy ?? this.createdBy,
        uploadedTime: uploadedTime ?? this.uploadedTime,
        joinedDate: joinedDate ?? this.joinedDate,
        videoPath: videoPath ?? this.videoPath,
        videoTitle: videoTitle ?? this.videoTitle,
        videoDescription: videoDescription ?? this.videoDescription,
        groupIdentifier: groupIdentifier ?? this.groupIdentifier,

        lati: lati ?? this.lati,
        longi: longi ?? this.longi,
        checkIn: checkIn ?? this.checkIn,
        // // // emailVerified: emailVerified ?? this.emailVerified,
      );

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        uid: json['uid'],
        id: json["id"],
        displayName: json['displayName'],
        email: json['email'],
        photoUrl: json['photoUrl'],
        phoneNumber: json['phoneNuber'],
        designation: json['designation'],
        role: json['role'],
        firstName: json['firstName'],
        lastName: json['lastName'],

        createdAt: json['createdAt'],
        createdBy: json['createdBy'],
        uploadedTime: json['uploadedTime'],
        joinedDate: json['date_joined'],
        videoPath: json['videoPath'],
        videoTitle: json['videoTitle'],
        videoDescription: json['videoDescription'],
        groupIdentifier: json['groupIdentifier'],
        token: json['token'],
        lati: json['lati'],
        longi: json['longi'],

        checkIn: json['checkIn'],
        // emailVerified: json['emailVerfied'],
      );

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "id": id,
        "displayName": displayName,
        "email": email,
        "photoUrl": photoUrl,
        "phoneNumber": phoneNumber,
        "role": role,
        "token": token,
        "firstName": firstName,
        "lastName": lastName,
        "designation": designation,

        "createdAt": createdAt,
        "createdBy": createdBy,
        "uploadedTime": uploadedTime,
        "date_joined": joinedDate,
        "videoPath": videoPath,
        "videoTitle": videoTitle,
        "videoDescription": videoDescription,
        "groupIdentifier": groupIdentifier,
        "lati": lati,
        "longi": longi,
        "checkIn": checkIn,
        // "emailVerified": emailVerified,
      };
}
