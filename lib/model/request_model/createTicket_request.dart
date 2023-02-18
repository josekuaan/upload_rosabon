// To parse this JSON data, do
//
//     final createTicketrequest = createTicketrequestFromJson(jsonString);

import 'dart:convert';

CreateTicketrequest createTicketrequestFromJson(String str) =>
    CreateTicketrequest.fromJson(json.decode(str));

String createTicketrequestToJson(CreateTicketrequest data) =>
    json.encode(data.toJson());

class CreateTicketrequest {
  CreateTicketrequest({
    this.categoryId,
    this.content,
    this.images,
    this.title,
    this.platform,
  });
  String? platform;
  int? categoryId;
  String? content;
  List<Image>? images;
  String? title;

  factory CreateTicketrequest.fromJson(Map<String, dynamic> json) =>
      CreateTicketrequest(
        platform: json["platform"],
        categoryId: json["categoryId"],
        content: json["content"],
        images: json["images"] == null
            ? null
            : List<Image>.from(json["images"].map((x) => Image.fromJson(x))),
        title: json["title"],
      );

  Map<String, dynamic> toJson() => {
        "platform": platform,
        "categoryId": categoryId,
        "content": content,
        "images": images == null
            ? null
            : List<dynamic>.from(images!.map((x) => x.toJson())),
        "title": title,
      };
}

class Image {
  Image({
    this.encodedUpload,
    this.name,
  });

  String? encodedUpload;
  String? name;

  factory Image.fromJson(Map<String, dynamic> json) => Image(
        encodedUpload: json["encodedUpload"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "encodedUpload": encodedUpload,
        "name": name,
      };
}
