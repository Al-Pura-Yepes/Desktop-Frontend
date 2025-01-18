import 'package:al_pura_frontend/feature/sale/domain/model/sale.dart';

abstract class SaleRepository {

  Future<Sale> createSale(Sale sale);

}