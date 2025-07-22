import 'package:al_pura_frontend/features/sale/domain/entities/sale.dart';

abstract class SaleRepository {
  Future<List<Sale>> getAll();
  Future<Sale?> get(String id);
  Future<Sale> create(Sale product);
  Future<Sale> update(Sale product);

  // Funciones temporales

  /// Obtiene todas las ventas directas para una fecha específica
  Future<List<Sale>> getDirectSalesByDate(DateTime date);

  /// Obtiene todas las reservaciones
  Future<List<Sale>> getAllReservations();
}
