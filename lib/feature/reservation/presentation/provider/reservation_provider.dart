import 'package:flutter_riverpod/flutter_riverpod.dart';

class ReservationState {
  final bool isReservationSelected;
  final int? indexSelected;

  ReservationState({
    this.isReservationSelected = false,
    this.indexSelected
  });

  ReservationState copyWith({
    bool? isReservationSelected,
    int? indexSelected
  }) {
    return ReservationState(
      isReservationSelected: isReservationSelected ?? this.isReservationSelected,
      indexSelected: indexSelected ?? this.indexSelected
    );
  }
}

class ReservationNotifier extends StateNotifier<ReservationState> {
  ReservationNotifier(super.state);

  toggleReservation() {
    state = state.copyWith(isReservationSelected: !state.isReservationSelected);
  }

  changeItemSelected(int index) {
    state = state.copyWith(indexSelected: index, isReservationSelected: true);
  }
}

final reservationProvider = StateNotifierProvider<ReservationNotifier, ReservationState>((ref) {
  return ReservationNotifier(ReservationState());
});