import 'package:al_pura_frontend/feature/inventory/presentation/widgets/product_info.dart';
import 'package:al_pura_frontend/feature/inventory/presentation/widgets/product_stock.dart';
import 'package:al_pura_frontend/feature/shared/domain/model/product.dart';
import 'package:flutter/material.dart';

import '../../../sale/presentation/widget/products_board.dart';
import '../../../shared/widget/options_bar/option_bar.dart';

class InventoryScreen extends StatelessWidget {
  const InventoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;
    final secondaryColor = Theme.of(context).colorScheme.secondary;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: Colors.transparent,
        title: Text('Inventario',
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
            const Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: [
                    Expanded(
                      child: ProductInfo(
                          product: Product(
                              price: 13,
                              weightValue: 'L',
                              category: 'categoria',
                              flavor: 'flavor',
                              quantity: 2.0,
                              imageURL:
                                  'https://i.ibb.co/mBtTHMC/probiotico-2l-st-mora.jpg',
                              expirationDateList: [])),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ProductStock(
                      product: Product(
                          price: 13,
                          weightValue: 'L',
                          category: 'categoria',
                          flavor: 'flavor',
                          quantity: 2.0,
                          imageURL:
                              'https://i.ibb.co/mBtTHMC/probiotico-2l-st-mora.jpg',
                          expirationDateList: []),
                    )
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
