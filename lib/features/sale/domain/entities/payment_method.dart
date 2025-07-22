import 'package:al_pura_frontend/core/entities/i_entity.dart';

class PaymentMethod implements IEntity {
  @override
  final String id;

  final String label;

  PaymentMethod({required this.id, required this.label});

  @override
  String toString() {
    return 'PaymentMethod{id: $id, label: $label}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PaymentMethod &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}

enum PaymentMethods {
  QR('1', 'QR'),
  CASH('2', 'Efectivo');

  final String id;
  final String title;

  const PaymentMethods(this.id, this.title);
}
