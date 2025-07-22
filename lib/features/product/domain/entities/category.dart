import 'package:al_pura_frontend/core/entities/i_entity.dart';

class Category implements IEntity {
  @override
  final String id;

  final String label;

  Category({required this.id, required this.label});

  Category copyWith({
    String? id,
    String? flavorLabel,
  }) {
    return Category(
      id: id ?? this.id,
      label: flavorLabel ?? this.label,
    );
  }

  @override
  String toString() {
    return 'Category{id: $id, categoryLabel: $label}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Category && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
