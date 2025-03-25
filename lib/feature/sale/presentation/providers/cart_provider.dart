import 'package:al_pura_frontend/feature/reservation/domain/model/reservation.dart';
import 'package:al_pura_frontend/feature/reservation/domain/model/status.dart';
import 'package:al_pura_frontend/feature/reservation/presentation/provider/reservation_provider.dart';
import 'package:al_pura_frontend/feature/sale/domain/repository/sale_repository.dart';
import 'package:al_pura_frontend/feature/sale/presentation/providers/sale_respository_provider.dart';
import 'package:al_pura_frontend/feature/sale/presentation/widget/confirm_sale.dart';
import 'package:al_pura_frontend/feature/sale/presentation/widget/sale_information_back.dart';
import 'package:al_pura_frontend/feature/sale/presentation/widget/sale_information_front.dart';
import 'package:al_pura_frontend/feature/shared/Provider/products_provider.dart';
import 'package:al_pura_frontend/feature/shared/domain/model/product.dart';
import 'package:al_pura_frontend/feature/shared/domain/model/user.dart';
import 'package:al_pura_frontend/feature/shared/widget/toasts/custom_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/model/sale.dart';

class CartState {
  final Map<Product, double> products;
  final bool isDelivery;
  final bool isPerMajor;
  final double totalPrice;
  final double discount;
  final double subtotal;
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
      this.subtotal = 0,
      this.widgetOption = const SaleInformationFront(),
      this.lastWidget = const SaleInformationFront(),
      this.isReservation = false,
      this.clientName,
      this.clientPhone,
      this.isByCash = true,
      this.reservationDate,
      this.saleDate,
      this.variablesItems = const {}});

  CartState resetValues() {
    return CartState(
        products: const {},
        isDelivery: false,
        isPerMajor: false,
        totalPrice: 0,
        discount: 0,
        subtotal: 0,
        widgetOption: const SaleInformationFront(),
        lastWidget: const SaleInformationFront(),
        saleDate: null,
        reservationDate: null,
        isByCash: true,
        clientPhone: null,
        clientName: null,
        isReservation: false);
  }

  CartState copyWith(
      {Map<Product, double>? products,
      bool? isDelivery,
      bool? isPerMajor,
      double? totalPrice,
      double? discount,
      double? subtotal,
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
        subtotal: subtotal ?? this.subtotal,
        variablesItems: variableItems ?? variablesItems);
  }
}

class CartNotifier extends StateNotifier<CartState> {
  final SaleRepository saleRepository;
  final void Function(Reservation reservation) createReservationCallback;
  final void Function(Map<Product, double>) decreaseItemsCallback;

  CartNotifier(
      {required this.saleRepository,
      required this.decreaseItemsCallback,
      required this.createReservationCallback})
      : super(CartState());

  void addItemToCart(Product product) {
    if (state.widgetOption is SaleInformationFront) {
      if (state.products[product] == null) {
        if (product.weight == null) {
          state = state.copyWith(
              variableItems: {...state.variablesItems, product.id: 0});
        }

        state = state.copyWith(
            products: {
              ...state.products,
              product: product.weight == null ? 0 : 1
            },
            subtotal:
                state.subtotal + (product.weight == null ? 0 : product.price!),
            totalPrice: state.totalPrice +
                state.discount +
                (product.weight == null ? 0 : product.price!) -
                state.discount);
      }
    }
  }

  void deleteItemFromCart(Product product) {
    if (state.widgetOption is SaleInformationFront) {
      Map<Product, double> auxMap = {...state.products};
      final quantity = auxMap.remove(product)!;

      if (product.weight == null) {
        final auxVariableMap = {...state.variablesItems};
        auxVariableMap.remove(product.id);
        state = state.copyWith(variableItems: {...auxVariableMap});
      }

      state = state.copyWith(
          products: {...auxMap},
          subtotal: product.weight == null
              ? state.subtotal - quantity
              : state.subtotal - ((product.price ?? 0) * quantity),
          totalPrice: product.weight == null
              ? state.totalPrice - quantity
              : state.totalPrice - ((product.price ?? 0) * quantity));
    }
  }

  void setItemQuantity(Product product, int newQuantity) {
    if (state.widgetOption is SaleInformationFront) {
      if (state.products.containsKey(product)) {
        final auxMap = {...state.products};
        final lastQuantity = auxMap[product]!;
        auxMap[product] = newQuantity.toDouble();
        state = state.copyWith(
            products: {...auxMap},
            subtotal: lastQuantity < newQuantity
                ? state.subtotal +
                    ((product.price ?? 0) * (newQuantity - lastQuantity))
                : state.subtotal -
                    ((product.price ?? 0) * (lastQuantity - newQuantity)),
            totalPrice: lastQuantity < newQuantity
                ? state.totalPrice +
                    ((product.price ?? 0) * (newQuantity - lastQuantity)) -
                    state.discount
                : state.totalPrice -
                    ((product.price ?? 0) * (lastQuantity - newQuantity)) -
                    state.discount);
      }
    }
  }

