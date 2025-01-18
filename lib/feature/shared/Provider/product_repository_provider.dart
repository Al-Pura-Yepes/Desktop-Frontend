import 'package:al_pura_frontend/feature/shared/domain/repository/product_repository.dart';
import 'package:al_pura_frontend/feature/shared/infrastructure/datasource/product_datasource_impl.dart';
import 'package:al_pura_frontend/feature/shared/infrastructure/repository/product_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final productRepositoryProvider = Provider<ProductRepository>((ref) {
  return ProductRepositoryImpl(datasource: ProductDatasourceImpl());
});
