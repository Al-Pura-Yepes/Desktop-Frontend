import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:al_pura_frontend/core/models/i_response_dto.dart';
import 'package:al_pura_frontend/features/sale/data/dtos/payment_method/payment_method_response_dto.dart';
import 'package:al_pura_frontend/features/sale/data/dtos/product_sale/product_sale_response_dto.dart';
import 'package:al_pura_frontend/features/sale/data/dtos/sale_type/sale_type_response_dto.dart';
import 'package:al_pura_frontend/features/sale/domain/entities/sale.dart';

class SaleResponseDto implements IResponseDto<Sale> {
  @override
  Sale fromJson(Map<String, dynamic> response) {
    return Sale(
      id: response['id'] as String,
      paymentMethod:
          PaymentMethodResponseDto().fromJson(response['paymentMethod'] as Map<String, dynamic>),
      saleType: SaleTypeResponseDto().fromJson(response['saleType'] as Map<String, dynamic>),
      products: (response['products'] as List<dynamic>)
          .map((e) => ProductSaleResponseDto().fromJson(e as Map<String, dynamic>))
          .toList(),
      discount: (response['discount'] as num).toDouble(),
      totalPrice: (response['totalPrice'] as num).toDouble(),
      subtotal: (response['subtotal'] as num).toDouble(),
      saleDate: (response['saleDate'] as Timestamp).toDate(),
      isDelivery: response['isDelivery'] as bool,
      isAvailable: response['isAvailable'] as bool,
    );
  }
}
