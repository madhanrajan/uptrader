// To parse this JSON data, do
//
//     final paginatedPost = paginatedPostFromJson(jsonString);

import 'dart:convert';

PaginatedPost paginatedPostFromJson(String str) =>
    PaginatedPost.fromJson(json.decode(str));

String paginatedPostToJson(PaginatedPost data) => json.encode(data.toJson());

class PaginatedPost {
  PaginatedPost({
    required this.count,
    required this.next,
    required this.previous,
    required this.results,
  });

  int count;
  String? next;
  String? previous;
  List<Result> results;

  factory PaginatedPost.fromJson(Map<String, dynamic> json) => PaginatedPost(
        count: json["count"],
        next: json["next"],
        previous: json["previous"],
        results:
            List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "next": next,
        "previous": previous,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
      };
}

class Result {
  Result({
    required this.text,
    required this.group,
    required this.id,
    required this.numberOfLikes,
  });

  String text;
  int group;
  int id;
  int numberOfLikes;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        text: json["text"],
        group: json["group"],
        id: json["id"],
        numberOfLikes: json["number_of_likes"],
      );

  Map<String, dynamic> toJson() => {
        "text": text,
        "group": group,
        "id": id,
        "number_of_likes": numberOfLikes,
      };
}
