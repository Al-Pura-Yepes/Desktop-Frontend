import 'package:al_pura_frontend/core/entities/i_entity.dart';

class SaleType implements IEntity {
  @override
  final String id;

  final String label;

  SaleType({required this.id, required this.label});

  @override
  String toString() {
    return 'SaleType{id: $id, label: $label}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SaleType && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}

enum SaleTypes {
  DIRECT_SALE('1', 'Venta directa'),
  RESERVATION('2', 'Reserva');

  final String id;
  final String title;

  const SaleTypes(this.id, this.title);
}
