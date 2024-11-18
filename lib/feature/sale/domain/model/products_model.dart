import 'package:al_pura_frontend/feature/sale/domain/model/product_model.dart';

class ProductsModel {
  final String category;
  final List<ProductModel> products;

  const ProductsModel({required this.category, this.products = const []});
}
