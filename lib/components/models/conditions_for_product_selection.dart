import 'package:docshero/components/models/option_product2_model.dart';

import 'condition_product_selection_option.dart';

class ConditionsForProductSelection {
  ConditionsForProductSelection({
    this.id,
    this.discount,
    this.products,
    this.options,
    this.isSatisfied,
    this.next,
  });

  dynamic? id;
  String? discount;
  List<OptionProduct2>? products;
  List<ConditionsForProductSelectionOption>? options;
  bool? isSatisfied;
  String? next;

  factory ConditionsForProductSelection.fromJson(Map<String, dynamic> json) => ConditionsForProductSelection(
    id: json["id"],
    discount: json["discount"],
    products: List<OptionProduct2>.from(json["products"].map((x) => OptionProduct2.fromJson(x))),
    options: List<ConditionsForProductSelectionOption>.from(json["options"].map((x) => ConditionsForProductSelectionOption.fromJson(x))),
    isSatisfied: json["isSatisfied"],
    next: json["next"],
  );

  // Map<String, dynamic> toJson() => {
  //   "id": id,
  //   "discount": discount,
  //   "products": List<dynamic>.from(products!.map((x) => x.toJson())),
  //   "options": List<dynamic>.from(options.map((x) => x.toJson())),
  //   "isSatisfied": isSatisfied,
  //   "next": next,
  // };
}