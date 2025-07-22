import 'package:al_pura_frontend/features/product/domain/entities/product.dart';
import 'package:al_pura_frontend/features/product/domain/repository/product_repository.dart';
import 'package:al_pura_frontend/features/product/domain/usecases/get_product_by_id_use_case.dart';
import 'package:al_pura_frontend/features/product/domain/usecases/update_product_use_case.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductState {
  final Product? product;

  const ProductState({this.product});

  ProductState copyWith({
    Product? product,
  }) {
    return ProductState(
      product: product ?? this.product,
    );
  }
}

class ProductNotifier extends StateNotifier<ProductState> {
  String productId;
  ProductRepository repository;

  ProductNotifier({required this.productId, required this.repository})
      : super(const ProductState());

  Future<void> loadProduct() async {
    final getByIdUseCase = GetProductByIdUseCase(repository: repository);
    final fetchedProduct = await getByIdUseCase.execute(productId);
    state = state.copyWith(product: fetchedProduct);
  }

  Future<void> updateProduct(Product product) async {
    final updateProductUseCase = UpdatedProductUseCase(repository: repository);
    await updateProductUseCase.execute(product);
    state = state.copyWith(product: product);
  }
}
