// To parse this JSON data, do
//
//     final allVideosModel = allVideosModelFromJson(jsonString);

import 'dart:convert';

AllVideosModel allVideosModelFromJson(String str) =>
    AllVideosModel.fromJson(json.decode(str));

String allVideosModelToJson(AllVideosModel data) => json.encode(data.toJson());

class AllVideosModel {
  List<AllVideosData>? data;
  int? status;

  AllVideosModel({
    this.data,
    this.status,
  });

  factory AllVideosModel.fromJson(Map<String, dynamic> json) => AllVideosModel(
        data: json["data"] == null
            ? []
            : List<AllVideosData>.from(
                json["data"]!.map((x) => AllVideosData.fromJson(x))),
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "status": status,
      };
}

class AllVideosData {
  int? id;
  String? video;
  String? thumbnail;
  String? title;
  String? description;
  String? createdAt;
  int? user;

  AllVideosData({
    this.id,
    this.video,
    this.thumbnail,
    this.title,
    this.description,
    this.createdAt,
    this.user,
  });

  factory AllVideosData.fromJson(Map<String, dynamic> json) => AllVideosData(
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
