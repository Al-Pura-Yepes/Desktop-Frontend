import 'package:al_pura_frontend/feature/shared/Domain/model/product.dart';

abstract class ProductDatasource {

  Future<Product> readProduct(String id);
  Future<Product> readAllProduct();
  Future<Product> createProduct(Product product);
  Future<Product> updateProduct(Product product);

}