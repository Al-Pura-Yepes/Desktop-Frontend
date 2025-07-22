import 'package:al_pura_frontend/core/utils/firebase_collections.dart';
import 'package:al_pura_frontend/features/product/data/dtos/product/product_request_dto.dart';
import 'package:al_pura_frontend/features/product/data/dtos/product/product_response_dto.dart';
import 'package:al_pura_frontend/features/product/data/repository/firebase_product_repository.dart';
import 'package:al_pura_frontend/features/product/domain/usecases/get_product_by_id_use_case.dart';
import 'package:al_pura_frontend/features/store/data/dtos/product_store_request_dto.dart';
import 'package:al_pura_frontend/features/store/data/dtos/product_store_response_dto.dart';
import 'package:al_pura_frontend/features/store/domain/entities/product_store.dart';
import 'package:al_pura_frontend/features/store/domain/repositories/product_store_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseProductStoreRepository implements ProductStoreRepository {
  late CollectionReference stores;
  late CollectionReference products;

  FirebaseProductStoreRepository() {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    stores = firestore.collection(FirebaseCollections.productsStoreCollections);
    products = firestore.collection(FirebaseCollections.productsCollections);
  }

  @override
  Future<ProductStore> create(ProductStore store) async {
    try {
      final dto = ProductStoreRequestDto();
      final newProductStore = await stores.add(dto.toJson(store));
      final docSnapshot = await newProductStore.get();
      final Map<String, dynamic> data =
          docSnapshot.data() as Map<String, dynamic>;

      final getUseCase =
          GetProductByIdUseCase(repository: FirebaseProductRepository());
      final productData = (await getUseCase.execute(data['product']));
      final productMap = ProductRequestDto().toJson(productData!);
      data['product'] = productMap;

      return ProductStoreResponseDto()
          .fromJson({...data, "id": docSnapshot.id});
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> delete(String id) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<List<ProductStore>> get() async {
    List<ProductStore> fetchProduct = [];
    try {
      QuerySnapshot snapshot = await stores.get();
      final getUseCase =
          GetProductByIdUseCase(repository: FirebaseProductRepository());
      for (DocumentSnapshot doc in snapshot.docs) {
        Map<String, dynamic> storeData = doc.data() as Map<String, dynamic>;
        final productData = (await getUseCase.execute(storeData['product']));
        final productMap = ProductRequestDto().toJson(productData!);
        storeData['product'] = productMap;
        fetchProduct.add(ProductStoreResponseDto().fromJson({
          ...storeData,
          "id": doc.id,
        }));
      }
    } catch (e) {
      rethrow;
    }
    return fetchProduct;
  }

  @override
  Future<ProductStore?> getById(String id) async {
    try {
      DocumentSnapshot doc = await stores.doc(id).get();
      Map<String, dynamic> productData = doc.data() as Map<String, dynamic>;
      if (doc.exists) {
        return ProductStoreResponseDto()
            .fromJson({"id": doc.id, ...productData});
      }
      return null;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> update(ProductStore store) async {
    try {
      final dto = ProductStoreRequestDto();
      await stores.doc(store.id).update(dto.toJson(store));
    } catch (e) {
      rethrow;
    }
  }
}
