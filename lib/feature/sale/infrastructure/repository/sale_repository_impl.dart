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

}