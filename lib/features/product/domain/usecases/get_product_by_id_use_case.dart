import 'package:al_pura_frontend/core/entities/i_use_case.dart';
import 'package:al_pura_frontend/features/product/domain/entities/product.dart';
import 'package:al_pura_frontend/features/product/domain/repository/product_repository.dart';

class GetProductByIdUseCase implements IUseCase<Future<Product?>, String> {
  final ProductRepository repository;

  const GetProductByIdUseCase({required this.repository});

  @override
  Future<Product?> execute(String value) {
    return repository.get(value);
  }
}
