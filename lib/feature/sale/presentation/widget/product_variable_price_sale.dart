import 'package:al_pura_frontend/feature/sale/presentation/providers/cart_provider.dart';
import 'package:al_pura_frontend/feature/sale/presentation/widget/sale_information_front.dart';
import 'package:al_pura_frontend/feature/shared/domain/model/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductVariablePriceSale extends ConsumerWidget {
  final Product product;
  final double widgetHeight = 70;
  final bool isEditable;
  final double? quantity;

  const ProductVariablePriceSale(
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

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
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
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Text(
                'Bs.',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                width: 15,
              ),
              SizedBox(
                width: 100,
                child: TextFormField(
                  validator: (value) {
                    return "error";
                  },
                  enabled: ref.read(cartProvider).widgetOption is SaleInformationFront,
                  onChanged: (value) {
                      ref
                          .read(cartProvider.notifier)
                          .setItemPrice(product, int.tryParse(value) ?? 0);

                  },
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(
                        RegExp(r'^\d{0,3}(?:\.\d*)?$')),
                  ],
                  style: TextStyle(fontSize: widgetHeight * 0.4),
                  textAlign: TextAlign.center,
                  textAlignVertical: TextAlignVertical.center,
                  cursorHeight: widgetHeight * 0.4,
                  decoration: InputDecoration(
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            width: 40,
          ),
          !isEditable
              ? const SizedBox.shrink()
              : IconButton(
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
    );
  }
}
