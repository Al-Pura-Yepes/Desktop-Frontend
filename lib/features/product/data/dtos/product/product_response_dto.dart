import 'package:al_pura_frontend/core/models/i_response_dto.dart';
import 'package:al_pura_frontend/features/product/data/dtos/category/category_response_dto.dart';
import 'package:al_pura_frontend/features/product/data/dtos/flavor/flavor_response_dto.dart';
import 'package:al_pura_frontend/features/product/domain/entities/product.dart';

class ProductResponseDto implements IResponseDto<Product> {
  @override
  Product fromJson(Map<String, dynamic> map) {
    return Product(
      id: map['id'],
      flavor:
          FlavorResponseDto().fromJson(map['flavor'] as Map<String, dynamic>),
      category: CategoryResponseDto()
          .fromJson(map['category'] as Map<String, dynamic>),
      productImage: map['productImage'] as String,
      productPrice: (map['productPrice'] as num).toDouble(),
      isReturnable: map['isReturnable'] as bool,
      isAvailable: map['isAvailable'] as bool,
      isFixedPrice: map['isFixedPrice'] as bool,
      weightLabel: map['weightLabel'] as String,
      weight: (map['weight'] as num).toDouble(),
    );
  }
}
