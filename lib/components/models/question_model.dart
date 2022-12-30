import 'configuration2_model.dart';

class Question {
  Question({
    this.id,
    this.title,
    this.text,
    this.description,
    this.chapter,
    this.productDetails,
    this.configuration2,
    this.next,
    this.back,
  });

  String? id;
  String? title;
  String? text;
  String? description;
  dynamic? chapter;
  String? productDetails;
  Configuration2? configuration2;
  String? next;
  String? back;

  factory Question.fromJson(Map<String, dynamic> json) => Question(
    id: json["id"],
    title: json["title"],
    text: json["text"],
    description: json["description"],
    chapter: json["chapter"],
    productDetails: json["productDetails"],
    configuration2: Configuration2.fromJson(json["configuration"]),
    next: json["next"],
    back: json["back"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "text": text,
    "description": description,
    "chapter": chapter,
    "productDetails": productDetails,
    "configuration": configuration2?.toJson(),
    "next": next,
    "back": back,
  };
}