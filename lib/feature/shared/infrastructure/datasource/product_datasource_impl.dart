import 'package:al_pura_frontend/feature/shared/domain/datasource/product_datasource.dart';
import 'package:al_pura_frontend/feature/shared/domain/model/product.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProductDatasourceImpl implements ProductDatasource {
  late CollectionReference products;

  ProductDatasourceImpl() {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    products = firestore.collection('Products');
  }

  @override
  Future<Product?> createProduct(Product product) async {
    try {
      await products.add(product.toJson());
      return product;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Product?> readProduct(String id) async {
    try {
      DocumentSnapshot doc = await products.doc(id).get();
      Map<String, dynamic> productData = doc.data() as Map<String, dynamic>;
      if (doc.exists) {
        return Product.fromJson({"id": doc.id, ...productData});
      }
      return null;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Product?> updateProduct(Product product) async {
    try {
      await products.doc(product.id).update(product.toJson());
      return product;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<Product>> readAllProduct() async {
    List<Product> fetchProduct = [];
    try {
      QuerySnapshot snapshot = await products.get();
      for (DocumentSnapshot doc in snapshot.docs) {
        Map<String, dynamic> productData = doc.data() as Map<String, dynamic>;
        fetchProduct.add(Product.fromJson({"id": doc.id, ...productData}));
      }
    } catch (e) {
      rethrow;
    }
    return fetchProduct;
  }

  @override
  Future<void> decrementItemsByCart(Map<Product, double> cartItems) async {
    try {
      WriteBatch batch = FirebaseFirestore.instance.batch();
      for (var entry in cartItems.entries) {
        Product product = entry.key;
        double decrementedQuantity = product.quantity - entry.value;
        double newQuantity = decrementedQuantity < 0 ? 0 : decrementedQuantity;
        DocumentReference productRef = products.doc(product.id);
        batch.update(productRef, {"quantity": newQuantity});
      }
      await batch.commit();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> incrementItemsByCart(Map<Product, double> cartItems) async {
    try {
      WriteBatch batch = FirebaseFirestore.instance.batch();
      for (var entry in cartItems.entries) {
        Product product = entry.key;
        double incrementedQuantity = product.quantity + entry.value;
        // Si tienes alguna lógica de límite o algo similar, lo podrías agregar aquí.
        DocumentReference productRef = products.doc(product.id);
        batch.update(productRef, {"quantity": incrementedQuantity});
      }
      await batch.commit();
    } catch (e) {
      rethrow;
    }
  }
}
