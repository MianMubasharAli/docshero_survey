// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

Welcome welcomeFromJson(String str) => Welcome.fromJson(json.decode(str));

// String welcomeToJson(Welcome data) => json.encode(data.toJson());

class Welcome {
  Welcome({
    this.id,
    this.name,
    this.steps,
    this.cart,
  });

  String? id;
  String? name;
  List<Step>? steps;
  Cart? cart;

  factory Welcome.fromJson(Map<String, dynamic> json) => Welcome(
    id: json["id"],
    name: json["name"],
    steps: List<Step>.from(json["steps"].map((x) => Step.fromJson(x))),
    cart: Cart.fromJson(json["cart"]),
  );

  // Map<String, dynamic> toJson() => {
  //   "id": id,
  //   "name": name,
  //   "steps": List<dynamic>.from(steps.map((x) => x.toJson())),
  //   "cart": cart.toJson(),
  // };
}

class Cart {
  Cart({
    this.products,
    this.config,
  });

  List<dynamic>? products;
  List<dynamic>? config;

  factory Cart.fromJson(Map<String, dynamic> json) => Cart(
    products: List<dynamic>.from(json["products"].map((x) => x)),
    config: List<dynamic>.from(json["config"].map((x) => x)),
  );

  // Map<String, dynamic> toJson() => {
  //   "products": List<dynamic>.from(products.map((x) => x)),
  //   "config": List<dynamic>.from(config.map((x) => x)),
  // };
}

class Step {
  Step({
    this.id,
    this.type,
    this.value,
  });

  String? id;
  String? type;
  Value? value;

  factory Step.fromJson(Map<String, dynamic> json) => Step(
    id: json["id"],
    type: json["type"],
    value: Value.fromJson(json["value"]),
  );

  // Map<String, dynamic> toJson() => {
  //   "id": id,
  //   "type": type,
  //   "value": value.toJson(),
  // };
}

class Value {
  Value({
    this.id,
    this.title,
    this.text,
    this.description,
    this.chapter,
    this.productDetails,
    this.configuration,
    this.next,
    this.back,
  });

  String? id;
  String? title;
  String? text;
  String? description;
  String? chapter;
  String? productDetails;
  Configuration? configuration;
  String? next;
  String? back;

  factory Value.fromJson(Map<String, dynamic> json) => Value(
    id: json["id"],
    title: json["title"],
    text: json["text"],
    description: json["description"],
    chapter: json["chapter"],
    productDetails: json["productDetails"],
    configuration: Configuration.fromJson(json["configuration"]),
    next: json["next"],
    back: json["back"],
  );

  // Map<String, dynamic> toJson() => {
  //   "id": id,
  //   "title": title,
  //   "text": text,
  //   "description": description,
  //   "chapter": chapter,
  //   "productDetails": productDetails,
  //   "configuration": configuration.toJson(),
  //   "next": next,
  //   "back": back,
  // };
}

class Configuration {
  Configuration({
    this.type,
    this.options,
    this.conditionsForProductSelection,
  });

  String? type;
  List<OptionOption>? options;
  List<ConditionsForProductSelection>? conditionsForProductSelection;

  factory Configuration.fromJson(Map<String, dynamic> json) => Configuration(
    type: json["type"],
    options: List<OptionOption>.from(json["options"].map((x) => OptionOption.fromJson(x))),
    conditionsForProductSelection: List<ConditionsForProductSelection>.from(json["conditionsForProductSelection"].map((x) => ConditionsForProductSelection.fromJson(x))),
  );

  // Map<String, dynamic> toJson() => {
  //   "type": type,
  //   "options": List<dynamic>.from(options.map((x) => x.toJson())),
  //   "conditionsForProductSelection": List<dynamic>.from(conditionsForProductSelection.map((x) => x.toJson())),
  // };
}

class ConditionsForProductSelection {
  ConditionsForProductSelection({
    this.id,
    this.discount,
    this.products,
    this.options,
    this.isSatisfied,
    this.next,
  });

  String? id;
  String? discount;
  List<Product>? products;
  List<ConditionsForProductSelectionOption>? options;
  bool? isSatisfied;
  String? next;

  factory ConditionsForProductSelection.fromJson(Map<String, dynamic> json) => ConditionsForProductSelection(
    id: json["id"],
    discount: json["discount"],
    products: List<Product>.from(json["products"].map((x) => Product.fromJson(x))),
    options: List<ConditionsForProductSelectionOption>.from(json["options"].map((x) => ConditionsForProductSelectionOption.fromJson(x))),
    isSatisfied: json["isSatisfied"],
    next: json["next"],
  );

