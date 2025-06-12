import 'package:al_pura_frontend/core/entities/i_use_case.dart';
import 'package:al_pura_frontend/features/product/domain/entities/product.dart';
import 'package:al_pura_frontend/features/product/domain/entities/stock.dart';
import 'package:al_pura_frontend/features/product/domain/repository/product_store_repository.dart';

class CreateProductUseCase implements IUseCase<Future<ProductStore>, Product> {
  final ProductStoreRepository repository;

  const CreateProductUseCase({required this.repository});

  @override
  Future<ProductStore> execute(Product value) async{
    return repository.create(value);
  }
}