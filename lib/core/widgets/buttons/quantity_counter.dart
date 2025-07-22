import 'package:flutter/material.dart';

class QuantityCounter extends StatefulWidget {
  final void Function(double quantity) callback;
  final bool isEditable;
  final double value;
  const QuantityCounter({super.key, required this.callback, this.isEditable = true, this.value = 0});

  @override
  State<QuantityCounter> createState() => QuantityCounterState();
}

class QuantityCounterState extends State<QuantityCounter> {
  late double counter;

  @override
  void initState() {
    this.counter = widget.value;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: const Color(0xffC8C8C8)),
          ),
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (widget.isEditable) IconButton(
                onPressed: () {
                  setState(() {
                    if (counter < 30) {
                      counter++;
                      widget.callback(counter);
                    }
                  });
                },
                icon: const Icon(Icons.add)),
            SizedBox(
              width: 30,
              child: Text(
                widget.value.toString(),
                style: textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
            ),
            if (widget.isEditable) IconButton(
                onPressed: () {
                  setState(() {
                    if (counter > 1) {
                      counter--;
                      widget.callback(counter);
                    }
                  });
                },
                icon: const Icon(Icons.remove)),
          ],
        ),
      ),
    );
  }
}
