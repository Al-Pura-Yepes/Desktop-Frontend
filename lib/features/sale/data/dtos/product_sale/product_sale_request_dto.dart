import 'package:al_pura_frontend/core/models/i_request_dto.dart';
import 'package:al_pura_frontend/features/product/data/dtos/product/product_request_dto.dart';
import 'package:al_pura_frontend/features/sale/domain/entities/product_sale.dart';

class ProductSaleRequestDto implements IRequestDto<ProductSale> {
  @override
  Map<String, dynamic> toJson(ProductSale productSale) {
    final productDto = ProductRequestDto();
    return {
      ...productDto.toJson(productSale.product),
      'quantity': productSale.quantity,
    };
  }
}
