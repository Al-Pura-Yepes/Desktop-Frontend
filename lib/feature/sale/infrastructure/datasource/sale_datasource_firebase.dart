import 'package:al_pura_frontend/feature/sale/domain/datasource/sale_datasource.dart';
import 'package:al_pura_frontend/feature/sale/domain/model/sale.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SaleDatasourceFirebase implements SaleDatasource {
  late CollectionReference sales;

  SaleDatasourceFirebase() {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    sales = firestore.collection('Sales');
  }

  @override
  Future<Sale> createSale(Sale sale) async {
    try {
      await sales.add(sale.toJson());
      return sale;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<Sale>> getAllSales(bool isStatusAscending, DateTime? dayFiltered) async {
    Query query = sales.orderBy('saleDate', descending: !isStatusAscending);

    if (dayFiltered != null) {
      // Calcula el inicio del día y el inicio del día siguiente
      final initOfDay = DateTime(dayFiltered.year, dayFiltered.month, dayFiltered.day);
      final endOfDay = initOfDay.add(const Duration(days: 1));

      query = query
          .where('saleDate', isGreaterThanOrEqualTo: Timestamp.fromDate(initOfDay))
          .where('saleDate', isLessThan: Timestamp.fromDate(endOfDay));
    }

    var querySnapshot = await query.get();

    var salesList = querySnapshot.docs
        .map((doc) => Sale.fromJson(doc.data() as Map<String, dynamic>, doc.id))
        .toList();
    return salesList;
  }


  @override
  Future<Sale?> getSalesById(String id) async {
    var docSnapshot = await sales.doc(id).get();
    if (docSnapshot.exists) {
      var sale = Sale.fromJson(
          docSnapshot.data()! as Map<String, dynamic>, docSnapshot.id);
      return sale;
    } else {
      return null;
    }
  }
}
