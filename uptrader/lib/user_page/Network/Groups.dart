// To parse this JSON data, do
//
//     final group = groupFromJson(jsonString);

import 'dart:convert';

List<Group> groupFromJson(String str) => List<Group>.from(json.decode(str).map((x) => Group.fromJson(x)));

String groupToJson(List<Group> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Group {
  Group({
    required this.title,
    required this.id,
  });

  String title;
  int id;

  factory Group.fromJson(Map<String, dynamic> json) => Group(
    title: json["title"],
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "id": id,
  };
}
