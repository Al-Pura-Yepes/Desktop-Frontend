import 'package:flutter/material.dart';

class QuantityCounter extends StatefulWidget {
  const QuantityCounter({super.key});

  @override
  State<QuantityCounter> createState() => QuantityCounterState();
}

class QuantityCounterState extends State<QuantityCounter> {
  int counter = 1;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: const Color(0xffC8C8C8)),
          borderRadius: BorderRadius.circular(8)),
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
                onPressed: () {
                  setState(() {
                    counter = counter + 1;
                  });
                },
                icon: const Icon(Icons.add)),
            SizedBox(
              width: 30,
              child: Text(
                counter.toString(),
                style: textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
            ),
            IconButton(
                onPressed: () {
                  setState(() {
                    counter = counter - 1;
                  });
                },
                icon: const Icon(Icons.remove)),
          ],
        ),
      ),
    );
  }
}
