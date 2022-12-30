class Layout2 {
  Layout2({
    this.id,
    this.type,
    this.children,
    this.value,
    this.contains,
  });

  String? id;
  String? type;
  List<Layout2>? children;
  int? value;
  String? contains;

  factory Layout2.fromJson(Map<String, dynamic> json) => Layout2(
    id: json["id"],
    type: json["type"],
    children: List<Layout2>.from(json["children"].map((x) => Layout2.fromJson(x))),
    value: json["value"],
    contains: json["contains"] == null ? null : json["contains"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "type": type,
    "children": List<dynamic>.from(children!.map((x) => x.toJson())),
    "value": value,
    "contains": contains == null ? null : contains,
  };
}