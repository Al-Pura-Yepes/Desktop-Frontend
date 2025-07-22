import 'package:al_pura_frontend/core/entities/i_entity.dart';
import 'package:al_pura_frontend/features/product/domain/entities/product.dart';

class ProductStore implements IEntity {
  @override
  final String? id;

  final Product product;
  final double stock;

  const ProductStore({this.id, required this.product, required this.stock});

  ProductStore copyWith({
    String? id,
    Product? product,
    double? stock,
  }) {
    return ProductStore(
      id: id ?? this.id,
      product: product ?? this.product,
      stock: stock ?? this.stock,
    );
  }

  @override
  String toString() {
    return 'ProductStore{id: $id, product: $product, stock: $stock}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductStore &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}
