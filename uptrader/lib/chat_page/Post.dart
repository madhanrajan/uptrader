// To parse this JSON data, do
//
//     final post = postFromJson(jsonString);

import 'dart:convert';

Post postFromJson(String str) => Post.fromJson(json.decode(str));
List<Post> listPostFromJson(String str) =>
    List<Post>.from(json.decode(str).map((x) => Post.fromJson(x)));

String postToJson(Post data) => json.encode(data.toJson());

class Post {
  Post({
    required this.text,
    required this.group,
    this.id,
    this.numberOfLikes,
  });

  String text;
  String group;
  String? id;
  int? numberOfLikes;

  factory Post.fromJson(Map<String, dynamic> json) => Post(
      text: json["text"],
      group: "${json["group"]}",
      id: "${json["id"]}",
      numberOfLikes: json["number_of_likes"]);

  Map<String, String> toJson() => {
        "text": text,
        "group": group,
      };
}
