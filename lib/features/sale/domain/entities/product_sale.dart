import 'package:al_pura_frontend/core/entities/i_entity.dart';
import 'package:al_pura_frontend/features/product/domain/entities/product.dart';

class ProductSale implements IEntity {
  @override
  final String id;

  final Product product;
  final double quantity;

  const ProductSale({
    required this.id,
    required this.product,
    required this.quantity,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductSale &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;

  ProductSale copyWith({
    Product? product,
    double? quantity,
  }) {
    return ProductSale(
      id: id,
      product: product ?? this.product,
      quantity: quantity ?? this.quantity,
    );
  }

  @override
  String toString() {
    return '${product.category.label}-${product.flavor.label}';
  }
}
