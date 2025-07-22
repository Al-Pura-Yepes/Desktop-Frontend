import 'package:al_pura_frontend/features/sale/presentation/providers/sale_provider.dart';
import 'package:al_pura_frontend/features/sale/presentation/widgets/product_sale_card/product_sale_card_static_price.dart';
import 'package:al_pura_frontend/features/sale/presentation/widgets/product_sale_card/product_sale_card_variable_price.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductSaleCard extends ConsumerWidget {
  final String saleId;
  final String saleProductId;
  final bool isEditable;

  const ProductSaleCard({
    super.key,
    this.saleId = '',
    required this.saleProductId,
    this.isEditable = true,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final saleState = ref.watch(saleProvider(saleId));
    final product = saleState.products[saleProductId]!;

    if (product.product.isFixedPrice) {
      return ProductSaleCardStaticPrice(
        saleId: saleId,
        saleProductId: saleProductId,
        isEditable: isEditable,
      );
    } else {
      return ProductSaleCardVariablePrice(
        saleId: saleId,
        saleProductId: saleProductId,
        isEditable: isEditable,
      );
    }
  }
}
