import 'package:al_pura_frontend/features/sale/presentation/widgets/sale_information.dart';
import 'package:al_pura_frontend/features/sale/presentation/providers/sale_provider.dart';
import 'package:al_pura_frontend/features/store/presentation/widget/products_board.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../widgets/products_cart.dart';

class SaleScreen extends ConsumerWidget {
  const SaleScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;

    return Row(
      children: [
        // PRODUCTS
        Expanded(
            flex: 2,
            child: StoreBoard(
              callback: ref.read(saleProvider('').notifier).addProduct,
            )),
        const VerticalDivider(
          width: 0.2,
          color: Colors.black,
        ),
        // SALE INFO
        const Expanded(
          flex: 1,
          child: Column(
            children: [
              Expanded(
                flex: 3,
                child: ProductsCart(
                  saleId: '',
                ),
              ),
              Divider(
                color: Colors.white,
                height: 0.2,
              ),
              Expanded(
                flex: 2,
                child: SaleInformation(),
              ),
            ],
          ),
        )
      ],
    );
  }
}
