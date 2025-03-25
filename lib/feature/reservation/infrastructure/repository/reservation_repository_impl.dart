import 'package:al_pura_frontend/feature/reservation/domain/datasource/reservation_datasource.dart';
import 'package:al_pura_frontend/feature/reservation/domain/model/reservation.dart';
import 'package:al_pura_frontend/feature/reservation/domain/model/status.dart';
import 'package:al_pura_frontend/feature/reservation/domain/repository/reservation_repository.dart';

class ReservationRepositoryImpl extends ReservationRepository {
  final ReservationDatasource datasource;

  ReservationRepositoryImpl({required this.datasource});

  @override
  Future<List<Reservation>> getAllReservations(
      bool? isStatusAscending, DateTime? dayFiltered) {
    return datasource.getAllReservations(isStatusAscending, dayFiltered);
  }

  @override
  Future<Reservation?> getReservationById(String id) {
    return datasource.getReservationById(id);
  }

  @override
  Future<bool> updateStatus(String id, Status status) {
    return datasource.updateStatus(id, status);
  }

  @override
  Future<bool> confirmPayment(String id, String paymentMethod) {
    return datasource.confirmPayment(id, paymentMethod);
  }

  @override
  Future<bool> deleteReservation(String id) {
    return datasource.deleteReservation(id);
  }

  @override
  Future<Reservation> createReservation(Reservation reservation) {
    return datasource.createReservation(reservation);
  }
}
