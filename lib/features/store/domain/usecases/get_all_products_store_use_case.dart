import 'package:al_pura_frontend/core/entities/i_use_case.dart';
import 'package:al_pura_frontend/features/store/domain/entities/product_store.dart';
import 'package:al_pura_frontend/features/store/domain/repositories/product_store_repository.dart';

class GetAllProductStoreUseCase
    implements IUseCase<Future<List<ProductStore>>, void> {
  final ProductStoreRepository repository;

  const GetAllProductStoreUseCase({required this.repository});

  @override
  Future<List<ProductStore>> execute(void _) async {
    return repository.get();
  }
}
