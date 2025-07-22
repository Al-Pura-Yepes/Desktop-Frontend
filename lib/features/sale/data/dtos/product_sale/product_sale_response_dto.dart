import 'package:al_pura_frontend/core/models/i_response_dto.dart';
import 'package:al_pura_frontend/features/product/data/dtos/product/product_response_dto.dart';
import 'package:al_pura_frontend/features/sale/domain/entities/product_sale.dart';

class ProductSaleResponseDto implements IResponseDto<ProductSale> {
  @override
  ProductSale fromJson(Map<String, dynamic> response) {
    final productDto = ProductResponseDto();
    return ProductSale(
      id: response['id'],
      product: productDto.fromJson(response),
      quantity: (response['quantity'] as num).toDouble(),
    );
  }
}
