import 'package:al_pura_frontend/feature/shared/domain/model/product.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CartState {
  final Map<String, (Product, double)> products;
  final bool isDelivery;
  final bool isPerMajor;

  CartState(
      {this.products = const {},
      this.isDelivery = false,
      this.isPerMajor = false});

  CartState copyWith(
      {Map<String, (Product, double)>? products,
      bool? isDelivery,
      bool? isPerMajor}) {
    return CartState(
        products: products ?? this.products,
        isDelivery: isDelivery ?? this.isDelivery,
        isPerMajor: isPerMajor ?? this.isPerMajor);
  }
}

class CartNotifier extends StateNotifier<CartState> {
  CartNotifier() : super(CartState());

  void addItemToCart(Product product) {
    state =
        state.copyWith(products: {...state.products, product.id: (product, 1)});
  }

  void deleteItemFromCart(Product product) {
    Map<String, (Product, double)> auxMap = {...state.products};
    auxMap.remove(product.id);
    state = state.copyWith(products: {...auxMap});
  }

  void setItemQuantity(Product product, int newQuantity) {
    if (state.products.containsKey(product.id)) {
      final auxMap = {...state.products};
      final (lastProduct, _) = auxMap[product.id]!;
      auxMap[product.id] = (lastProduct, newQuantity.toDouble());
      state = state.copyWith(products: {...auxMap});
    }
  }
}

final cartProvider = StateNotifierProvider<CartNotifier, CartState>((ref) {
  return CartNotifier();
});
