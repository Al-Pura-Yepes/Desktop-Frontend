import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final double size;
  final Color color;
  final bool filled;
  final IconData icon;
  final Color iconColor;

  const CustomButton(
      {super.key,
      required this.size,
      this.color = Colors.red,
      this.filled = true,
      this.icon = Icons.add,
      this.iconColor = Colors.white});

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {},
        child: Container(
          alignment: Alignment.center,
          width: size,
          height: size,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: !filled ? null : color,
              border: filled ? null : Border.all(color: color, width: 3)),
          child: Icon(
            icon,
            size: size - 10,
            color: iconColor,
          ),
        ),
      ),
    );
  }
}
