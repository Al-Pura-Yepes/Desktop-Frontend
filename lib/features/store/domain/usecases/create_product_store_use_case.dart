import 'package:al_pura_frontend/core/entities/i_use_case.dart';
import 'package:al_pura_frontend/features/product/domain/entities/product.dart';
import 'package:al_pura_frontend/features/product/domain/repository/product_repository.dart';
import 'package:al_pura_frontend/features/product/domain/usecases/get_product_by_id_use_case.dart';
import 'package:al_pura_frontend/features/store/domain/entities/product_store.dart';
import 'package:al_pura_frontend/features/store/domain/repositories/product_store_repository.dart';

class CreateProductStoreUseCase
    implements IUseCase<Future<ProductStore>, String> {
  final ProductStoreRepository repository;
  final ProductRepository productRepository;
  final GetProductByIdUseCase getProductByIdUseCase;

  CreateProductStoreUseCase(
      {required this.repository, required this.productRepository})
      : getProductByIdUseCase =
            GetProductByIdUseCase(repository: productRepository);

  @override
  Future<ProductStore> execute(String value) async {
    final product = await getProductByIdUseCase.execute(value);
    if (product == null) throw Error();
    final productStore = ProductStore(product: product, stock: 0);
    return await repository.create(productStore);
  }
}
