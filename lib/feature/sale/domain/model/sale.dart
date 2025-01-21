import 'package:al_pura_frontend/feature/shared/Domain/model/product.dart';

class Sale {
  final Map<String, (Product, double)> products;
  final bool isDelivery;
  final bool isPerMajor;
  final double totalPrice;
  final double discount;

  Sale({required this.products, required this.isDelivery, required this.isPerMajor, required this.totalPrice, required this.discount});

  Map<String, dynamic> toJson() {
    return {
      "products": this.products,
      "isDelivery": this.isDelivery,
      "isPerMajor": this.isPerMajor,
      "totalPrice": this.totalPrice,
      "discount": this.discount,
    };
  }

}