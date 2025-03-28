import 'package:al_pura_frontend/feature/shared/domain/model/product.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Sale {
  final String id;
  final Map<Product, double> products;
  final bool isDelivery;
  final bool isPerMajor;
  final double totalPrice;
  final double discount;
  final bool isReservation;
  final String? clientName;
  final String? clientPhone;
  final bool isByCash;
  final DateTime? reservationDate;
  final DateTime saleDate;

  Sale(
      {this.id = '',
      required this.products,
      required this.isDelivery,
      required this.isPerMajor,
      required this.totalPrice,
      required this.discount,
      required this.isReservation,
      this.clientName,
      this.clientPhone,
      required this.isByCash,
      this.reservationDate,
      required this.saleDate});

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
      "isDelivery": isDelivery,
      "isPerMajor": isPerMajor,
      "totalPrice": totalPrice,
      "discount": discount,
      "isReservation": isReservation,
      "clientName": clientName,
      "clientPhone": clientPhone,
      "isByCash": isByCash,
      "reservationDate": reservationDate,
      "saleDate": saleDate
    };
  }

  static Map<Product, double> _productFromJson(List<dynamic> json) {
    Map<Product, double> result = {};
    for (var jsonProduct in json) {
      final productMap = jsonProduct as Map<String, dynamic>;
      final quantity = (productMap['quantity'] as num).toDouble();
      result[Product.fromJson(productMap)] = quantity;
    }
    return result;
  }

  factory Sale.fromJson(Map<String, dynamic> json, String id) {
    return Sale(
      id: id,
      products: _productFromJson(json["products"]),
      isDelivery: json["isDelivery"],
      isPerMajor: json["isPerMajor"],
      totalPrice: json["totalPrice"],
      discount: json["discount"],
      isReservation: json['isReservation'],
      clientName: json['clientName'],
      clientPhone: json['clientPhone'],
      isByCash: json['isByCash'],
      reservationDate: json['reservationDate'] != null
          ? (json['reservationDate'] as Timestamp).toDate()
          : null,
      saleDate: json['saleDate'] != null
          ? (json['saleDate'] as Timestamp).toDate()
          : DateTime.now(),
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
