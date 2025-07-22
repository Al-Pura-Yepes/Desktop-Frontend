import 'package:al_pura_frontend/features/product/domain/entities/product.dart';

abstract class ProductRepository {
  Future<List<Product>> getAll();
  Future<Product?> get(String id);
  Future<Product> create(Product product);
  Future<Product> update(Product product);
}
