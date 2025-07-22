import 'package:al_pura_frontend/features/sale/presentation/providers/sale_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductSaleCardVariablePrice extends ConsumerWidget {
  final String saleId;
  final String saleProductId;
  final bool isEditable;
  final double widgetHeight = 70;

  const ProductSaleCardVariablePrice({
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
              child: _ProductVariablePrice(
                saleId: saleId,
                productId: saleProductId,
                currentPrice: product.product.productPrice,
                isNewSale: saleId.isEmpty,
              ),
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

class _ProductVariablePrice extends ConsumerStatefulWidget {
  final String saleId;
  final String productId;
  final double currentPrice;
  final bool isNewSale;

  const _ProductVariablePrice({
    super.key,
    required this.saleId,
    required this.productId,
    required this.currentPrice,
    required this.isNewSale,
  });

  @override
  ConsumerState<_ProductVariablePrice> createState() => _ProductVariablePriceState();
}

class _ProductVariablePriceState extends ConsumerState<_ProductVariablePrice> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    // Set initial value: 0 for new sales, current price for existing sales
    final initialValue = widget.isNewSale ? '0' : widget.currentPrice.toString();
    _controller = TextEditingController(text: initialValue);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 10,
      children: [
        const Text(
          'Bs.',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Expanded(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final height = constraints.maxHeight;
              return TextFormField(
                controller: _controller,
                enabled: true,
                onChanged: (value) {
                  final newPrice = double.tryParse(value) ?? 0.0;
                  if (newPrice >= 0) {
                    ref.read(saleProvider(widget.saleId).notifier).updateProductPrice(widget.productId, newPrice);
                  }
                },
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
                ],
                style: TextStyle(fontSize: height * 0.4),
                textAlign: TextAlign.center,
                textAlignVertical: TextAlignVertical.center,
                cursorHeight: height * 0.4,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
