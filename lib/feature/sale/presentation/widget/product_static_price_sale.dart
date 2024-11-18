import 'package:flutter/material.dart';

class ProductStaticPriceSale extends StatelessWidget {
  final double widgetHeight = 70;
  const ProductStaticPriceSale({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      height: widgetHeight,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              const _QuantityCounter(),
              const SizedBox(
                width: 5,
              ),
              SizedBox(
                width: 250,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Nombre del producto',
                      style: textTheme.titleSmall?.copyWith(fontSize: 17),
                    ),
                    Text(
                      'Datos adicionales del producto',
                      style: textTheme.bodyMedium?.copyWith(fontSize: 15),
                    )
                  ],
                ),
              ),
            ],
          ),
          const Expanded(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Bs.',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(
                width: 10,
              ),
              Text('38.00')
            ],
          )),
          const Icon(
            Icons.close,
            size: 30,
            color: Colors.red,
          ),
        ],
      ),
    );
  }
}

class _QuantityCounter extends StatefulWidget {
  const _QuantityCounter({super.key});

  @override
  State<_QuantityCounter> createState() => _QuantityCounterState();
}

class _QuantityCounterState extends State<_QuantityCounter> {
  int counter = 1;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      width: 100,
      decoration: BoxDecoration(
          border: Border.all(
            color: const Color(0xffC8C8C8),
          ),
          borderRadius: BorderRadius.circular(10)),
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => setState(() {
              counter = counter + 1;
            }),
            child: const Icon(Icons.add, color: Color(0xffC8C8C8)),
          ),
          const SizedBox(
            width: 2,
          ),
          Expanded(
            child: Center(child: Text(counter.toString())),
          ),
          const SizedBox(
            width: 2,
          ),
          GestureDetector(
              onTap: () => setState(() {
                    counter = counter - 1;
                  }),
              child: const Icon(
                Icons.remove,
                color: Color(0xffC8C8C8),
              )),
        ],
      ),
    );
  }
}
