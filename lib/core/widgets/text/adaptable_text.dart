import 'package:flutter/material.dart';

class AdaptableText extends StatelessWidget {
  final String text;
  final TextStyle? style;

  const AdaptableText(this.text, {super.key, this.style});

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Text(
        text,
        style: style,
      ),
    );
  }
}
