import 'package:al_pura_frontend/core/entities/i_use_case.dart';
import 'package:al_pura_frontend/features/store/domain/entities/product_store.dart';
import 'package:al_pura_frontend/features/store/domain/repositories/product_store_repository.dart';

class UpdateProductStoreUseCase
    implements IUseCase<Future<void>, ProductStore> {
  final ProductStoreRepository repository;

  const UpdateProductStoreUseCase({required this.repository});

  @override
  Future<void> execute(ProductStore value) async {
    return await repository.update(value);
  }
}
