import 'package:al_pura_frontend/feature/reservation/domain/datasource/reservation_datasource.dart';
import 'package:al_pura_frontend/feature/reservation/domain/model/reservation.dart';
import 'package:al_pura_frontend/feature/reservation/domain/model/status.dart';
import 'package:al_pura_frontend/feature/reservation/domain/repository/reservation_repository.dart';

class ReservationRepositoryImpl extends ReservationRepository {
  final ReservationDatasource datasource;

  ReservationRepositoryImpl({
    required this.datasource
  });

  @override
  Future<List<Reservation>> getAllReservations(bool? isStatusAscending) {
    return datasource.getAllReservations(isStatusAscending);
  }

  @override
  Future<Reservation?> getReservationById(String id) {
    return datasource.getReservationById(id);
  }

  @override
  Future<bool> updateStatus(String id, Status status) {
    return datasource.updateStatus(id, status);
  }
  
}