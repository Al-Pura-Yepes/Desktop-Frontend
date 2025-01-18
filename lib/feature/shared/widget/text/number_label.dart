import 'package:flutter/material.dart';

class NumberLabel extends StatelessWidget {
  final int number;
  
  const NumberLabel({
    super.key,
    required this.number
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      width: 100,
      height: 40,
      decoration: BoxDecoration(
          border: Border.all(color: const Color(0xffC8C8C8)),
          borderRadius: BorderRadius.circular(8)),
      child: FittedBox(
          child: Text(number.toString(), style: textTheme.bodyMedium,)
      ),
    );
  }
}
