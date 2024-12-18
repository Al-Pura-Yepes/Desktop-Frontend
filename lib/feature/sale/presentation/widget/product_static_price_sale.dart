import 'package:flutter/material.dart';

import '../../../shared/widget/buttons/quantity_counter.dart';

class ProductStaticPriceSale extends StatelessWidget {
  final double widgetHeight = 70;
  const ProductStaticPriceSale({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return FittedBox(
      fit: BoxFit.fitWidth,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const QuantityCounter(),
            const SizedBox(
              width: 15,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Texto de prueba titulo', style: textTheme.titleSmall),
                Text(
                  'Texto de prueba descripcion',
                  style: textTheme.bodySmall,
                )
              ],
            ),
            const SizedBox(
              width: 40,
            ),
            const Row(
              children: [
                Text('Bs'),
                Text('15.00'),
              ],
            ),
            const SizedBox(
              width: 30,
            ),
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.delete,
                  size: 30,
                  color: Colors.red,
                ))
          ],
        ),
      ),
    );
  }
}
