import 'package:al_pura_frontend/feature/sale/presentation/widget/product_static_price_sale.dart';
import 'package:al_pura_frontend/feature/sale/presentation/widget/products_board.dart';
import 'package:al_pura_frontend/feature/sale/presentation/widget/sale_information_back.dart';
import 'package:al_pura_frontend/feature/sale/presentation/widget/sale_information_front.dart';
import 'package:al_pura_frontend/feature/shared/widget/options_bar/option_bar.dart';
import 'package:flutter/material.dart';

class SaleScreen extends StatelessWidget {
  const SaleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;
    final secondaryColor = Theme.of(context).colorScheme.secondary;

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
                      child: _SaleCart(textTheme: textTheme),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const SizedBox(
                        height: 300,
                        child: SaleInformationFront()),
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

class _SaleCart extends StatelessWidget {
  const _SaleCart({
    required this.textTheme,
  });

  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            )),
        height: const ProductStaticPriceSale().widgetHeight * 7,
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
                itemCount: 6,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.only(bottom: 20),
                    child: const ProductStaticPriceSale(),
                  );
                },
              ),
            )
          ],
        ));
  }
}
