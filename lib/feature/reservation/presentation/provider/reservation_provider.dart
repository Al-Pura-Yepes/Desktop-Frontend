import 'package:al_pura_frontend/feature/history/presentation/provider/sales_provider.dart';
import 'package:al_pura_frontend/feature/reservation/domain/datasource/reservation_datasource.dart';
import 'package:al_pura_frontend/feature/reservation/domain/model/reservation.dart';
import 'package:al_pura_frontend/feature/reservation/domain/repository/reservation_repository.dart';
import 'package:al_pura_frontend/feature/reservation/infrastructure/datasource/reservation_datasource_impl.dart';
import 'package:al_pura_frontend/feature/reservation/infrastructure/repository/reservation_repository_impl.dart';
import 'package:al_pura_frontend/feature/sale/domain/model/sale.dart';
import 'package:al_pura_frontend/feature/sale/presentation/providers/sale_respository_provider.dart';
import 'package:al_pura_frontend/feature/shared/Provider/products_provider.dart';
import 'package:al_pura_frontend/feature/shared/domain/model/product.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ReservationState {
  final bool isReservationSelected;
  final String? indexSelected;
  final bool? isStatusAscending;
  final Map<String, Reservation> reservations;
  final Reservation? reservation;
  final DateTime? dayFiltered;

  ReservationState(
      {this.isReservationSelected = false,
      this.isStatusAscending,
      this.indexSelected,
      this.reservations = const {},
      this.reservation,
      this.dayFiltered});

  ReservationState copyWith(
      {bool? isReservationSelected,
      bool? isStatusAscending,
      String? indexSelected,
      Map<String, Reservation>? reservations,
      Reservation? reservation,
      DateTime? dayFiltered}) {
    return ReservationState(
        isReservationSelected:
            isReservationSelected ?? this.isReservationSelected,
        isStatusAscending: isStatusAscending,
        indexSelected: indexSelected ?? this.indexSelected,
        reservations: reservations ?? this.reservations,
        reservation: reservation ?? this.reservation,
        dayFiltered: dayFiltered);
  }
}

class ReservationNotifier extends StateNotifier<ReservationState> {
  final ReservationRepository repository;
  final void Function(Map<Product, double>) increaseItemsProductCallback;
  final void Function(Map<Product, double>) decreaseItemsProductCallback;
  final void Function(Sale) createSale;

  ReservationNotifier(super.state, this.repository,
      this.increaseItemsProductCallback, this.decreaseItemsProductCallback, this.createSale);

  toggleReservation() {
    state = state.copyWith(
        isReservationSelected: !state.isReservationSelected,
        isStatusAscending: state.isStatusAscending,
        dayFiltered: state.dayFiltered);
  }

  createReservation(Reservation newReservation) async {
    await repository.createReservation(newReservation);
    state = state.copyWith(reservations: {
      ...state.reservations,
      newReservation.id: newReservation
    });
  }

  changeItemSelected(String id) {
    state = state.copyWith(
        indexSelected: id,
        isReservationSelected: true,
        isStatusAscending: state.isStatusAscending,
        reservation: state.reservations[id],
        dayFiltered: state.dayFiltered);
  }

  increaseItemsFromInventory() {
    Map<Product, double> auxMap = {};
    if (state.reservation != null) {
      for (final product in state.reservation!.products) {
        auxMap[product] = product.quantity;
      }
      increaseItemsProductCallback(auxMap);
    }
  }

  makeTheSale(bool isByCash) async {
    try {
      final Map<Product, double> auxSaleItemsMap = {};
      for (Product product in state.reservation?.products ?? []){
        auxSaleItemsMap[product] = product.quantity;
      }
      if (state.reservation == null) throw Exception("The reservation is null");
      createSale(
          Sale(
              products: auxSaleItemsMap,
              isDelivery: state.reservation!.isDelivery,
              isPerMajor: state.reservation!.isPerMajor,
              totalPrice: state.reservation!.totalPrice,
              discount: state.reservation!.discount,
              isReservation: true,
              isByCash: isByCash,
              saleDate: DateTime.now(),

              reservationDate: state.reservation!.deliveryDate,
              clientName: state.reservation!.client.fullName,
              clientPhone: state.reservation!.client.phoneNumber.toString(),
          )
      );
      decreaseItemsProductCallback(auxSaleItemsMap);
    } catch (e){
      rethrow;
    }
  }

  decreaseItemsFromInventory() {
    Map<Product, double> auxMap = {};
    if (state.reservation != null) {
      for (final product in state.reservation!.products) {
        auxMap[product] = product.quantity;
      }
      decreaseItemsProductCallback(auxMap);
    }
  }

  Future<void> loadReservations() async {
    final Map<String, Reservation> auxReservationList = {};
    for (final res in await repository.getAllReservations(
        state.isStatusAscending, state.dayFiltered)) {
      auxReservationList[res.id] = res;
    }
    state = state.copyWith(
        reservations: auxReservationList,
        isStatusAscending: state.isStatusAscending,
        dayFiltered: state.dayFiltered);
  }

  iterateSortByStatus() {
    bool? filterStatus;
    if (state.isStatusAscending == null) {
      filterStatus = true;
    } else if (state.isStatusAscending == true) {
      filterStatus = false;
    } else if (state.isStatusAscending == false) {
      filterStatus = null;
    }
    state = state.copyWith(
        isStatusAscending: filterStatus, dayFiltered: state.dayFiltered);
  }

  updateReservation(Reservation reservation) {
    state = state.copyWith(
        reservation: reservation,
        isStatusAscending: state.isStatusAscending,
        dayFiltered: state.dayFiltered);
  }

  clearReservations() {
    state = state.copyWith(
        reservation: null,
        indexSelected: null,
        isReservationSelected: false,
        dayFiltered: state.dayFiltered);
  }

  selectDay(DateTime? day) {
    state = state.copyWith(dayFiltered: day);
  }
}

final reservationProvider =
    StateNotifierProvider<ReservationNotifier, ReservationState>((ref) {
  final ReservationDatasource datasource = ReservationDatasourceImpl();
  final ReservationRepository repository =
      ReservationRepositoryImpl(datasource: datasource);
  final increaseItemsCallback =
      ref.read(productsProvider.notifier).incrementItemsByCart;
  final decreaseItemsCallback =
      ref.read(productsProvider.notifier).decrementItemsByCart;

  final saleCallback = ref.read(saleRepositoryProvider).createSale;

  return ReservationNotifier(ReservationState(), repository,
      increaseItemsCallback, decreaseItemsCallback, saleCallback);
});
