import 'package:al_pura_frontend/core/entities/i_use_case.dart';
import 'package:al_pura_frontend/features/product/domain/entities/stock.dart';
import 'package:al_pura_frontend/features/product/domain/repository/product_store_repository.dart';

class UpdatedProductUseCase implements IUseCase<Future<ProductStore>, ProductStore> {
  final ProductStoreRepository repository;

  const UpdatedProductUseCase({required this.repository});

  @override
  Future<ProductStore> execute(ProductStore updatedProductStore) async{
    return repository.update(updatedProductStore);
  }

}