import 'package:al_pura_frontend/feature/reservation/domain/datasource/reservation_datasource.dart';
import 'package:al_pura_frontend/feature/reservation/domain/model/reservation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ReservationDatasourceImpl extends ReservationDatasource {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Future<List<Reservation>> getAllReservations(bool? isStatusAscending) async {
    var query = firestore.collection('Reservations')
        .where('isActive', isEqualTo: true);

    if (isStatusAscending != null) {
      query = query.orderBy('status', descending: !isStatusAscending);
    }

    query = query.orderBy('deliveryDate');

    var querySnapshot = await query.get();

    var reservations = querySnapshot.docs
        .map((element) => Reservation.fromMap(element.data(), element.id))
        .toList();
    return reservations;
  }

  @override
  Future<Reservation?> getReservationById(String id) async {
    var docSnapshot = await firestore.collection('Reservations').doc(id).get();
    if (docSnapshot.exists) {
      var reservation = Reservation.fromMap(
          docSnapshot.data()!, docSnapshot.id);
      return reservation;
    }
    return null;
  }

}