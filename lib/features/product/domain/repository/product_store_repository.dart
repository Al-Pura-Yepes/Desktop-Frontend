import 'package:al_pura_frontend/features/product/domain/entities/product.dart';
import 'package:al_pura_frontend/features/product/domain/entities/stock.dart';
import 'package:al_pura_frontend/features/product/domain/repository/filters/product/i_product_filter.dart';

// Clase Store por el momento nos ayudara a recuperar toda la informacion de los productos
// Esto se editara mas adelante para hacerlo multi-tenant
abstract class ProductStoreRepository {
  Future<List<ProductStore>> getAll(IProductFilter? filter);
  Future<ProductStore?> get(String id);
  Future<ProductStore> create(Product product);
  Future<ProductStore> update(ProductStore updatedProductStore);
  Future<bool> delete(String id);
}