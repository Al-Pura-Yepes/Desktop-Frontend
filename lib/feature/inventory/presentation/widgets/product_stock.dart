import 'package:al_pura_frontend/feature/shared/domain/model/product.dart';
import 'package:al_pura_frontend/feature/shared/widget/fields/custom_empty_field.dart';
import 'package:flutter/material.dart';

class ProductStock extends StatelessWidget {
  final Product product;

  const ProductStock({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final secondaryColor = Theme.of(context).colorScheme.secondary;
    final primaryColor = Theme.of(context).primaryColor;

    return Container(
      width: double.infinity,
      height: 200,
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(8), bottomRight: Radius.circular(8))),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Stock',
            style: textTheme.titleSmall,
          ),
          Expanded(
            child: SizedBox(
                width: double.infinity,
                child: FittedBox(
                  fit: BoxFit.contain,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '34',
                        style: textTheme.bodyLarge?.copyWith(fontSize: 40),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        'Kg',
                        style: textTheme.bodyLarge
                            ?.copyWith(fontSize: 40, color: secondaryColor),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                )),
          ),
          Container(
            alignment: Alignment.center,
            child: FittedBox(
              child: Container(
                child: _StockCounter(
                  primaryColor: primaryColor,
                  textTheme: textTheme,
                  isFixedPrice: product.isFixedPrice,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class _StockCounter extends StatefulWidget {
  final bool isFixedPrice;

  const _StockCounter({
    required this.isFixedPrice,
    required this.primaryColor,
    required this.textTheme,
  });

  final Color primaryColor;
  final TextTheme textTheme;

  @override
  State<_StockCounter> createState() => _StockCounterState();
}

class _StockCounterState extends State<_StockCounter> {
  late String unity;

  @override
  void initState() {
    super.initState();
    unity = widget.isFixedPrice ? "U" : "g";
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          decoration: const BoxDecoration(
              border:
                  Border.symmetric(horizontal: BorderSide(color: Colors.red))),
          child: TextButton(
            onPressed: () {},
            style: const ButtonStyle(
              fixedSize: WidgetStatePropertyAll(Size(100, 40)),
              backgroundColor: WidgetStatePropertyAll(Colors.red),
              shape: WidgetStatePropertyAll(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero,
                ),
              ),
            ),
            child: const Text(
              'Reducir',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
        ),
        Container(
          decoration:
              const BoxDecoration(border: Border.symmetric(horizontal: BorderSide())),
          child: Container(
              width: 200,
              height: 40,
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: const CustomEmptyField(
                suffix: 'Kg',
              )),
        ),
        Container(
          decoration: BoxDecoration(
              border: Border.symmetric(
                  horizontal: BorderSide(color: widget.primaryColor))),
          child: TextButton(
            onPressed: () {},
            style: ButtonStyle(
              fixedSize: const WidgetStatePropertyAll(Size(100, 40)),
              backgroundColor: WidgetStatePropertyAll(widget.primaryColor),
              shape: const WidgetStatePropertyAll(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero,
                ),
              ),
            ),
            child: const Text(
              'Agregar',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
        )
      ],
    );
  }
}
