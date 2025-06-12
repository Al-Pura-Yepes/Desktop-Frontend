import 'package:al_pura_frontend/core/entities/i_entity.dart';

class Category implements IEntity {

  @override
  final String id;

  final String categoryLabel;

  Category({required this.id, required this.categoryLabel});

  Map<String, dynamic> toMap() {
    return {
      'categoryLabel': this.categoryLabel,
    };
  }

  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
      id: map['id'] as String,
      categoryLabel: map['categoryLabel'] as String,
    );
  }

  Category copyWith({
    String? id,
    String? flavorLabel,
  }) {
    return Category(
      id: id ?? this.id,
      categoryLabel: flavorLabel ?? this.categoryLabel,
    );
  }

  @override
  String toString() {
    return 'Category{id: $id, categoryLabel: $categoryLabel}';
  }
}