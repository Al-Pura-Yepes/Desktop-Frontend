import 'package:al_pura_frontend/feature/sale/presentation/providers/cart_provider.dart';
import 'package:al_pura_frontend/feature/shared/domain/model/product.dart';
import 'package:al_pura_frontend/feature/shared/widget/text/label_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../shared/widget/buttons/quantity_counter.dart';

class ProductStaticPriceSale extends ConsumerWidget {
  final Product product;
  final double widgetHeight = 70;
  final bool isEditable;
  final double? quantity;

  const ProductStaticPriceSale(
      {super.key,
      required this.product,
      this.isEditable = true,
      this.quantity});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //final quantity = ref.watch(cartProvider).products[product]!;
    double productQuantity = quantity ?? 0;
    if (quantity == null) {
      productQuantity =
          !isEditable ? 0 : ref.watch(cartProvider).products[product] ?? 0;

      if (!isEditable) {
        productQuantity = product.quantity;
      }
    }

    final textTheme = Theme.of(context).textTheme;

    return Container(
      color: product.quantity < (ref.watch(cartProvider).products[product] ?? 0)
          ? Colors.deepOrangeAccent
          : Colors.transparent,
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            !isEditable
                ? LabelBorder(
                    text: productQuantity.toStringAsFixed(2),
                    textStyle: textTheme.bodyMedium!,
                  )
                : QuantityCounter(
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
            const Spacer(),
            SizedBox(
              width: 130,
              child: Row(
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
                    (product.price! * productQuantity).toStringAsFixed(2),
                    style: textTheme.bodyLarge,
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: 40,
            ),
            !isEditable
                ? const SizedBox.shrink()
                : IconButton(
                    onPressed: () {
                      ref
                          .read(cartProvider.notifier)
                          .deleteItemFromCart(product);
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
