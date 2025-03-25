import 'package:al_pura_frontend/feature/shared/domain/model/product.dart';
import 'package:al_pura_frontend/feature/shared/Provider/product_repository_provider.dart';
import 'package:al_pura_frontend/feature/shared/domain/repository/product_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductsState {
  final Map<String, List<Product>> products;
  final bool isLoading;

  const ProductsState({this.products = const {}, this.isLoading = true});

  ProductsState copyWith({
    bool? isLoading,
    Map<String, List<Product>>? products,
  }) {
    return ProductsState(
      isLoading: isLoading ?? this.isLoading,
      products: products ?? this.products,
    );
  }
}

class ProductsNotifier extends StateNotifier<ProductsState> {
  final ProductRepository repository;

  ProductsNotifier({required this.repository}) : super(const ProductsState()) {
    getAll();
  }

  Future getAll() async {
    try {
      List<Product> fetchProducts = await repository.readAllProduct();
      Map<String, List<Product>> auxList = {...state.products};
      for (Product product in fetchProducts) {
        if (auxList[product.category] == null) {
          auxList[product.category] = [product];
        } else {
          auxList[product.category] = [...auxList[product.category]!, product];
        }
      }
      state = state.copyWith(isLoading: false, products: auxList);
    } catch (e) {
      rethrow;
    }
  }

  Future add(Product product) async {
    try {
      Product? newProduct = await repository.createProduct(product);
      if (newProduct != null) {
        if (state.products[newProduct.category] == null) {
          state = state.copyWith(products: {
            ...state.products,
            newProduct.category: [newProduct]
          });
        } else {
          state = state.copyWith(products: {
            ...state.products,
            newProduct.category: [
              ...state.products[newProduct.category]!,
              newProduct
            ]
          });
        }
      }
    } catch (e) {
      rethrow;
    }
  }

  List<String> getAllCategories() {
    return state.products.keys.toList();
  }
}

final productsProvider =
    StateNotifierProvider<ProductsNotifier, ProductsState>((ref) {
  final repository = ref.read(productRepositoryProvider);
  return ProductsNotifier(repository: repository);
});
