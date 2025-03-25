
import 'package:al_pura_frontend/feature/sale/domain/model/sale.dart';
import 'package:al_pura_frontend/feature/sale/domain/repository/sale_repository.dart';
import 'package:al_pura_frontend/feature/sale/presentation/providers/sale_respository_provider.dart';
import 'package:al_pura_frontend/feature/sale/presentation/widget/sale_information_back.dart';
import 'package:al_pura_frontend/feature/sale/presentation/widget/sale_information_front.dart';
import 'package:al_pura_frontend/feature/shared/domain/model/product.dart';
import 'package:al_pura_frontend/feature/shared/widget/toasts/custom_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CartState {
  final Map<Product, double> products;
  final bool isDelivery;
  final bool isPerMajor;
  final double totalPrice;
  final double discount;
  final Widget widgetOption;
  final Widget lastWidget;
  final bool isReservation;
  final String? clientName;
  final String? clientPhone;
  final bool isByCash;
  final DateTime? reservationDate;
  final DateTime? saleDate;
  final Map<String, double> variablesItems;

  CartState(
      {this.products = const {},
      this.isDelivery = false,
      this.isPerMajor = false,
      this.totalPrice = 0,
      this.discount = 0,
      this.widgetOption = const SaleInformationFront(),
      this.lastWidget = const SaleInformationFront(),
      this.isReservation = false,
      this.clientName,
      this.clientPhone,
      this.isByCash = true,
      this.reservationDate,
      this.saleDate,
      this.variablesItems = const {}
      });

  CartState copyWith(
      {Map<Product, double>? products,
      bool? isDelivery,
      bool? isPerMajor,
      double? totalPrice,
      double? discount,
      Widget? widgetOption,
      Widget? lastWidget,
      bool? isReservation,
      String? clientName,
      String? clientPhone,
      bool? isByCash,
      DateTime? reservationDate,
      DateTime? saleDate,
      Map<String, double>? variableItems}) {
    return CartState(
        products: products ?? this.products,
        isDelivery: isDelivery ?? this.isDelivery,
        isPerMajor: isPerMajor ?? this.isPerMajor,
        totalPrice: totalPrice ?? this.totalPrice,
        discount: discount ?? this.discount,
        widgetOption: widgetOption ?? this.widgetOption,
        lastWidget: lastWidget ?? this.lastWidget,
        isReservation: isReservation ?? this.isReservation,
        clientName: clientName ?? this.clientName,
        clientPhone: clientPhone ?? this.clientPhone,
        isByCash: isByCash ?? this.isByCash,
        reservationDate: reservationDate ?? this.reservationDate,
        saleDate: saleDate ?? this.saleDate,
        variablesItems: variableItems ?? this.variablesItems);
  }
}

class CartNotifier extends StateNotifier<CartState> {
  final SaleRepository repository;

  CartNotifier({required this.repository}) : super(CartState());

  void addItemToCart(Product product) {
    if (state.widgetOption is SaleInformationFront ||
        state.widgetOption is SaleInformationBack) {
      if (state.products[product] == null) {

        if (product.weight == null){
          state = state.copyWith(
            variableItems: {...state.variablesItems, product.id: 0}
          );
        }

        state = state.copyWith(
            products: {
              ...state.products,
              product: product.weight == null ? 0 : 1
            },
            totalPrice: state.totalPrice +
                (product.weight == null ? 0 : product.price!));
      }
    }
  }

  void deleteItemFromCart(Product product) {
    if (state.widgetOption is SaleInformationFront ||
        state.widgetOption is SaleInformationBack) {
      Map<Product, double> auxMap = {...state.products};
      final quantity = auxMap.remove(product)!;

      if (product.weight == null){
        final auxVariableMap = {...state.variablesItems};
        auxVariableMap.remove(product.id);
        state = state.copyWith(
            variableItems: {...auxVariableMap}
        );
      }

      state = state.copyWith(
          products: {...auxMap},
          totalPrice: product.weight == null
              ? state.totalPrice - quantity
              : state.totalPrice - ((product.price ?? 0) * quantity));
    }
  }

  void setItemQuantity(Product product, int newQuantity) {
    if (state.widgetOption is SaleInformationFront ||
        state.widgetOption is SaleInformationBack) {
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

  void setItemPrice(Product product, int newPrice) {
    if (state.widgetOption is SaleInformationFront ||
        state.widgetOption is SaleInformationBack) {
      if (state.products.containsKey(product)) {
        final auxMap = {...state.products};
        final lastPrice = auxMap[product]!;
        auxMap[product] = newPrice.toDouble();

        final auxVariableMap = {...state.variablesItems};
        auxVariableMap[product.id] = newPrice / product.price!.toDouble();

        state = state.copyWith(
            products: {...auxMap},
            variableItems: {...auxVariableMap},
            totalPrice: state.totalPrice - lastPrice + newPrice);
      }
    }
  }

  void sale() async {
    await repository.createSale(Sale(
        products: state.products,
        isDelivery: state.isDelivery,
        isPerMajor: state.isPerMajor,
        totalPrice: state.totalPrice,
        discount: state.discount,
        isReservation: state.isReservation,
        clientName: state.clientName,
        clientPhone: state.clientPhone,
        isByCash: state.isByCash,
        reservationDate: state.reservationDate,
        saleDate: state.saleDate ?? DateTime.now()));
  }

  void changeWidgetOption(Widget newOption, {BuildContext? context}) {
    if (state.products.isEmpty) {
      if (context != null){
        CustomToast.showToastNotification(
            context,
            icon: const Icon(Icons.error),
            title: 'Carrito vacio',
            description: 'Ingresa productos al carrito',
            bgColor: Colors.red
        );
      }
      return;
    }

    for (double value in state.variablesItems.values){
      if (value == 0 && context != null){
        CustomToast.showToastNotification(
            context,
            icon: const Icon(Icons.error),
            title: 'Productos sin precio',
            description: 'Revisa el carrito, hay productos sin precio',
            bgColor: Colors.red
        );
        return;
      }
    }

    state =
        state.copyWith(lastWidget: state.widgetOption, widgetOption: newOption);
  }

  void setIsReservation(bool status) {
    state = state.copyWith(isReservation: status);
  }

  void toggleIsDelivery() {
    state = state.copyWith(isDelivery: !state.isDelivery);
  }

  void toggleIsPerMajor() {
    state = state.copyWith(isPerMajor: !state.isPerMajor);
  }

  void resetCart() {
    state = state.copyWith(
        products: const {},
        isDelivery: false,
        isPerMajor: false,
        totalPrice: 0,
        discount: 0,
        widgetOption: const SaleInformationFront(),
        lastWidget: const SaleInformationFront(),
        saleDate: null,
        reservationDate: null,
        isByCash: true,
        clientPhone: null,
        clientName: null,
        isReservation: false);
  }

  void setClientName(String newClientName) {
    state = state.copyWith(clientName: newClientName);
  }

  void setClientPhone(String newClientPhone) {
    state = state.copyWith(clientPhone: newClientPhone);
  }

  void setPaymentMethod(bool newIsByCash) {
    state = state.copyWith(isByCash: newIsByCash);
  }

  void setReservationDate(DateTime date) {}
}

final cartProvider = StateNotifierProvider<CartNotifier, CartState>((ref) {
  final repository = ref.read(saleRepositoryProvider);

  return CartNotifier(repository: repository);
});
