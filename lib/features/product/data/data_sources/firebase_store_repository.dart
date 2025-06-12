
import 'package:al_pura_frontend/features/product/domain/entities/product.dart';
import 'package:al_pura_frontend/features/product/domain/entities/stock.dart';
import 'package:al_pura_frontend/features/product/domain/repository/filters/product/i_product_filter.dart';
import 'package:al_pura_frontend/features/product/domain/repository/product_store_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseStoreRepository implements ProductStoreRepository {

  late CollectionReference store;

  FirebaseStoreRepository(){
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    store = firestore.collection('Store');
  }

  @override
  Future<ProductStore> create(Product product) async {
    try {
      ProductStore newStore = ProductStore(product: product, quantity: 0);
      await store.add(newStore.toMap());
      return newStore;
    } catch(e) {
      rethrow;
    }
  }

  @override
  Future<bool> delete(String id) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<ProductStore?> get(String id) async{
    try {
      DocumentSnapshot doc = await store.doc(id).get();
      Map<String, dynamic> productData = doc.data() as Map<String, dynamic>;
      if (doc.exists) {
        return ProductStore.fromMap({"id": doc.id, ...productData});
      }
      return null;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<ProductStore>> getAll(IProductFilter? filter) async{
    List<ProductStore> fetchProduct = [];
    try {
      final query = _concatFilter(store, filter);
      QuerySnapshot snapshot = await query.get();
      for (DocumentSnapshot doc in snapshot.docs) {
        Map<String, dynamic> productData = doc.data() as Map<String, dynamic>;
        fetchProduct.add(ProductStore.fromMap({...productData, "id": doc.id,}));
      }
    } catch (e) {
      rethrow;
    }
    return fetchProduct;
  }

  @override
  Future<ProductStore> update(String id, ProductStore newStore) async{
    try {
      await store.doc(id).update(newStore.toMap());
      return newStore;
    } catch (e) {
      rethrow;
    }
  }

}

Query<Object?> _concatFilter(CollectionReference ref, IProductFilter? filter) {
  Query query = ref;
  if (filter == null) return query;
  filter.toMap().forEach((key, value) {
    if (value != null) query = query.where(key, isEqualTo: value);
  },);
  return query;
}