  void setItemPrice(Product product, int newPrice) {
    if (state.widgetOption is SaleInformationFront) {
      if (state.products.containsKey(product)) {
        final auxMap = {...state.products};
        final lastPrice = auxMap[product]!;
        auxMap[product] = newPrice.toDouble();

        final auxVariableMap = {...state.variablesItems};
        auxVariableMap[product.id] = newPrice / product.price!.toDouble();

        state = state.copyWith(
            products: {...auxMap},
            variableItems: {...auxVariableMap},
            subtotal: state.subtotal - lastPrice + newPrice,
            totalPrice: state.totalPrice +
                state.discount -
                lastPrice +
                newPrice -
                state.discount);
      }
    }
  }

  Map<Product, double> getItemsCorrectFormat() {
    Map<Product, double> correctItems = {};
    for (final entry in state.products.entries) {
      if (entry.key.weight == null) {
        correctItems[entry.key] = state.variablesItems[entry.key.id]!;
      } else {
        correctItems[entry.key] = entry.value;
      }
    }
    return correctItems;
  }

  void sale() async {
    if (state.isReservation) {
      createReservationCallback(Reservation(
          client: User(
              id: "",
              fullName: state.clientName ?? "",
              phoneNumber: int.tryParse(state.clientPhone ?? "0") ?? 0),
          deliveryDate: state.reservationDate!,
          discount: state.discount,
          totalPrice: state.totalPrice,
          status: Status.pending,
          isDelivery: state.isDelivery,
          isPerMajor: state.isPerMajor,
          isActive: true,
          products: state.products.keys.toList()));
    } else {
      await saleRepository.createSale(Sale(
          products: state.products,
          isDelivery: state.isDelivery,
          isPerMajor: state.isPerMajor,
          totalPrice: state.totalPrice - state.discount,
          discount: state.discount,
          isReservation: state.isReservation,
          clientName: state.clientName,
          clientPhone: state.clientPhone,
          isByCash: state.isByCash,
          reservationDate: state.reservationDate,
          saleDate: state.saleDate ?? DateTime.now()));
      decreaseItemsCallback(getItemsCorrectFormat());
    }
  }

  void changeWidgetOption(Widget newOption, {BuildContext? context}) {
    if (state.products.isEmpty) {
      if (context != null) {
        CustomToast.showToastNotification(context,
            icon: const Icon(Icons.error),
            title: 'Carrito vacio',
            description: 'Ingresa productos al carrito',
            bgColor: Colors.red);
      }
      return;
    }

    if (newOption is SaleInformationBack || newOption is ConfirmSale) {
      for (double value in state.variablesItems.values) {
        if (value == 0 && context != null) {
          CustomToast.showToastNotification(context,
              icon: const Icon(Icons.error),
              title: 'Productos sin precio',
              description: 'Revisa el carrito, hay productos sin precio',
              bgColor: Colors.red);
          return;
        }
      }
    }

    if (newOption is ConfirmSale && state.isReservation) {
      if (state.reservationDate == null && context != null) {
        CustomToast.showToastNotification(context,
            icon: const Icon(Icons.error),
            title: 'Ingresa la fecha de reserva',
            description: 'Debes introducir la fecha par la reserva',
            bgColor: Colors.red);
        return;
      }
    }

    if (newOption is ConfirmSale && (state.isReservation || state.isDelivery)) {
      if ((state.clientName == null || state.clientName == "") &&
          context != null) {
        CustomToast.showToastNotification(context,
            icon: const Icon(Icons.error),
            title: 'Ingresa el nombre del cliente',
            description: 'Debes introducir el nombre del cliente',
            bgColor: Colors.red);
        return;
      }
    }

    if (newOption is SaleInformationBack || newOption is ConfirmSale) {
      for (var entry in state.products.entries) {
        if ((entry.key.quantity < entry.value) &&
            context != null &&
            entry.key.weight != null) {
          CustomToast.showToastNotification(context,
              icon: const Icon(Icons.warning),
              title: 'Producto sin stock',
              description: 'Estas agregando productos sin tenerlos en stock',
              bgColor: Colors.deepOrangeAccent);
          break;
        }
      }
    }

    state =
        state.copyWith(lastWidget: state.widgetOption, widgetOption: newOption);
  }

  void setIsReservation(bool status) {
    state = state.copyWith(isReservation: status);
  }

  void decrementQuantity(double discount) {
    state = state.copyWith(
        discount: discount, totalPrice: state.subtotal - discount);
  }

  void toggleIsDelivery() {
    state = state.copyWith(isDelivery: !state.isDelivery);
  }

  void toggleIsPerMajor() {
    state = state.copyWith(isPerMajor: !state.isPerMajor);
  }

  void resetCart() {
    state = state.resetValues();
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

  void setReservationDate(DateTime date) {
    state = state.copyWith(reservationDate: date);
  }
}

final cartProvider = StateNotifierProvider<CartNotifier, CartState>((ref) {
  final repository = ref.read(saleRepositoryProvider);
  final reservationCallback =
      ref.read(reservationProvider.notifier).createReservation;
  final callback = ref.read(productsProvider.notifier).decrementItemsByCart;
  return CartNotifier(
      saleRepository: repository,
      decreaseItemsCallback: callback,
      createReservationCallback: reservationCallback);
});
