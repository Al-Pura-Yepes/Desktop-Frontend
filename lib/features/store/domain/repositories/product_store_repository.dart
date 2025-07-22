import 'package:al_pura_frontend/features/store/domain/entities/product_store.dart';

abstract class ProductStoreRepository {
  Future<List<ProductStore>> get();
  Future<ProductStore?> getById(String id);
  Future<void> update(ProductStore store);
  Future<bool> delete(String id);
  Future<ProductStore> create(ProductStore store);
}
