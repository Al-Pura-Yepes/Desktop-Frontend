import 'package:al_pura_frontend/feature/sale/domain/model/sale.dart';

abstract class SaleDatasource {
  Future<Sale> createSale(Sale sale);
  Future<List<Sale>> getAllSales(bool isStatusAscending);
  Future<Sale?> getSalesById(String id);
}
