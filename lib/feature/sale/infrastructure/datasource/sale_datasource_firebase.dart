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
}
