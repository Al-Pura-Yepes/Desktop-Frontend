import 'package:al_pura_frontend/feature/sale/presentation/providers/cart_provider.dart';
import 'package:al_pura_frontend/feature/sale/presentation/widget/product_static_price_sale.dart';
import 'package:al_pura_frontend/feature/sale/presentation/widget/products_board.dart';
import 'package:al_pura_frontend/feature/sale/presentation/widget/sale_information_back.dart';
import 'package:al_pura_frontend/feature/sale/presentation/widget/sale_information_front.dart';
import 'package:al_pura_frontend/feature/shared/widget/options_bar/option_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../widget/sale_cart.dart';

class SaleScreen extends ConsumerWidget {
  const SaleScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;
    final secondaryColor = Theme.of(context).colorScheme.secondary;

    final widgetOption = ref.watch(cartProvider).widgetOption;

    return Scaffold(
      //TODO: CHANGE TO SLIVER APP BAR
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: Colors.transparent,
        title: Text('Venta',
            style: textTheme.titleLarge!.copyWith(fontWeight: FontWeight.bold)),
      ),
      body: Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: Row(
          children: [
            SizedBox(
              width: size.width * 0.6,
              child: const Column(
                children: [
                  OptionBar(),
                  SizedBox(
                    height: 10,
                  ),
                  Expanded(child: ProductsBoard())
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: [
                    Expanded(
                      child: SaleCart(textTheme: textTheme),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(height: 300, child: widgetOption),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
