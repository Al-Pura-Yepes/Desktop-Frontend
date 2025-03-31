import 'package:al_pura_frontend/feature/sale/presentation/providers/cart_provider.dart';
import 'package:al_pura_frontend/feature/shared/Provider/products_provider.dart';
import 'package:al_pura_frontend/feature/shared/domain/model/product.dart';
import 'package:al_pura_frontend/feature/shared/widget/text/label_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../shared/widget/buttons/quantity_counter.dart';

class ProductStaticPriceSale extends ConsumerStatefulWidget {
  final Product product;
  final double widgetHeight = 70;
  final bool isEditable;
  final double? quantity;
  final bool isFinished;

  const ProductStaticPriceSale(
      {super.key,
      required this.product,
      this.isEditable = true,
      this.quantity,
      this.isFinished = true});
  @override
  ConsumerState createState() => _ProductStaticPriceSaleState();
}

class _ProductStaticPriceSaleState
    extends ConsumerState<ProductStaticPriceSale> {
  late double localQuantity;

  @override
  void initState() {
    localQuantity = widget.quantity ?? 1;
  }

  @override
  Widget build(BuildContext context) {
    final productState =
        ref.read(productsProvider.notifier).getAllProductsInfo();
    //final quantity = ref.watch(cartProvider).products[product]!;
    double productQuantity = widget.quantity ?? 0;
    if (widget.quantity == null) {
      productQuantity = !widget.isEditable
          ? 0
          : ref.watch(cartProvider).products[widget.product] ?? 0;

      if (!widget.isEditable) {
        productQuantity = widget.product.quantity;
      }
    }

    final textTheme = Theme.of(context).textTheme;

    final bool isAvailableProduct =
        (((productState[widget.product.id]?.quantity ?? 0) >= localQuantity) &&
            (productState[widget.product.id]?.quantity ?? 0) > 0);
    return Container(
      color: (isAvailableProduct)
          ? Colors.transparent
          : widget.isEditable
              ? Colors.yellowAccent
              : widget.isFinished
                  ? Colors.transparent
                  : Colors.yellowAccent,
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            !widget.isEditable
                ? Row(
                    spacing: 3,
                    children: [
                      LabelBorder(
                        text: widget.product.weightValue != 'KG' ? productQuantity.toStringAsFixed(0) : productQuantity.toStringAsFixed(3),
                        textStyle: textTheme.bodyMedium!,
                      ),
                      Text(widget.product.isFixedPrice ? 'u' : 'Kg')
                    ],
                  )
                : QuantityCounter(
                    callback: (quantity) {
                      localQuantity = quantity.toDouble();
                      ref
                          .read(cartProvider.notifier)
                          .setItemQuantity(widget.product, quantity);
                      setState(() {});
                    },
                  ),
            const SizedBox(
              width: 15,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(widget.product.category, style: textTheme.bodySmall),
                Text(
                  '${widget.product.flavor} - ${widget.product.weight}${widget.product.weightValue}',
                  style: textTheme.titleSmall,
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
                  FittedBox(
                    fit: BoxFit.fitHeight,
                    child: Text(
                      (widget.product.price! * productQuantity)
                          .toStringAsFixed(2),
                      style: textTheme.bodyLarge,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: 40,
            ),
            !widget.isEditable
                ? const SizedBox.shrink()
                : IconButton(
                    onPressed: () {
                      ref
                          .read(cartProvider.notifier)
                          .deleteItemFromCart(widget.product);
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
