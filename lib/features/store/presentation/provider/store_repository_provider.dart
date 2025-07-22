import 'package:al_pura_frontend/features/store/data/repositories/firebase_product_store_repository.dart';
import 'package:al_pura_frontend/features/store/domain/repositories/product_store_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final storeRepositoryProvider = Provider<ProductStoreRepository>((ref) {
  return FirebaseProductStoreRepository();
});
