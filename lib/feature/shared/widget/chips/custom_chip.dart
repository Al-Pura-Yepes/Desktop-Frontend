import 'package:flutter/material.dart';

class CustomChip extends StatelessWidget {

  final Color color;
  final Text text;

  const CustomChip({super.key, required this.color, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10)
      ),
      child: text,
    );
  }
}
