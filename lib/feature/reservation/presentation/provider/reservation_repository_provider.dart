import 'package:al_pura_frontend/feature/reservation/domain/repository/reservation_repository.dart';
import 'package:al_pura_frontend/feature/reservation/infrastructure/datasource/reservation_datasource_impl.dart';
import 'package:al_pura_frontend/feature/reservation/infrastructure/repository/reservation_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final reservationRepositoryProvider = Provider<ReservationRepository>((ref) {
  return ReservationRepositoryImpl(datasource: ReservationDatasourceImpl());
});
