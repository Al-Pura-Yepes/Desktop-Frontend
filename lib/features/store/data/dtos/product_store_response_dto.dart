import 'package:al_pura_frontend/core/models/i_response_dto.dart';
import 'package:al_pura_frontend/features/product/data/dtos/product/product_response_dto.dart';
import 'package:al_pura_frontend/features/store/domain/entities/product_store.dart';

class ProductStoreResponseDto implements IResponseDto<ProductStore> {
  @override
  ProductStore fromJson(Map<String, dynamic> response) {
    final productDto = ProductResponseDto();
    final product = productDto.fromJson(response['product']);
    return ProductStore(
        id: response['id'], product: product, stock: response['stock']);
  }
}
