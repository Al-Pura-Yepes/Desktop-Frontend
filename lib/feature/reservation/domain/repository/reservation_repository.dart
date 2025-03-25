import 'package:al_pura_frontend/feature/reservation/domain/model/reservation.dart';
import 'package:al_pura_frontend/feature/reservation/domain/model/status.dart';

abstract class ReservationRepository {
  Future<List<Reservation>> getAllReservations(
      bool? isStatusAscending, DateTime? dayFiltered);
  Future<Reservation?> getReservationById(String id);
  Future<bool> updateStatus(String id, Status status);
  Future<bool> confirmPayment(String id, String paymentMethod);
  Future<bool> deleteReservation(String id);
  Future<Reservation> createReservation(Reservation reservation);

}
