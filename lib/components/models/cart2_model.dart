import 'cart_product2_model.dart';

class Cart2 {
  Cart2({
    this.products,
    this.config,
  });

  List<CartProduct2>? products;
  List<dynamic>? config;

  factory Cart2.fromJson(Map<String, dynamic> json) => Cart2(
    products: List<CartProduct2>.from(json["products"].map((x) => CartProduct2.fromJson(x))),
    config: List<dynamic>.from(json["config"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "products": List<dynamic>.from(products!.map((x) => x.toJson())),
    "config": List<dynamic>.from(config!.map((x) => x)),
  };
}