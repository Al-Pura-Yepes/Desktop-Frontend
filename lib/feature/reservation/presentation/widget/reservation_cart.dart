import 'package:al_pura_frontend/feature/reservation/presentation/provider/reservation_provider.dart';
import 'package:al_pura_frontend/feature/sale/presentation/widget/product_static_price_sale.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ReservationCart extends ConsumerWidget {
  final TextTheme textTheme;

  const ReservationCart({
    super.key,
    required this.textTheme,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final isInformationLoaded = ref.watch(reservationProvider).isReservationSelected;
    final reservation = ref.watch(reservationProvider).reservation;
    final products = reservation?.products ?? [];

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
                  ? (products.isEmpty)
                    ? Center(
                      child: Icon(
                      Icons.shopping_cart,
                      color: colorScheme.secondary,
                      size: 40,
                      ),
                    ) : ListView.builder(
                      itemCount: products.length,
                      itemBuilder: (context, index) {
                        var product = products[index];
                        return Container(
                          margin: const EdgeInsets.only(bottom: 20),
                          child: ProductStaticPriceSale(product: product, onReservationMode: true),
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
