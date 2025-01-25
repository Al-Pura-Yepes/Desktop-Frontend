import 'package:al_pura_frontend/feature/shared/domain/model/product.dart';

class Sale {
  final Map<Product, double> products;
  final bool isDelivery;
  final bool isPerMajor;
  final double totalPrice;
  final double discount;
  final bool isReservation;
  final String? clientName;
  final String? clientPhone;
  final bool? isByCash;

  Sale(
      {required this.products,
      required this.isDelivery,
      required this.isPerMajor,
      required this.totalPrice,
      required this.discount,
      required this.isReservation,
      this.clientName,
      this.clientPhone,
      required this.isByCash});

  List<Map<String, dynamic>> _productsToJson() {
    List<Map<String, dynamic>> result = [];
    final productsList = products.keys.toList();
    for (Product aux in productsList) {
      result.add({...aux.toJson(), 'id': aux.id, 'quantity': products[aux]});
    }
    return result;
  }

  Map<String, dynamic> toJson() {
    return {
      "products": _productsToJson(),
      "isDelivery": this.isDelivery,
      "isPerMajor": this.isPerMajor,
      "totalPrice": this.totalPrice,
      "discount": this.discount,
      "isReservation": this.isReservation,
      "clientName": this.clientName,
      "clientPhone": this.clientPhone,
      "isByCash": this.isByCash,
    };
  }

  static Map<Product, double> _productFromJson(
      List<Map<String, dynamic>> json) {
    Map<Product, double> result = {};
    for (Map<String, dynamic> jsonProduct in json) {
      result[Product.fromJson(jsonProduct)] = jsonProduct['quantity'];
    }
    return result;
  }

  factory Sale.fromJson(Map<String, dynamic> json) {
    return Sale(
      products: _productFromJson(json["products"]),
      isDelivery: json["isDelivery"],
      isPerMajor: json["isPerMajor"],
      totalPrice: json["totalPrice"],
      discount: json["discount"],
      isReservation: json['isReservation'],
      clientName: json['clientName'],
      clientPhone: json['clientPhone'],
      isByCash: json['isByCash']
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Sale &&
          runtimeType == other.runtimeType &&
          products == other.products;

  @override
  int get hashCode => products.hashCode;

  @override
  String toString() {
    return 'Sale{products: $products, isDelivery: $isDelivery, isPerMajor: $isPerMajor, totalPrice: $totalPrice, discount: $discount}';
  }
}
