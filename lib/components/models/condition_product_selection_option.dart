import 'package:docshero/components/models/option2.dart';

class ConditionsForProductSelectionOption {
  ConditionsForProductSelectionOption({
    this.option,
    this.condition,
    this.optionOperator,
    this.value,
  });

  Option2? option;
  String? condition;
  String? optionOperator;
  String? value;

  factory ConditionsForProductSelectionOption.fromJson(Map<String, dynamic> json) => ConditionsForProductSelectionOption(
    option: Option2.fromJson(json["option"]),
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