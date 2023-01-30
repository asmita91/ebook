// To parse this JSON data, do
//
//     final bookModel = bookModelFromJson(jsonString);

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

BookModel bookModelFromJson(String str) => BookModel.fromJson(json.decode(str));

String bookModelToJson(BookModel data) => json.encode(data.toJson());

class BookModel {
  BookModel({
    required this.author,
    required this.bookurl,
    required this.name,
    required this.description,
    required this.thumbnailurl,
  });

  String author;
  String bookurl;
  String name;
  String description;
  String thumbnailurl;

  factory BookModel.fromJson(Map<String, dynamic> json) => BookModel(
        author: json["author"],
        bookurl: json["bookurl"],
        name: json["name"],
        description: json["description"],
        thumbnailurl: json["thumbnailurl"],
      );
  factory BookModel.fromFirebaseSnapshot(
          DocumentSnapshot<Map<String, dynamic>> json) =>
      BookModel(
        author: json["author"],
        bookurl: json["bookurl"],
        name: json["name"],
        description: json["description"],
        thumbnailurl: json["thumbnailurl"],
      );

  Map<String, dynamic> toJson() => {
        "author": author,
        "bookurl": bookurl,
        "name": name,
        "description": description,
        "thumbnailurl": thumbnailurl,
      };
}
