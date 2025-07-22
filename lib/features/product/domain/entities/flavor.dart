import 'package:al_pura_frontend/core/entities/i_entity.dart';

class Flavor implements IEntity {
  @override
  final String id;

  final String label;
  final bool hasStevia;
  final String hexColor;

  Flavor(
      {required this.id,
      required this.label,
      this.hasStevia = false,
      required this.hexColor});

  Flavor copyWith(
      {String? id,
      String? flavorLabel,
      String? hexDecimalColor,
      bool? isWithStevia}) {
    return Flavor(
        id: id ?? this.id,
        label: flavorLabel ?? this.label,
        hexColor: hexDecimalColor ?? this.hexColor,
        hasStevia: isWithStevia ?? this.hasStevia);
  }

  @override
  String toString() {
    return 'Flavor{id: $id, flavorLabel: $label}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Flavor && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
