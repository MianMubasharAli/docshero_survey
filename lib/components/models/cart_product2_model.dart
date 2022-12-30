class CartProduct2 {
  CartProduct2({
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
    this.belongsTo,
  });

  int? id;
  String? articleNumber;
  String? name;
  String? listingPrice;
  String? status;
  dynamic? salePrice;
  String? profit;
  int? discount;
  int? quantity;
  String? tax;
  String? parentId;
  List<String>? belongsTo;

  factory CartProduct2.fromJson(Map<String, dynamic> json) => CartProduct2(
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
    belongsTo: List<String>.from(json["belongsTo"].map((x) => x)),
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
    "belongsTo": List<dynamic>.from(belongsTo!.map((x) => x)),
  };
}