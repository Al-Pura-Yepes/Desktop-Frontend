import 'package:al_pura_frontend/feature/shared/Domain/model/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
                decoration: BoxDecoration(border: Border.all()),
                child: _StockCounter(primaryColor: primaryColor, textTheme: textTheme, isFixedPrice: product.isFixedPrice,),
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
    super.key,
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
    unity =  widget.isFixedPrice ? "U" : "g";
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextButton(
          onPressed: () {

          },
          child: Text(
            'Reducir',
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          style: ButtonStyle(
            fixedSize: WidgetStatePropertyAll(Size(100, 50)),
            backgroundColor: WidgetStatePropertyAll(Colors.red),
            shape: WidgetStatePropertyAll(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.zero,
              ),
            ),
          ),
        ),
        Container(
          width: 100,
          height: 40,
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: TextFormField(
            cursorHeight: 30,
            cursorWidth: 2,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 30),
            decoration: const InputDecoration(
              border: InputBorder.none,
              isDense: true,
              contentPadding: EdgeInsets.zero,
            ),
            onChanged: (value) {
              setState(() {
                if (value.length >= 3 && !widget.isFixedPrice) unity = "g";
                if (value.length < 3 && !widget.isFixedPrice) unity = "Kg";
              });
            },
            inputFormatters: [
              LengthLimitingTextInputFormatter(4),
              FilteringTextInputFormatter.digitsOnly
            ],
          ),
        ),
        SizedBox(
          width: 30,
          child: Text(
            unity,
            textAlign: TextAlign.center,
            style:
                widget.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(width: 10,),
        TextButton(
          onPressed: () {

          },
          child: Text(
            'Agregar',
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          style: ButtonStyle(
            fixedSize: WidgetStatePropertyAll(Size(100, 50)),
            backgroundColor: WidgetStatePropertyAll(widget.primaryColor),
            shape: WidgetStatePropertyAll(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.zero,
              ),
            ),
          ),
        )
      ],
    );
  }
}
