import 'package:al_pura_frontend/features/sale/presentation/providers/sale_provider.dart';
import 'package:al_pura_frontend/features/sale/presentation/widgets/product_sale_card/product_sale_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductsCart extends ConsumerWidget {
  final String saleId;
  final bool isEditable;

  const ProductsCart({
    super.key,
    this.saleId = '',
    this.isEditable = true,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = TextTheme.of(context);

    final saleState = ref.watch(saleProvider(saleId));
    final products =  saleState.products.values.toList();

    return Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: const BoxDecoration(
          color: Colors.black,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Carrito',
              textAlign: TextAlign.start,
              style: textTheme.titleSmall?.copyWith(color: Colors.white),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: products.length,
                itemBuilder: (context, index) {
                  return ProductSaleCard(
                    isEditable: isEditable,
                    saleProductId: products[index].id,
                    saleId: saleId,
                  );
                },
              ),
            )
          ],
        ));
  }
}
