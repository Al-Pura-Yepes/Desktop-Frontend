import 'package:al_pura_frontend/feature/sale/presentation/providers/cart_provider.dart';
import 'package:al_pura_frontend/feature/shared/domain/model/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../shared/widget/buttons/quantity_counter.dart';

class ProductStaticPriceSale extends ConsumerWidget {
  final Product product;
  final double widgetHeight = 70;
  const ProductStaticPriceSale({super.key, required this.product});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final quantity = ref.watch(cartProvider).products[product]!;

    final textTheme = Theme.of(context).textTheme;

    return FittedBox(
      fit: BoxFit.fitWidth,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            QuantityCounter(
              callback: (quantity) {
                ref
                    .read(cartProvider.notifier)
                    .setItemQuantity(product, quantity);
              },
            ),
            const SizedBox(
              width: 15,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(product.category, style: textTheme.titleSmall),
                Text(
                  '${product.flavor} - ${product.weight}',
                  style: textTheme.bodySmall,
                )
              ],
            ),
            const SizedBox(
              width: 40,
            ),
            SizedBox(
              width: 130,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text('Bs'),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    (product.price! * quantity).toStringAsFixed(2),
                    style: textTheme.bodyLarge,
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: 30,
            ),
            IconButton(
                onPressed: () {
                  ref.read(cartProvider.notifier).deleteItemFromCart(product);
                },
                icon: const Icon(
                  Icons.delete,
                  size: 30,
                  color: Colors.red,
                ))
          ],
        ),
      ),
    );
  }
}
