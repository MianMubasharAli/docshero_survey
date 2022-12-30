import 'package:docshero/components/models/value_element2_model.dart';

class Step2 {
  Step2({
    this.id,
    this.type,
    this.value,
  });

  String? id;
  String? type;
  ValueElement2? value;

  factory Step2.fromJson(Map<String, dynamic> json) => Step2(
    id: json["id"],
    type: json["type"],
    value: ValueElement2.fromJson(json["value"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "type": type,
    "value": value?.toJson(),
  };
}