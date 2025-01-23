import 'package:al_pura_frontend/feature/sale/domain/model/sale.dart';
import 'package:al_pura_frontend/feature/sale/domain/repository/sale_repository.dart';
import 'package:al_pura_frontend/feature/sale/presentation/providers/sale_respository_provider.dart';
import 'package:al_pura_frontend/feature/sale/presentation/widget/sale_information_back.dart';
import 'package:al_pura_frontend/feature/sale/presentation/widget/sale_information_front.dart';
import 'package:al_pura_frontend/feature/shared/domain/model/product.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CartState {
  final Map<Product, double> products;
  final bool isDelivery;
  final bool isPerMajor;
  final double totalPrice;
  final double discount;
  final Widget widgetOption;
  final Widget lastWidget;

  CartState(
      {this.products = const {},
      this.isDelivery = false,
      this.isPerMajor = false,
      this.totalPrice = 0,
      this.discount = 0,
      this.widgetOption = const SaleInformationFront(),
      this.lastWidget = const SaleInformationFront()});

  CartState copyWith(
      {Map<Product, double>? products,
      bool? isDelivery,
      bool? isPerMajor,
      double? totalPrice,
      double? discount,
      Widget? widgetOption,
        Widget? lastWidget}) {
    return CartState(
        products: products ?? this.products,
        isDelivery: isDelivery ?? this.isDelivery,
        isPerMajor: isPerMajor ?? this.isPerMajor,
        totalPrice: totalPrice ?? this.totalPrice,
        discount: discount ?? this.discount,
        widgetOption: widgetOption ?? this.widgetOption,
        lastWidget: lastWidget ?? this.lastWidget);
  }
}

class CartNotifier extends StateNotifier<CartState> {
  final SaleRepository repository;

  CartNotifier({required this.repository}) : super(CartState());

  void addItemToCart(Product product) {
    if (state.widgetOption is SaleInformationFront || state.widgetOption is SaleInformationBack){
      if (state.products[product] == null) {
        state = state.copyWith(
            products: {...state.products, product: 1},
            totalPrice: state.totalPrice + (product.price ?? 0));
      }
    }

  }

  void deleteItemFromCart(Product product) {
    if (state.widgetOption is SaleInformationFront || state.widgetOption is SaleInformationBack) {
      Map<Product, double> auxMap = {...state.products};
      final quantity = auxMap.remove(product)!;
      state = state.copyWith(
          products: {...auxMap},
          totalPrice: state.totalPrice - ((product.price ?? 0) * quantity));
    }
  }

  void setItemQuantity(Product product, int newQuantity) {
    if (state.widgetOption is SaleInformationFront || state.widgetOption is SaleInformationBack) {
      if (state.products.containsKey(product)) {
        final auxMap = {...state.products};
        final lastQuantity = auxMap[product]!;
        auxMap[product] = newQuantity.toDouble();
        state = state.copyWith(
            products: {...auxMap},
            totalPrice: lastQuantity < newQuantity
                ? state.totalPrice +
                ((product.price ?? 0) * (newQuantity - lastQuantity))
                : state.totalPrice -
                ((product.price ?? 0) * (lastQuantity - newQuantity)));
      }
    }
  }

  void saleByCash() async {
    if (state.isDelivery) {
      state = state.copyWith(widgetOption: SaleInformationBack());
    }

    await repository.createSale(Sale(
        products: state.products,
        isDelivery: state.isDelivery,
        isPerMajor: state.isPerMajor,
        totalPrice: state.totalPrice,
        discount: state.discount));
  }

  void changeWidgetOption(Widget newOption) {

    if (state.products.isEmpty) return;

    state = state.copyWith(
        lastWidget: state.widgetOption,
        widgetOption: newOption
    );
  }

  void toggleIsDelivery() {
    state = state.copyWith(isDelivery: !state.isDelivery);
  }

  void toggleIsPerMajor() {
    state = state.copyWith(isPerMajor: !state.isPerMajor);
  }

  void resetCart(){
    state = state.copyWith(
        products : const {},
        isDelivery : false,
        isPerMajor : false,
        totalPrice : 0,
        discount : 0,
        widgetOption : const SaleInformationFront(),
        lastWidget : const SaleInformationFront()
    );
  }
}

final cartProvider = StateNotifierProvider<CartNotifier, CartState>((ref) {
  final repository = ref.read(saleRepositoryProvider);

  return CartNotifier(repository: repository);
});
