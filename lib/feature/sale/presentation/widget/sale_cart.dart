import 'package:al_pura_frontend/feature/sale/presentation/providers/cart_provider.dart';
import 'package:al_pura_frontend/feature/sale/presentation/widget/product_static_price_sale.dart';
import 'package:al_pura_frontend/feature/sale/presentation/widget/product_variable_price_sale.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SaleCart extends ConsumerWidget {
  final TextTheme textTheme;

  const SaleCart({
    super.key,
    required this.textTheme,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartState = ref.watch(cartProvider);
    final cartProducts = cartState.products;
    final cartProductsKeys = cartProducts.keys.toList();

    return Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                'Carrito',
                textAlign: TextAlign.start,
                style: textTheme.titleSmall,
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: cartProductsKeys.length,
                itemBuilder: (context, index) {
                  final quantity = cartProducts[cartProductsKeys[index]]!;
                  return Container(
                    margin: const EdgeInsets.only(bottom: 20),
                    child: cartProductsKeys[index].weight == null
                        ? ProductVariablePriceSale(
                            product: cartProductsKeys[index])
                        : ProductStaticPriceSale(
                            product: cartProductsKeys[index]),
                  );
                },
              ),
            )
          ],
        ));
  }
}
