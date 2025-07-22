import 'package:al_pura_frontend/core/entities/i_entity.dart';
import 'package:al_pura_frontend/features/sale/domain/entities/payment_method.dart';
import 'package:al_pura_frontend/features/sale/domain/entities/product_sale.dart';
import 'package:al_pura_frontend/features/sale/domain/entities/sale_type.dart';

class Sale implements IEntity {
  @override
  final String id;

  final PaymentMethod paymentMethod;
  final SaleType saleType;

  final List<ProductSale> products;
  final double discount;
  final double totalPrice;
  final double subtotal;
  final DateTime saleDate;
  final bool isDelivery;
  final bool isAvailable;

  Sale({
    required this.id,
    required this.paymentMethod,
    required this.saleType,
    required this.products,
    required this.discount,
    required this.totalPrice,
    required this.subtotal,
    required this.saleDate,
    required this.isDelivery,
    required this.isAvailable,
  });

  @override
  String toString() {
    return 'Sale{id: $id, products: $products, discount: $discount, totalPrice: $totalPrice, subtotal: $subtotal, saleDate: $saleDate, isDelivery: $isDelivery, isAvailable: $isAvailable, paymentMethod: $paymentMethod, saleType: $saleType}';
  }

  Sale copyWith({
    String? id,
    PaymentMethod? paymentMethod,
    SaleType? saleType,
    List<ProductSale>? products,
    double? discount,
    double? totalPrice,
    double? subtotal,
    DateTime? saleDate,
    bool? isDelivery,
    bool? isAvailable,
  }) {
    return Sale(
      id: id ?? this.id,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      saleType: saleType ?? this.saleType,
      products: products ?? this.products,
      discount: discount ?? this.discount,
      totalPrice: totalPrice ?? this.totalPrice,
      subtotal: subtotal ?? this.subtotal,
      saleDate: saleDate ?? this.saleDate,
      isDelivery: isDelivery ?? this.isDelivery,
      isAvailable: isAvailable ?? this.isAvailable,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Sale && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
