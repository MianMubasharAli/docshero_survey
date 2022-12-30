import 'layout2_model.dart';

class StylesConfiguration2 {
  StylesConfiguration2({
    this.stepsCardBgColor,
    this.stepsCardTextColor,
    this.stepsCardHeaderBgColor,
    this.stepsCardHeaderTextColor,
    this.questionDetailsCardBgColor,
    this.questionDetailsCardTextColor,
    this.cartCardBgColor,
    this.cartCardTextColor,
    this.cartCardHeaderBgColor,
    this.cartCardHeaderTextColor,
    this.productDetailsCardBgColor,
    this.productDetailsCardTextColor,
    this.productDetailsHeaderBgColor,
    this.productDetailsHeaderTextColor,
    this.layout,
  });

  String? stepsCardBgColor;
  String? stepsCardTextColor;
  String? stepsCardHeaderBgColor;
  String? stepsCardHeaderTextColor;
  String? questionDetailsCardBgColor;
  String? questionDetailsCardTextColor;
  String? cartCardBgColor;
  String? cartCardTextColor;
  String? cartCardHeaderBgColor;
  String? cartCardHeaderTextColor;
  String? productDetailsCardBgColor;
  String? productDetailsCardTextColor;
  String? productDetailsHeaderBgColor;
  String? productDetailsHeaderTextColor;
  Layout2? layout;

  factory StylesConfiguration2.fromJson(Map<String, dynamic> json) => StylesConfiguration2(
    stepsCardBgColor: json["stepsCardBgColor"],
    stepsCardTextColor: json["stepsCardTextColor"],
    stepsCardHeaderBgColor: json["stepsCardHeaderBgColor"],
    stepsCardHeaderTextColor: json["stepsCardHeaderTextColor"],
    questionDetailsCardBgColor: json["questionDetailsCardBgColor"],
    questionDetailsCardTextColor: json["questionDetailsCardTextColor"],
    cartCardBgColor: json["cartCardBgColor"],
    cartCardTextColor: json["cartCardTextColor"],
    cartCardHeaderBgColor: json["cartCardHeaderBgColor"],
    cartCardHeaderTextColor: json["cartCardHeaderTextColor"],
    productDetailsCardBgColor: json["productDetailsCardBgColor"],
    productDetailsCardTextColor: json["productDetailsCardTextColor"],
    productDetailsHeaderBgColor: json["productDetailsHeaderBgColor"],
    productDetailsHeaderTextColor: json["productDetailsHeaderTextColor"],
    layout: Layout2.fromJson(json["layout"]),
  );

  Map<String, dynamic> toJson() => {
    "stepsCardBgColor": stepsCardBgColor,
    "stepsCardTextColor": stepsCardTextColor,
    "stepsCardHeaderBgColor": stepsCardHeaderBgColor,
    "stepsCardHeaderTextColor": stepsCardHeaderTextColor,
    "questionDetailsCardBgColor": questionDetailsCardBgColor,
    "questionDetailsCardTextColor": questionDetailsCardTextColor,
    "cartCardBgColor": cartCardBgColor,
    "cartCardTextColor": cartCardTextColor,
    "cartCardHeaderBgColor": cartCardHeaderBgColor,
    "cartCardHeaderTextColor": cartCardHeaderTextColor,
    "productDetailsCardBgColor": productDetailsCardBgColor,
    "productDetailsCardTextColor": productDetailsCardTextColor,
    "productDetailsHeaderBgColor": productDetailsHeaderBgColor,
    "productDetailsHeaderTextColor": productDetailsHeaderTextColor,
    "layout": layout?.toJson(),
  };
}