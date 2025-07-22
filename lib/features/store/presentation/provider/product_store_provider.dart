import 'package:al_pura_frontend/features/store/domain/entities/product_store.dart';
import 'package:al_pura_frontend/features/store/domain/repositories/product_store_repository.dart';
import 'package:al_pura_frontend/features/store/domain/usecases/get_product_store_by_id_use_case.dart';
import 'package:al_pura_frontend/features/store/domain/usecases/update_product_store_use_case.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductStoreState {
  final ProductStore? productStore;

  const ProductStoreState({this.productStore});

  ProductStoreState copyWith({
    ProductStore? productStore,
  }) {
    return ProductStoreState(
      productStore: productStore ?? this.productStore,
    );
  }
}

class ProductStoreNotifier extends StateNotifier<ProductStoreState> {
  final String productStoreId;
  final ProductStoreRepository repository;

  ProductStoreNotifier({required this.productStoreId, required this.repository})
      : super(const ProductStoreState());

  Future<void> loadProductStore() async {
    final getByIdUseCase = GetProductStoreByIdUseCase(repository: repository);
    final fetchedProductStore = await getByIdUseCase.execute(productStoreId);
    state = state.copyWith(productStore: fetchedProductStore);
  }

  Future<void> updateProductStore(double stock) async {
    final updateProductStoreUseCase =
        UpdateProductStoreUseCase(repository: repository);
    ProductStore auxProductStore = state.productStore!;
    auxProductStore =
        auxProductStore.copyWith(stock: auxProductStore.stock + stock);
    await updateProductStoreUseCase.execute(auxProductStore);
    state = state.copyWith(productStore: auxProductStore);
  }
}
