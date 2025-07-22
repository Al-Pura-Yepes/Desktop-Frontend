import 'package:al_pura_frontend/core/widgets/buttons/quantity_counter.dart';
import 'package:al_pura_frontend/features/sale/domain/entities/product_sale.dart';
import 'package:al_pura_frontend/features/sale/presentation/providers/sale_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductSaleCardStaticPrice extends ConsumerWidget {
  final String saleId;
  final String saleProductId;
  final bool isEditable;
  final double widgetHeight = 70;

  const ProductSaleCardStaticPrice({
    super.key,
    this.saleId = '',
    required this.saleProductId,
    this.isEditable = true,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;
    final saleState = ref.watch(saleProvider(saleId));
    final product = saleState.products[saleProductId]!;

    return Container(
      color: Colors.white,
      height: widgetHeight,
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          spacing: 10,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Contador
            if (product.product.isFixedPrice == true) Expanded(
              flex: 1,
              child: QuantityCounter(
                value: product.quantity ?? 0,
                isEditable: isEditable,
                callback: (quantity) {
                  ref
                      .read(saleProvider(saleId).notifier)
                      .setProductQuantity(saleProductId, quantity);
                },
              ),
            ),

            // TITULO Y SABOR
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(product.product.category.label,
                    style: textTheme.bodySmall, overflow: TextOverflow.ellipsis,),
                  Text(
                      '${product.product.flavor.label} - ${product.product.weight}${product.product.weightLabel}',
                      style: textTheme.titleSmall, overflow: TextOverflow.ellipsis
                  )
                ],
              ),
            ),

            Expanded(
              flex: 1,
              child: _ProducStaticPrice(product: product, textTheme: textTheme)
            ),

            if (isEditable) Expanded(
              flex: 1,
              child: Align(
                alignment: Alignment.centerRight,
                child: IconButton(
                    onPressed: () {
                      ref
                          .read(saleProvider(saleId).notifier)
                          .deleteProduct(product.id);
                    },
                    icon: const Icon(
                      Icons.delete,
                      size: 30,
                      color: Colors.red,
                    )),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _ProducStaticPrice extends StatelessWidget {
  const _ProducStaticPrice({
    super.key,
    required this.product,
    required this.textTheme,
  });

  final ProductSale product;
  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        const Text(
          'Bs',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          width: 15,
        ),
        Text(
          (product.product.productPrice * product.quantity)
              .toStringAsFixed(2),
          style: textTheme.bodyMedium,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
