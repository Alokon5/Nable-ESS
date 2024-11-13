import 'dart:convert';

UserDetailsModel userDetailsModelFromJson(String str) =>
    UserDetailsModel.fromJson(json.decode(str));

String userDetailsModelToJson(UserDetailsModel data) =>
    json.encode(data.toJson());

class UserDetailsModel {
  User? user;
  List<Video>? video;
  List<CheckIn>? checkIn;
  List<CheckOut>? checkOut;
  List<Document>? documents;
  List<LateEary>? lateEary;

  UserDetailsModel(
      {this.user,
      this.video,
      this.checkIn,
      this.checkOut,
      this.documents,
      this.lateEary});

  factory UserDetailsModel.fromJson(Map<String, dynamic> json) =>
      UserDetailsModel(
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        video: json["video"] == null
            ? []
            : List<Video>.from(json["video"]!.map((x) => Video.fromJson(x))),
        checkIn: json["check_in"] == null
            ? []
            : List<CheckIn>.from(
                json["check_in"]!.map((x) => CheckIn.fromJson(x))),
        checkOut: json["check_out"] == null
            ? []
            : List<CheckOut>.from(
                json["check_out"]!.map((x) => CheckOut.fromJson(x))),
        documents: json["document"] == null
            ? []
            : List<Document>.from(
                json["document"]!.map((x) => Document.fromJson(x))),
        lateEary: json["lateEary"] == null
            ? []
            : List<LateEary>.from(
                json["lateEary"]!.map((x) => LateEary.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "user": user?.toJson(),
        "video": video == null
            ? []
            : List<dynamic>.from(video!.map((x) => x.toJson())),
        "check_in": checkIn == null
            ? []
            : List<dynamic>.from(checkIn!.map((x) => x.toJson())),
        "check_out": checkOut == null
            ? []
            : List<dynamic>.from(checkOut!.map((x) => x.toJson())),
        "document": documents == null
            ? []
            : List<dynamic>.from(documents!.map((x) => x.toJson())),
        "lateEary": lateEary == null
            ? []
            : List<dynamic>.from(lateEary!.map((x) => x.toJson())),
      };
}

class CheckIn {
  int? id;
  String? checkIn;
  String? createdAt;
  int? createdBy;
  String? punctuality;

  CheckIn({
    this.id,
    this.checkIn,
    this.createdAt,
    this.createdBy,
    this.punctuality,
  });

  factory CheckIn.fromJson(Map<String, dynamic> json) => CheckIn(
        id: json["id"],
        checkIn: json["check_in"]!,
        createdAt: json["created_at"],
        createdBy: json["created_by"],
        punctuality: json["punctuality"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "check_in": checkIn,
        "created_at": createdAt,
        "created_by": createdBy,
        "punctuality": punctuality,
      };
}

class Document {
  int? id;
  String? document;
  String? createdAt;
  int? userId;
  String? document_name;

  Document({
    this.id,
    this.document,
    this.createdAt,
    this.userId,
    this.document_name,
  });

  factory Document.fromJson(Map<String, dynamic> json) => Document(
        id: json["id"],
        document: json["document"]!,
        createdAt: json["created_at"],
        userId: json["user"],
        document_name: json["document_name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "document": document,
        "created_at": createdAt,
        "user": userId,
        "document_name": document_name,
      };
}

class CheckOut {
  int? id;
  String? createdAt;
  int? createdBy;
  String? checkOut;
  String? punctuality;

  CheckOut({
    this.id,
    this.createdAt,
    this.createdBy,
    this.checkOut,
    this.punctuality,
  });

  factory CheckOut.fromJson(Map<String, dynamic> json) => CheckOut(
        id: json["id"],
        createdAt: json["created_at"],
        createdBy: json["created_by"],
        checkOut: json["check_out"]!,
        punctuality: json["punctuality"]!,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "created_at": createdAt,
        "created_by": createdBy,
        "check_out": checkOut,
        "punctuality": punctuality,
      };
}

class User {
  int? id;
  String? firstName;
  String? lastName;
  String? email;
  String? gender;
  String? phoneNumber;
  String? profileImage;
  int? manager;
  String? joinedDate;
  int? designation;
  String? address;
  String? userType;
  String? status;

  User({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.phoneNumber,
    this.profileImage,
    this.manager,
    this.joinedDate,
    this.address,
    this.userType,
    this.gender,
    this.designation,
    this.status,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        email: json["email"],
        phoneNumber: json["phone_number"],
        profileImage: json["profile_image"],
        manager: json["manager"],
        designation: json["designation"],
        joinedDate: json["date_joined"],
        address: json["address"],
        gender: json["gender"],
        userType: json["user_type"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "phone_number": phoneNumber,
        "profile_image": profileImage,
        "manager": manager,
        "designation": designation,
        "date_joined": joinedDate,
        "address": address,
        "gender": gender,
        "user_type": userType,
        "status": status,
      };
}

class Video {
  int? id;
  String? video;
  String? thumbnail;
  String? title;
  String? description;
  String? createdAt;
  int? user;

  Video({
    this.id,
    this.video,
    this.thumbnail,
    this.title,
    this.description,
    this.createdAt,
    this.user,
  });

  factory Video.fromJson(Map<String, dynamic> json) => Video(
        id: json["id"],
        video: json["video"],
        thumbnail: json["thumbnail"],
        title: json["title"],
        description: json["description"],
        createdAt: json["created_at"],
        user: json["user"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "video": video,
        "thumbnail": thumbnail,
        "title": title,
        "description": description,
        "created_at": createdAt,
        "user": user,
      };
}

class LateEary {
  int? id;
  String? date;
  String? time;
  String? createdAt;
  String? description;
  int? user;

  LateEary({
    this.id,
    this.date,
    this.time,
    this.createdAt,
    this.description,
    this.user,
  });

  factory LateEary.fromJson(Map<String, dynamic> json) => LateEary(
        id: json["id"],
        date: json["date"],
        time: json["time"],
        createdAt: json["created_at"],
        description: json["description"],
        user: json["user"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "date": date,
        "time": time,
        "created_at": createdAt,
        "description": description,
        "user": user,
      };
}
