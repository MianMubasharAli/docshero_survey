import 'package:docshero/components/models/question_model.dart';

import 'configuration2_model.dart';

class ValueElement2 {
  ValueElement2({
    this.id,
    this.title,
    this.text,
    this.description,
    this.chapter,
    this.productDetails,
    this.configuration,
    this.next,
    this.back,
    this.questions,
  });

  var id;
  String? title;
  String? text;
  String? description;
  dynamic? chapter;
  String? productDetails;
  Configuration2? configuration;
  String? next;
  String? back;
  List<Question>? questions;

  factory ValueElement2.fromJson(Map<String, dynamic> json) => ValueElement2(
    id: json["id"],
    title: json["title"],
    text: json["text"] == null ? null : json["text"],
    description: json["description"] == null ? null : json["description"],
    chapter: json["chapter"],
    productDetails: json["productDetails"] == null ? null : json["productDetails"],
    configuration: json["configuration"] == null ? null : Configuration2.fromJson(json["configuration"]),
    next: json["next"] == null ? null : json["next"],
    back: json["back"] == null ? null : json["back"],
    questions: json["questions"] == null ? null : List<Question>.from(json["questions"].map((x) => Question.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "text": text == null ? null : text,
    "description": description == null ? null : description,
    "chapter": chapter,
    "productDetails": productDetails == null ? null : productDetails,
    "configuration": configuration == null ? null : configuration?.toJson(),
    "next": next == null ? null : next,
    "back": back == null ? null : back,
    "questions": questions == null ? null : List<dynamic>.from(questions!.map((x) => x.toJson())),
  };
}