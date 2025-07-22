import 'package:al_pura_frontend/features/product/domain/entities/category.dart';
import 'package:al_pura_frontend/features/product/domain/entities/flavor.dart';
import 'package:al_pura_frontend/core/entities/i_entity.dart';

class Product implements IEntity {
  @override
  final String? id;
  final Flavor flavor;
  final Category category;

  final String? productName;
  final String productImage;
  final double productPrice;
  final bool isReturnable;
  final bool isAvailable;
  final bool isFixedPrice;
  final double? weight;
  final String weightLabel;

  Product({
    this.id,
    required this.flavor,
    required this.category,
    this.productName,
    required this.productImage,
    required this.productPrice,
    required this.isReturnable,
    required this.isAvailable,
    required this.isFixedPrice,
    this.weight,
    required this.weightLabel,
  });

  Product copyWith({
    String? id,
    Flavor? flavor,
    Category? category,
    String? productName,
    String? productImage,
    double? productPrice,
    bool? isReturnable,
    bool? isAvailable,
    bool? isFixedPrice,
    double? weight,
    String? weightLabel,
    double? quantity,
  }) {
    return Product(
      id: id ?? this.id,
      flavor: flavor ?? this.flavor,
      category: category ?? this.category,
      productName: productName ?? this.productName,
      productImage: productImage ?? this.productImage,
      productPrice: productPrice ?? this.productPrice,
      isReturnable: isReturnable ?? this.isReturnable,
      isAvailable: isAvailable ?? this.isAvailable,
      isFixedPrice: isFixedPrice ?? this.isFixedPrice,
      weight: weight ?? this.weight,
      weightLabel: weightLabel ?? this.weightLabel,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Product && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'Product{id: $id, flavor: $flavor, category: $category, productName: $productName, productImage: $productImage, productPrice: $productPrice, isReturnable: $isReturnable, isAvailable: $isAvailable, isFixedPrice: $isFixedPrice, weight: $weight, weightLabel: $weightLabel}';
  }
}
