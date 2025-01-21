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

  ReservationState({
    this.isReservationSelected = false,
    this.isStatusAscending,
    this.indexSelected,
    this.reservations = const [],
    this.reservation
  });

  ReservationState copyWith({
    bool? isReservationSelected,
    bool? isStatusAscending,
    int? indexSelected,
    List<Reservation>? reservations,
    Reservation? reservation
  }) {
    return ReservationState(
      isReservationSelected: isReservationSelected ?? this.isReservationSelected,
      isStatusAscending: isStatusAscending,
      indexSelected: indexSelected ?? this.indexSelected,
      reservations: reservations ?? this.reservations,
      reservation: reservation ?? this.reservation
    );
  }
}

class ReservationNotifier extends StateNotifier<ReservationState> {
  final ReservationRepository repository;

  ReservationNotifier(super.state, this.repository);

  toggleReservation() {
    state = state.copyWith(
        isReservationSelected: !state.isReservationSelected,
        isStatusAscending: state.isStatusAscending
    );
  }

  changeItemSelected(int index) {
    state = state.copyWith(
        indexSelected: index,
        isReservationSelected: true,
        isStatusAscending: state.isStatusAscending,
        reservation: state.reservations[index]
    );
  }

  changeItemSelectedById(String id) {
    var index = state.reservations
        .indexWhere((reservation) => reservation.id == id);
    state = state.copyWith(
        indexSelected: index,
        isReservationSelected: true,
        isStatusAscending: state.isStatusAscending,
        reservation: state.reservations[index]
    );
  }

  loadReservations() async {
    state = state.copyWith(
        reservations: await repository.getAllReservations(state.isStatusAscending),
        isStatusAscending: state.isStatusAscending
    );
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
    state = state.copyWith(isStatusAscending: filterStatus);
  }

  updateReservation(Reservation reservation) {
    state = state.copyWith(
        reservation: reservation,
        isStatusAscending: state.isStatusAscending
    );
  }
}

final reservationProvider = StateNotifierProvider<ReservationNotifier, ReservationState>((ref) {
  final ReservationDatasource datasource = ReservationDatasourceImpl();
  final ReservationRepository repository = ReservationRepositoryImpl(datasource: datasource);
  return ReservationNotifier(ReservationState(), repository);
});