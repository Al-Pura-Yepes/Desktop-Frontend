import 'package:al_pura_frontend/feature/sale/presentation/widget/product_static_price_sale.dart';
import 'package:flutter/material.dart';

class SaleCart extends StatelessWidget {
  const SaleCart({
    super.key,
    required this.textTheme,
    this.isOnReservationMode = false
  });

  final TextTheme textTheme;
  final bool isOnReservationMode;

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
                    child: ProductStaticPriceSale(isEditable: !isOnReservationMode,),
                  );
                },
              ),
            )
          ],
        ));
  }
}
