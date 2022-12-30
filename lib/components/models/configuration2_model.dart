import 'package:docshero/components/models/conditions_for_product_selection.dart';

import 'option2.dart';

class Configuration2 {
  Configuration2({
    this.type,
    this.options,
    this.conditionsForProductSelection,
  });

  String? type;
  List<Option2>? options;
  List<ConditionsForProductSelection>? conditionsForProductSelection;

  factory Configuration2.fromJson(Map<String, dynamic> json) => Configuration2(
    type: json["type"],
    options: List<Option2>.from(json["options"].map((x) => Option2.fromJson(x))),
    conditionsForProductSelection: List<ConditionsForProductSelection>.from(json["conditionsForProductSelection"].map((x) => ConditionsForProductSelection.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "type": type,
    "options": List<dynamic>.from(options!.map((x) => x.toJson())),
    "conditionsForProductSelection": List<dynamic>.from(conditionsForProductSelection!.map((x) => x)),
  };
}