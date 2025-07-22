import 'package:al_pura_frontend/features/product/domain/entities/product.dart';
import 'package:al_pura_frontend/features/product/domain/repository/product_repository.dart';
import 'package:al_pura_frontend/features/product/domain/usecases/update_product_use_case.dart';
import 'package:al_pura_frontend/features/product/presentation/provider/product_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductsState {
  final Map<String, Product> products;

  const ProductsState({this.products = const {}});

  ProductsState copyWith({
    Map<String, Product>? products,
  }) {
    return ProductsState(
      products: products ?? this.products,
    );
  }
}

class ProductNotifier extends StateNotifier<ProductsState> {
  ProductRepository repository;

  ProductNotifier({required this.repository}) : super(const ProductsState());

  Future<void> updateProduct(Product product) async {
    final updateProductUseCase = UpdatedProductUseCase(repository: repository);
    await updateProductUseCase.execute(product);
  }
}

final productsProvider =
    StateNotifierProvider<ProductNotifier, ProductsState>((ref) {
  final repository = ref.watch(productRepositoryProvider);
  return ProductNotifier(repository: repository);
});
