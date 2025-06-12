import 'package:al_pura_frontend/core/entities/i_entity.dart';

class Flavor implements IEntity {

  @override
  final String id;

  final String flavorLabel;

  Flavor({required this.id, required this.flavorLabel});

  Map<String, dynamic> toMap() {
    return {
      'flavorLabel': this.flavorLabel,
    };
  }

  factory Flavor.fromMap(Map<String, dynamic> map) {
    return Flavor(
      id: map['id'] as String,
      flavorLabel: map['flavorLabel'] as String,
    );
  }

  Flavor copyWith({
    String? id,
    String? flavorLabel,
  }) {
    return Flavor(
      id: id ?? this.id,
      flavorLabel: flavorLabel ?? this.flavorLabel,
    );
  }

  @override
  String toString() {
    return 'Flavor{id: $id, flavorLabel: $flavorLabel}';
  }
}