  // Map<String, dynamic> toJson() => {
  //   "id": id,
  //   "discount": discount,
  //   "products": List<dynamic>.from(products.map((x) => x.toJson())),
  //   "options": List<dynamic>.from(options.map((x) => x.toJson())),
  //   "isSatisfied": isSatisfied,
  //   "next": next,
  // };
}

class ConditionsForProductSelectionOption {
  ConditionsForProductSelectionOption({
    this.option,
    this.condition,
    this.optionOperator,
    this.value,
  });

  OptionOption? option;
  String? condition;
  String? optionOperator;
  String? value;

  factory ConditionsForProductSelectionOption.fromJson(Map<String, dynamic> json) => ConditionsForProductSelectionOption(
    option: OptionOption.fromJson(json["option"]),
    condition: json["condition"],
    optionOperator: json["operator"],
    value: json["value"],
  );

  // Map<String, dynamic> toJson() => {
  //   "option": option.toJson(),
  //   "condition": condition,
  //   "operator": optionOperator,
  //   "value": value,
  // };
}

class OptionOption {
  OptionOption({
    this.id,
    this.title,
    this.value,
    this.numberInputs,
    this.products,
    this.next,
    this.min,
    this.max,
    this.step,
    this.placeholder,
    this.isSelected=false,
  });

  String? id;
  String? title;
  int? value;
  List<NumberInput>? numberInputs;
  List<dynamic>? products;
  String? next;
  int? min;
  String? max;
  String? step;
  String? placeholder;
  bool isSelected;

  factory OptionOption.fromJson(Map<String, dynamic> json) => OptionOption(
    id: json["id"],
    title: json["title"],
    value: json["value"],
    numberInputs: List<NumberInput>.from(json["numberInputs"].map((x) => NumberInput.fromJson(x))),
    products: List<dynamic>.from(json["products"].map((x) => x)),
    next: json["next"],
    min: json["min"],
    max: json["max"],
    step: json["step"],
    placeholder: json["placeholder"],
    isSelected: json['isSelected'] ??  false,
  );

  // Map<String, dynamic> toJson() => {
  //   "id": id,
  //   "title": title,
  //   "value": value,
  //   "numberInputs": List<dynamic>.from(numberInputs.map((x) => x.toJson())),
  //   "products": List<dynamic>.from(products.map((x) => x)),
  //   "next": next,
  //   "min": min,
  //   "max": max,
  //   "step": step,
  //   "placeholder": placeholder,
  // };
}

class NumberInput {
  NumberInput({
    this.type,
    this.numberInputOperator,
    this.value,
    this.parenthesis,
  });

  String? type;
  String? numberInputOperator;
  String? value;
  List<dynamic>? parenthesis;

  factory NumberInput.fromJson(Map<String, dynamic> json) => NumberInput(
    type: json["type"],
    numberInputOperator: json["operator"],
    value: json["value"],
    parenthesis: List<dynamic>.from(json["parenthesis"].map((x) => x)),
  );

  // Map<String, dynamic> toJson() => {
  //   "type": type,
  //   "operator": numberInputOperator,
  //   "value": value,
  //   "parenthesis": List<dynamic>.from(parenthesis.map((x) => x)),
  // };
}

class Product {
  Product({
    this.id,
    this.articleNumber,
    this.name,
    this.listingPrice,
    this.status,
    this.salePrice,
    this.profit,
    this.discount,
    this.quantity,
    this.tax,
    this.parentId,
  });

  int? id;
  String? articleNumber;
  String? name;
  String? listingPrice;
  String? status;
  String? salePrice;
  String? profit;
  int? discount;
  String? quantity;
  String? tax;
  String? parentId;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json["id"],
    articleNumber: json["articleNumber"],
    name: json["name"],
    listingPrice: json["listingPrice"],
    status: json["status"],
    salePrice: json["salePrice"],
    profit: json["profit"],
    discount: json["discount"],
    quantity: json["quantity"],
    tax: json["tax"],
    parentId: json["parentId"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "articleNumber": articleNumber,
    "name": name,
    "listingPrice": listingPrice,
    "status": status,
    "salePrice": salePrice,
    "profit": profit,
    "discount": discount,
    "quantity": quantity,
    "tax": tax,
    "parentId": parentId,
  };
}
