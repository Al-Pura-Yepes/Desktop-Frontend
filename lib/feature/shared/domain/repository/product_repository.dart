import 'package:al_pura_frontend/feature/shared/domain/model/product.dart';

abstract class ProductRepository {
  Future<Product?> readProduct(String id);
  Future<List<Product>> readAllProduct();
  Future<Product?> createProduct(Product product);
  Future<Product?> updateProduct(Product product);
  Future<void> decrementItemsByCart(Map<Product, double> cartItems);
}
