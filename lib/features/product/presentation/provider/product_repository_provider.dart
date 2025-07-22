import 'package:al_pura_frontend/features/product/data/repository/firebase_product_repository.dart';
import 'package:al_pura_frontend/features/product/domain/repository/product_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final productRepositoryProvider = Provider<ProductRepository>((ref) {
  return FirebaseProductRepository();
});
