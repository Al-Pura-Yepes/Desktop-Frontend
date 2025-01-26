import 'package:al_pura_frontend/feature/sale/domain/datasource/sale_datasource.dart';
import 'package:al_pura_frontend/feature/sale/domain/model/sale.dart';
import 'package:al_pura_frontend/feature/sale/domain/repository/sale_repository.dart';

class SaleRepositoryImpl implements SaleRepository {
  final SaleDatasource datasource;

  const SaleRepositoryImpl({required this.datasource});

  @override
  Future<Sale> createSale(Sale sale) {
    return datasource.createSale(sale);
  }

  @override
  Future<List<Sale>> getAllSales(bool isStatusAscending, DateTime? dayFiltered) {
    return datasource.getAllSales(isStatusAscending, dayFiltered);
  }

  @override
  Future<Sale?> getSalesById(String id) {
    return datasource.getSalesById(id);
  }
}
