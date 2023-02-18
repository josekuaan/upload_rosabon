// To parse this JSON data, do
//
//     final replyCahtrequest = replyCahtrequestFromJson(jsonString);

import 'dart:convert';

ReplyCahtrequest replyCahtrequestFromJson(String str) =>
    ReplyCahtrequest.fromJson(json.decode(str));

String replyCahtrequestToJson(ReplyCahtrequest data) =>
    json.encode(data.toJson());

class ReplyCahtrequest {
  ReplyCahtrequest({
    this.content,
    this.images,
    this.ticketId,
    this.title,
  });

  String? content;
  List<Image>? images;
  int? ticketId;
  String? title;

  ReplyCahtrequest.fromJson(Map<String, dynamic> json) {
    if (json["content"] != null) {
      content = json["content"];
    }
    images = json["images"] != null
        ? List<Image>.from(json["images"].map((x) => Image.fromJson(x)))
        : null;
    ticketId = json["ticketId"];
    title = json["title"];
  }

  Map<String, dynamic> toJson() => {
        "content": content,
        "images": List<dynamic>.from(images!.map((x) => x.toJson())),
        "ticketId": ticketId,
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
