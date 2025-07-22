import 'package:al_pura_frontend/core/entities/i_use_case.dart';
import 'package:al_pura_frontend/features/product/domain/entities/product.dart';
import 'package:al_pura_frontend/features/product/domain/repository/product_repository.dart';

class CreateProductUseCase implements IUseCase<Future<Product>, Product> {
  final ProductRepository repository;

  const CreateProductUseCase({required this.repository});

  @override
  Future<Product> execute(Product value) async {
    return repository.create(value);
  }
}
