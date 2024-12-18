import 'package:al_pura_frontend/feature/shared/Domain/model/i_entity.dart';

class Product implements IEntity {

  @override
  final String id;

  final String category;
  final String flavor;
  final double price;
  final String quantity;
  final String imageURL;

  const Product({
    required this.id,
    required this.category,
    required this.flavor,
    required this.price,
    required this.quantity,
    required this.imageURL,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json["id"],
      category: json["category"],
      flavor: json["flavor"],
      price: double.parse(json["price"]),
      quantity: json["quantity"],
      imageURL: json["imageURL"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": this.id,
      "category": this.category,
      "flavor": this.flavor,
      "price": this.price,
      "quantity": this.quantity,
      "imageURL": this.imageURL,
    };
  }
}