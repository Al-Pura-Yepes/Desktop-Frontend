import 'package:al_pura_frontend/feature/shared/domain/model/product.dart';
import 'package:al_pura_frontend/feature/shared/domain/datasource/product_datasource.dart';
import 'package:al_pura_frontend/feature/shared/domain/repository/product_repository.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductDatasource datasource;

  const ProductRepositoryImpl({required this.datasource});

  @override
  Future<Product?> createProduct(Product product) {
    return datasource.createProduct(product);
  }

  @override
  Future<List<Product>> readAllProduct() {
    return datasource.readAllProduct();
  }

  @override
  Future<Product?> readProduct(String id) {
    return datasource.readProduct(id);
  }

  @override
  Future<Product?> updateProduct(Product product) {
    return datasource.updateProduct(product);
  }
}
