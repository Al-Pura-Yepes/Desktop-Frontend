import 'package:al_pura_frontend/core/models/i_request_dto.dart';
import 'package:al_pura_frontend/features/product/data/dtos/category/category_request_dto.dart';
import 'package:al_pura_frontend/features/product/data/dtos/flavor/flavor_request_dto.dart';
import 'package:al_pura_frontend/features/product/domain/entities/product.dart';

class ProductRequestDto implements IRequestDto<Product> {
  @override
  Map<String, dynamic> toJson(Product entity) {
    final flavorDto = FlavorRequestDto();
    final categoryDto = CategoryRequestDto();
    return {
      'id': entity.id,
      'flavor': flavorDto.toJson(entity.flavor),
      'category': categoryDto.toJson(entity.category),
      'productImage': entity.productImage,
      'productPrice': entity.productPrice,
      'isReturnable': entity.isReturnable,
      'isAvailable': entity.isAvailable,
      'isFixedPrice': entity.isFixedPrice,
      'weightLabel': entity.weightLabel,
      'weight': entity.weight,
      'productName': entity.productName
    };
  }
}
