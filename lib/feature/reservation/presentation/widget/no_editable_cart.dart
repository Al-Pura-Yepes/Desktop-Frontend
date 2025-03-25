import 'package:al_pura_frontend/feature/history/presentation/provider/sales_provider.dart';
import 'package:al_pura_frontend/feature/reservation/presentation/provider/reservation_provider.dart';
import 'package:al_pura_frontend/feature/sale/presentation/widget/product_static_price_sale.dart';
import 'package:al_pura_frontend/feature/shared/domain/model/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NoEditableCart extends ConsumerWidget {
  final TextTheme textTheme;
  final bool onHistoryScreen;

  const NoEditableCart(
      {super.key, required this.textTheme, required this.onHistoryScreen});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    late bool isInformationLoaded;
    late List<Product> products;
    late Map<Product, double> productsOnMap;

    if (onHistoryScreen) {
      isInformationLoaded = ref.watch(salesProvider).isSaleSelected;
      final sale = ref.watch(salesProvider).sale;
      productsOnMap = sale?.products ?? {};
    } else {
      isInformationLoaded =
          ref.watch(reservationProvider).isReservationSelected;
      final reservation = ref.watch(reservationProvider).reservation;
      products = reservation?.products ?? [];
    }

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
              child: isInformationLoaded
                  ? (onHistoryScreen
                          ? productsOnMap.keys.toList().isEmpty
                          : products.isEmpty)
                      ? Center(
                          child: Icon(
                            Icons.shopping_cart,
                            color: colorScheme.secondary,
                            size: 40,
                          ),
                        )
                      : ListView.builder(
                          itemCount: onHistoryScreen
                              ? productsOnMap.keys.toList().length
                              : products.length,
                          itemBuilder: (context, index) {
                            var product = onHistoryScreen
                                ? productsOnMap.keys.toList()[index]
                                : products[index];
                            return Container(
                              margin: const EdgeInsets.only(bottom: 20),
                              child: ProductStaticPriceSale(
                                  product: product,
                                  isEditable: false,
                                  quantity: onHistoryScreen
                                      ? productsOnMap[product]
                                      : null),
                            );
                          },
                        )
                  : Center(
                      child: Icon(
                        Icons.shopping_cart,
                        color: colorScheme.secondary,
                        size: 40,
                      ),
                    ),
            )
          ],
        ));
  }
}
