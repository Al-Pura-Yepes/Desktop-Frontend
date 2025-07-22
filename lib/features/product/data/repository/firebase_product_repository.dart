import 'package:al_pura_frontend/core/utils/firebase_collections.dart';
import 'package:al_pura_frontend/features/product/data/dtos/product/product_request_dto.dart';
import 'package:al_pura_frontend/features/product/data/dtos/product/product_response_dto.dart';
import 'package:al_pura_frontend/features/product/domain/entities/product.dart';
import 'package:al_pura_frontend/features/product/domain/repository/product_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseProductRepository implements ProductRepository {
  late CollectionReference products;

  FirebaseProductRepository() {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    products = firestore.collection(FirebaseCollections.productsCollections);
  }

  @override
  Future<Product> create(Product product) async {
    try {
      final dto = ProductRequestDto();
      final newProduct = await products.add(dto.toJson(product));
      final docSnapshot = await newProduct.get();
      final Map<String, dynamic> data =
          docSnapshot.data() as Map<String, dynamic>;
      return ProductResponseDto().fromJson({...data, "id": docSnapshot.id});
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Product?> get(String id) async {
    try {
      DocumentSnapshot doc = await products.doc(id).get();
      Map<String, dynamic> productData = doc.data() as Map<String, dynamic>;
      if (doc.exists) {
        return ProductResponseDto().fromJson({
          ...productData,
          "id": doc.id,
        });
      }
      return null;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<Product>> getAll() async {
    List<Product> fetchProduct = [];
    try {
      QuerySnapshot snapshot = await products.get();
      for (DocumentSnapshot doc in snapshot.docs) {
        Map<String, dynamic> productData = doc.data() as Map<String, dynamic>;
        fetchProduct.add(ProductResponseDto().fromJson({
          "id": doc.id,
          ...productData,
        }));
      }
    } catch (e) {
      rethrow;
    }
    return fetchProduct;
  }

  @override
  Future<Product> update(Product product) async {
    try {
      final dto = ProductRequestDto();
      await products.doc(product.id).update(dto.toJson(product));
      return product;
    } catch (e) {
      rethrow;
    }
  }
}
