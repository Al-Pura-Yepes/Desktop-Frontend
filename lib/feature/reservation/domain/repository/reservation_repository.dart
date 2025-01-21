import 'package:al_pura_frontend/feature/reservation/domain/model/reservation.dart';

abstract class ReservationRepository {
  Future<List<Reservation>> getAllReservations(bool? isStatusAscending);
  Future<Reservation?> getReservationById(String id);
}