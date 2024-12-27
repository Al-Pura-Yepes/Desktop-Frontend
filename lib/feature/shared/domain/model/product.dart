import 'package:al_pura_frontend/feature/shared/Domain/model/i_entity.dart';

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

  const Product(
      {this.id = '',
      required this.category,
      required this.flavor,
      this.price = 0.0,
      required this.quantity,
      this.weight = 0.0,
      required this.imageURL,
      this.expirationDateList = const [],
      this.isReturnable = false,
      this.isFixedPrice = false});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
        id: json["id"],
        category: json["category"],
        flavor: json["flavor"],
        price: json["price"] ?? 0.0,
        quantity: json["quantity"],
        weight: json["weight"] ?? 0.0,
        imageURL: json["imageURL"],
        expirationDateList: json["expirationDateList"],
        isReturnable: json["isReturnable"],
        isFixedPrice: json["isFixedPrice"]
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "category": this.category,
      "flavor": this.flavor,
      "price": this.price,
      "quantity": this.quantity,
      "weight": this.weight,
      "imageURL": this.imageURL,
      "expirationDateList": this.expirationDateList,
      "isReturnable": this.isReturnable,
      "isFixedPrice": this.isFixedPrice
    };
  }

  @override
  String toString() {
    return 'Product{id: $id, category: $category, flavor: $flavor, price: $price, quantity: $quantity, weight: $weight, imageURL: $imageURL, expirationDateList: $expirationDateList, isReturnable: $isReturnable, isFixedPrice: $isFixedPrice}';
  }
}
