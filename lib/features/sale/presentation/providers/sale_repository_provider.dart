import 'package:al_pura_frontend/features/sale/data/repositories/firebase_sale_repository.dart';
import 'package:al_pura_frontend/features/sale/domain/repositories/sale_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final saleRepositoryProvider = Provider<SaleRepository>((ref) {
  return FirebaseSaleRepository();
});
