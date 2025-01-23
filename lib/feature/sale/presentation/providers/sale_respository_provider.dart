import 'package:al_pura_frontend/feature/sale/domain/repository/sale_repository.dart';
import 'package:al_pura_frontend/feature/sale/infrastructure/datasource/sale_datasource_firebase.dart';
import 'package:al_pura_frontend/feature/sale/infrastructure/repository/sale_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final saleRepositoryProvider = Provider<SaleRepository>((ref) {
  return SaleRepositoryImpl(datasource: SaleDatasourceFirebase());
});
