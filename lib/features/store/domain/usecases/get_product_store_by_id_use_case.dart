import 'package:al_pura_frontend/core/entities/i_use_case.dart';
import 'package:al_pura_frontend/features/store/domain/entities/product_store.dart';
import 'package:al_pura_frontend/features/store/domain/repositories/product_store_repository.dart';

class GetProductStoreByIdUseCase
    implements IUseCase<Future<ProductStore?>, String> {
  final ProductStoreRepository repository;

  const GetProductStoreByIdUseCase({required this.repository});

  @override
  Future<ProductStore?> execute(String value) {
    return repository.getById(value);
  }
}
