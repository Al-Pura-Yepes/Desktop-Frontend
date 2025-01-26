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
  Future<List<Sale>> getAllSales(bool isDateAscending) async {
    late Query<Object?> query;

    query = sales.orderBy('dateTime', descending: !isDateAscending);

    var querySnapshot = await query.get();

    var reservations = querySnapshot.docs
        .map((element) => Sale.fromJson(element.data() as Map<String, dynamic>))
        .toList();
    return reservations;
  }

  @override
  Future<Sale?> getSalesById(String id) async {
    var docSnapshot = await sales.doc(id).get();
    if (docSnapshot.exists) {
      var sale = Sale.fromJson(docSnapshot.data()! as Map<String, dynamic>);
      return sale;
    } else {
      return null;
    }
  }
}
