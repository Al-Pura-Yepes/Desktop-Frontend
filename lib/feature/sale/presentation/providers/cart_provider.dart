import 'package:al_pura_frontend/feature/sale/domain/model/sale.dart';
import 'package:al_pura_frontend/feature/sale/domain/repository/sale_repository.dart';
import 'package:al_pura_frontend/feature/sale/presentation/providers/sale_respository_provider.dart';
import 'package:al_pura_frontend/feature/shared/domain/model/product.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CartState {
  final Map<String, (Product, double)> products;
  final bool isDelivery;
  final bool isPerMajor;
  final double totalPrice;
  final double discount;

  CartState(
      {this.products = const {},
      this.isDelivery = false,
      this.isPerMajor = false,
      this.totalPrice = 0,
        this.discount = 0,
      });

  CartState copyWith(
      {Map<String, (Product, double)>? products,
      bool? isDelivery,
      bool? isPerMajor,
      double? totalPrice,
      double? discount}) {
    return CartState(
        products: products ?? this.products,
        isDelivery: isDelivery ?? this.isDelivery,
        isPerMajor: isPerMajor ?? this.isPerMajor,
        totalPrice: totalPrice ?? this.totalPrice,
        discount: discount ?? this.discount);
  }
}

class CartNotifier extends StateNotifier<CartState> {

  final SaleRepository repository;

  CartNotifier({required this.repository}) : super(CartState());

  void addItemToCart(Product product) {
    state =
        state.copyWith(
            products: {...state.products, product.id: (product, 1)},
            totalPrice: state.totalPrice + (product.price ?? 0)
        );
  }

  void deleteItemFromCart(Product product) {
    Map<String, (Product, double)> auxMap = {...state.products};
    final (finalProduct, quantity) = auxMap.remove(product.id)!;
    state = state.copyWith(
        products: {...auxMap},
        totalPrice: state.totalPrice - ((finalProduct.price ?? 0) * quantity)
    );
  }

  void setItemQuantity(Product product, int newQuantity) {
    if (state.products.containsKey(product.id)) {
      final auxMap = {...state.products};
      final (lastProduct, lastQuantity) = auxMap[product.id]!;
      auxMap[product.id] = (lastProduct, newQuantity.toDouble());
      state = state.copyWith(
          products: {...auxMap},
          totalPrice: lastQuantity < newQuantity
              ? state.totalPrice + ((product.price ?? 0) * (newQuantity - lastQuantity))
              : state.totalPrice - ((product.price ?? 0) * (lastQuantity - newQuantity))
      );
    }
  }

  void saleByCash() async {
    await repository.createSale(Sale(
        products: {},
        isDelivery: state.isDelivery,
        isPerMajor: state.isPerMajor,
        totalPrice: state.totalPrice,
        discount: state.discount
    ));
  }
}

final cartProvider = StateNotifierProvider<CartNotifier, CartState>((ref) {

  final repository = ref.read(saleRepositoryProvider);

  return CartNotifier(repository: repository);
});
