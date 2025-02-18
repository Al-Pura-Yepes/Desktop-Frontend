import 'package:al_pura_frontend/feature/reservation/domain/datasource/reservation_datasource.dart';
import 'package:al_pura_frontend/feature/reservation/domain/model/reservation.dart';
import 'package:al_pura_frontend/feature/reservation/domain/model/status.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ReservationDatasourceImpl extends ReservationDatasource {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Future<List<Reservation>> getAllReservations(bool? isStatusAscending, DateTime? dayFiltered) async {
    var query = firestore.collection('Reservations')
        .where('isActive', isEqualTo: true);

    if (isStatusAscending != null) {
      query = query.orderBy('status', descending: !isStatusAscending);
    }

    if (dayFiltered != null) {
      var initOfDay = DateTime(dayFiltered.year, dayFiltered.month, dayFiltered.day);
      var endOfDay = dayFiltered.add(const Duration(days: 1));
      query = query.where('deliveryDate', isGreaterThan: initOfDay);
      query = query.where('deliveryDate', isLessThan: endOfDay);
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

  @override
  Future<bool> updateStatus(String id, Status status) async {
    try {
      await firestore
          .collection('Reservations')
          .doc(id)
          .update({
        'status': getIntFromStatus(status)
      });
      return true;
    } on Exception {
      return false;
    }
  }

  @override
  Future<bool> confirmPayment(String id, String paymentMethod) async {
    try {
      await firestore
          .collection('Reservations')
          .doc(id)
          .update({
        'status': getIntFromStatus(Status.completed),
        'paymentMethod': paymentMethod
      });
      return true;
    } on Exception {
      return false;
    }
  }

  @override
  Future<bool> deleteReservation(String id) async {
    try {
      await firestore
          .collection('Reservations')
          .doc(id)
          .update({
        'isActive': false
      });
      return true;
    } on Exception {
      return false;
    }
  }

}