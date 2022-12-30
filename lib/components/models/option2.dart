import 'option_product2_model.dart';

class Option2 {
  Option2({
    this.id,
    this.title,
    this.value,
    this.products,
    this.next,
    this.min,
    this.max,
    this.step,
    this.placeholder,
    this.isSelected=false
  });

  String? id;
  String? title;
  dynamic? value;
  List<OptionProduct2>? products;
  String? next;
  int? min;
  dynamic? max;
  dynamic? step;
  String? placeholder;
  bool isSelected;

  factory Option2.fromJson(Map<String, dynamic> json) => Option2(
      id: json["id"],
      title: json["title"],
      value: json["value"],
      products: List<OptionProduct2>.from(json["products"].map((x) => OptionProduct2.fromJson(x))),
      next: json["next"],
      min: json["min"],
      max: json["max"],
      step: json["step"],
      placeholder: json["placeholder"],
      isSelected: json['isSelected'] ?? false
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "value": value,
    "products": List<dynamic>.from(products!.map((x) => x.toJson())),
    "next": next,
    "min": min,
    "max": max,
    "step": step,
    "placeholder": placeholder,
    "isSelected": isSelected
  };
}