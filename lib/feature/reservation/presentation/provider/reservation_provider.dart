import 'package:al_pura_frontend/feature/reservation/domain/datasource/reservation_datasource.dart';
import 'package:al_pura_frontend/feature/reservation/domain/model/reservation.dart';
import 'package:al_pura_frontend/feature/reservation/domain/repository/reservation_repository.dart';
import 'package:al_pura_frontend/feature/reservation/infrastructure/datasource/reservation_datasource_impl.dart';
import 'package:al_pura_frontend/feature/reservation/infrastructure/repository/reservation_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ReservationState {
  final bool isReservationSelected;
  final int? indexSelected;
  final bool? isStatusAscending;
  final List<Reservation> reservations;
  final Reservation? reservation;
  final DateTime? dayFiltered;

  ReservationState(
      {this.isReservationSelected = false,
      this.isStatusAscending,
      this.indexSelected,
      this.reservations = const [],
      this.reservation,
      this.dayFiltered});

  ReservationState copyWith(
      {bool? isReservationSelected,
      bool? isStatusAscending,
      int? indexSelected,
      List<Reservation>? reservations,
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

  ReservationNotifier(super.state, this.repository);

  toggleReservation() {
    state = state.copyWith(
        isReservationSelected: !state.isReservationSelected,
        isStatusAscending: state.isStatusAscending,
        dayFiltered: state.dayFiltered);
  }

  createReservation(Reservation newReservation) async{
    await repository.createReservation(newReservation);
    state = state.copyWith(
      reservations: [...state.reservations, newReservation]
    );
  }

  changeItemSelected(int index) {
    state = state.copyWith(
        indexSelected: index,
        isReservationSelected: true,
        isStatusAscending: state.isStatusAscending,
        reservation: state.reservations[index],
        dayFiltered: state.dayFiltered);
  }

  changeItemSelectedById(String id) {
    var index =
        state.reservations.indexWhere((reservation) => reservation.id == id);
    state = state.copyWith(
        indexSelected: index,
        isReservationSelected: true,
        isStatusAscending: state.isStatusAscending,
        reservation: state.reservations[index],
        dayFiltered: state.dayFiltered);
  }

  Future<void> loadReservations() async {
    state = state.copyWith(
        reservations: await repository.getAllReservations(
            state.isStatusAscending, state.dayFiltered),
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
  return ReservationNotifier(ReservationState(), repository);
});
