import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:al_pura_frontend/core/models/i_request_dto.dart';
import 'package:al_pura_frontend/features/sale/data/dtos/payment_method/payment_method_request_dto.dart';
import 'package:al_pura_frontend/features/sale/data/dtos/product_sale/product_sale_request_dto.dart';
import 'package:al_pura_frontend/features/sale/data/dtos/sale_type/sale_type_request_dto.dart';
import 'package:al_pura_frontend/features/sale/domain/entities/sale.dart';

class SaleRequestDto implements IRequestDto<Sale> {
  @override
  Map<String, dynamic> toJson(Sale sale) {
    return {
      'id': sale.id,
      'paymentMethod': PaymentMethodRequestDto().toJson(sale.paymentMethod),
      'saleType': SaleTypeRequestDto().toJson(sale.saleType),
      'products': sale.products
          .map((e) => ProductSaleRequestDto().toJson(e))
          .toList(),
      'discount': sale.discount,
      'totalPrice': sale.totalPrice,
      'subtotal': sale.subtotal, // This will be provided by the backend
      'saleDate': Timestamp.fromDate(sale.saleDate),
      'isDelivery': sale.isDelivery,
      'isAvailable': sale.isAvailable,
    };
  }
}
