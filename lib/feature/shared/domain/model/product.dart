import 'package:al_pura_frontend/feature/shared/domain/model/i_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Product implements IEntity {
  @override
  final String id;

  final String category;
  final String flavor;
  final double? price;
  final double quantity;
  final double? weight;
  final String imageURL;
  final List<DateTime> expirationDateList;
  final bool isReturnable;
  final bool isFixedPrice;
  final String weightValue;

  const Product(
      {this.id = '',
      required this.category,
      required this.flavor,
      required this.price,
      required this.quantity,
      this.weight,
      required this.imageURL,
      this.expirationDateList = const [],
      this.isReturnable = false,
      this.isFixedPrice = false,
      required this.weightValue});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
        id: json["id"] ?? "0",
        category: json["category"],
        flavor: json["flavor"],
        price: (json["price"] is int)
            ? (json["price"] as int).toDouble()
            : json["price"],
        quantity: (json["quantity"] is int)
            ? (json["quantity"] as int).toDouble()
            : json["quantity"],
        weight: (json["weight"] is int)
            ? (json["weight"] as int).toDouble()
            : json["weight"],
        imageURL: json["imageURL"],
        expirationDateList:
            (json["expirationDateList"] as List<dynamic>?)?.map((element) {
                  return (element as Timestamp).toDate();
                }).toList() ??
                [],
        isReturnable: json["isReturnable"] ?? false,
        isFixedPrice: json["isFixedPrice"] ?? false,
        weightValue: json["weightValue"]);
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "category": category,
      "flavor": flavor,
      "price": price,
      "quantity": quantity,
      "weight": weight,
      "imageURL": imageURL,
      "expirationDateList": expirationDateList,
      "isReturnable": isReturnable,
      "isFixedPrice": isFixedPrice,
      "weightValue": weightValue,
    };
  }

  @override
  String toString() {
    return 'Product{id: $id, category: $category, flavor: $flavor, price: $price, quantity: $quantity, weight: $weight, imageURL: $imageURL, expirationDateList: $expirationDateList, isReturnable: $isReturnable, isFixedPrice: $isFixedPrice}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Product && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;

  Product copyWith({
    @override final String? id,
    final String? category,
    final String? flavor,
    final double? price,
    final double? quantity,
    final double? weight,
    final String? imageURL,
    final List<DateTime>? expirationDateList,
    final bool? isReturnable,
    final bool? isFixedPrice,
    final String? weightValue,
  }) {
    return Product(
      id: id ?? this.id,
      category: category ?? this.category,
      flavor: flavor ?? this.flavor,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
      weight: weight ?? this.weight,
      imageURL: imageURL ?? this.imageURL,
      expirationDateList: expirationDateList ?? this.expirationDateList,
      isReturnable: isReturnable ?? this.isReturnable,
      isFixedPrice: isFixedPrice ?? this.isFixedPrice,
      weightValue: weightValue ?? this.weightValue,
    );
  }
}
