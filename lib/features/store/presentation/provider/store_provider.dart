import 'package:al_pura_frontend/features/product/domain/entities/category.dart';
import 'package:al_pura_frontend/features/product/domain/entities/flavor.dart';
import 'package:al_pura_frontend/features/store/domain/entities/product_store.dart';
import 'package:al_pura_frontend/features/store/domain/repositories/product_store_repository.dart';
import 'package:al_pura_frontend/features/store/domain/usecases/get_all_products_store_order_by_category_and_flavor.dart';
import 'package:al_pura_frontend/features/store/domain/usecases/update_product_store_use_case.dart';
import 'package:al_pura_frontend/features/store/presentation/provider/store_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class StoreState {
  final Map<Category, Map<Flavor, List<ProductStore>>> store;

  const StoreState({this.store = const {}});

  StoreState copyWith({
    Map<Category, Map<Flavor, List<ProductStore>>>? store,
  }) {
    return StoreState(
      store: store ?? this.store,
    );
  }
}

class StoreNotifier extends StateNotifier<StoreState> {
  final ProductStoreRepository repository;

  StoreNotifier({required this.repository}) : super(const StoreState()) {
    loadStore();
  }

  Future<void> loadStore() async {
    final getAllUseCase =
        GetAllProductsStoreOrderByCategoryAndFlavor(repository: repository);
    final productStoreList = await getAllUseCase.execute(null);
    state = state.copyWith(store: productStoreList);
  }

  Future<void> updateProductStore(
      ProductStore productStore, double stock) async {
    final updateUseCase = UpdateProductStoreUseCase(repository: repository);
    productStore = productStore.copyWith(stock: productStore.stock + stock);
    await updateUseCase.execute(productStore);
    final copyStoreState =
        Map<Category, Map<Flavor, List<ProductStore>>>.from(state.store);
    if (copyStoreState[productStore.product.category] != null) {
      copyStoreState[productStore.product.category]![
          productStore.product.flavor] = copyStoreState[
              productStore.product.category]![productStore.product.flavor]!
          .map((element) {
        if (element.id == productStore.id) {
          return productStore;
        }
        return element;
      }).toList();
    }
    state = state.copyWith(store: copyStoreState);
  }
}

final storeProvider = StateNotifierProvider<StoreNotifier, StoreState>((ref) {
  final repository = ref.watch(storeRepositoryProvider);
  return StoreNotifier(repository: repository);
});
