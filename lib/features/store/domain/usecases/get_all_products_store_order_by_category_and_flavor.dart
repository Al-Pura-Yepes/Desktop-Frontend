import 'package:al_pura_frontend/core/entities/i_use_case.dart';
import 'package:al_pura_frontend/features/product/data/repository/local_category_repository.dart';
import 'package:al_pura_frontend/features/product/domain/entities/category.dart';
import 'package:al_pura_frontend/features/product/domain/entities/flavor.dart';
import 'package:al_pura_frontend/features/store/domain/entities/product_store.dart';
import 'package:al_pura_frontend/features/store/domain/repositories/product_store_repository.dart';

class GetAllProductsStoreOrderByCategoryAndFlavor
    implements
        IUseCase<Future<Map<Category, Map<Flavor, List<ProductStore>>>>, void> {
  final ProductStoreRepository repository;

  const GetAllProductsStoreOrderByCategoryAndFlavor({required this.repository});

  @override
  Future<Map<Category, Map<Flavor, List<ProductStore>>>> execute(
      void value) async {
    Map<Category, Map<Flavor, List<ProductStore>>> result = {};

    //CAMBIAR POR EL USECASE DE GET ALL
    final fetchProducts = await repository.get();

    for (final productStore in fetchProducts) {
      if (result[productStore.product.category] == null) {
        result[productStore.product.category] = {};
      }
      if (result[productStore.product.category]![productStore.product.flavor] ==
          null) {
        result[productStore.product.category]![productStore.product.flavor] = [
          productStore
        ];
      } else {
        result[productStore.product.category]![productStore.product.flavor] = [
          ...result[productStore.product.category]![
              productStore.product.flavor]!,
          productStore
        ];
      }
    }

    return result;
  }
}
