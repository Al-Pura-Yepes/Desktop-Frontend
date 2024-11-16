import 'package:al_pura_frontend/feature/sale/presentation/widget/product_static_price_sale.dart';
import 'package:al_pura_frontend/feature/sale/presentation/widget/products_board.dart';
import 'package:al_pura_frontend/feature/shared/widget/options_bar/option_bar.dart';
import 'package:al_pura_frontend/feature/shared/widget/product_card.dart';
import 'package:flutter/material.dart';

class SaleScreen extends StatelessWidget {
  const SaleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;

    return Scaffold(

      //TODO: CHANGE TO SLIVER APP BAR
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: Colors.transparent,
        title: Text('Venta', style: textTheme.titleLarge!.copyWith(fontWeight: FontWeight.bold)),
      ),
      body: Row(
        children: [
          SizedBox(
            width: size.width * 0.6,
            child: const Column(
              children: [
                OptionBar(),
                SizedBox(height: 10,),
                Expanded(child: ProductsBoard())
              ],
            ),
          ),

          Expanded(
              child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Container(
                    color: Colors.white,
                    child: const Column(
                      children: [
                        ProductStaticPriceSale(),
                        ProductStaticPriceSale(),
                        ProductStaticPriceSale(),
                        ProductStaticPriceSale(),
                        ProductStaticPriceSale(),
                        ProductStaticPriceSale(),
                        ProductStaticPriceSale(),
                      ],
                    ),
                  ),
              ),
          )
        ],
      ),
    );
  }
}
