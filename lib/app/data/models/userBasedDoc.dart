// To parse this JSON data, do
//
//     final allDocList = allDocListFromJson(jsonString);

import 'dart:convert';

List<UserBasedDocModel> allDocListFromJson(String str) =>
    List<UserBasedDocModel>.from(
        json.decode(str).map((x) => UserBasedDocModel.fromJson(x)));

String allDocListToJson(List<UserBasedDocModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UserBasedDocModel {
  int? id;
  String? userFirstName;
  String? userLastName;
  String? profileImage;
  String? createdAt;
  List<DocList>? docList;

  UserBasedDocModel({
    this.id,
    this.userFirstName,
    this.userLastName,
    this.profileImage,
    this.createdAt,
    this.docList,
  });

  factory UserBasedDocModel.fromJson(Map<String, dynamic> json) =>
      UserBasedDocModel(
          id: json["id"],
          userFirstName: json["first_name"],
          userLastName: json["document_name"],
          createdAt: json["createdAt"],
          docList: json['docList'],
          profileImage: json["profile_image"]);

  Map<String, dynamic> toJson() => {
        "id": id,
        "first_name": userFirstName,
        "document_name": userLastName,
        "createdAt": createdAt,
        "docList": docList,
        "profile_image": profileImage
        // "created_at":
        //     "${createdAt!.year.toString().padLeft(4, '0')}-${createdAt!.month.toString().padLeft(2, '0')}-${createdAt!.day.toString().padLeft(2, '0')}",
      };
}

class DocList {
  int? id;
  String? docName;
  String? documentUrl;
  String? createdAt;
  String? lastName;

  DocList(
      {this.id, this.docName, this.documentUrl, this.createdAt, this.lastName});

  factory DocList.fromJson(Map<String, dynamic> json) => DocList(
        id: json["id"],
        docName: json["document_name"],
        documentUrl: json["document"],
        createdAt: json["created_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "document_name": docName,
        "document": documentUrl,
        "created_at": createdAt,
      };
}
