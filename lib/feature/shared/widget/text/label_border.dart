import 'package:flutter/material.dart';

class LabelBorder extends StatelessWidget {
  final String text;
  final TextStyle textStyle;
  final Color? color;
  final bool filled;
  
  const LabelBorder({
    super.key,
    required this.text,
    required this.textStyle,
    this.filled = false,
    this.color,
  });

  @override
  Widget build(BuildContext context) {

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      height: 40,
      constraints: const BoxConstraints(
        minWidth: 80
      ),
      decoration: BoxDecoration(
        color: filled ? color : null,
        border: Border.all(color: color ?? const Color(0xffC8C8C8)),
        borderRadius: BorderRadius.circular(8)),
      child: Center(child: Text(text, style: textStyle,)),
    );
  }
}
