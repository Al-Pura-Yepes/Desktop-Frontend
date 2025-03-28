import 'package:al_pura_frontend/feature/shared/domain/model/product.dart';

abstract class ProductDatasource {
  Future<Product?> readProduct(String id);
  Future<List<Product>> readAllProduct();
  Future<Product?> createProduct(Product product);
  Future<Product?> updateProduct(Product product);
  Future<void> decrementItemsByCart(Map<Product, double> cartItems);

  Future<void> incrementItemsByCart(Map<Product, double> cartItems);
}
