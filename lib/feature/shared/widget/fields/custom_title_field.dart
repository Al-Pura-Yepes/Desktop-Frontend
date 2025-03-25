import 'package:flutter/material.dart';

class CustomTitleField extends StatelessWidget {
  final Color color;
  final String? initialValue;
  final String title;
  final void Function(String value) onPress;

  const CustomTitleField(
      {super.key,
      this.color = Colors.white,
      required this.title,
      required this.onPress,
      this.initialValue});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double fontSize = constraints.maxHeight * 0.25;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                title,
                style: TextStyle(fontSize: fontSize + 3, color: color),
              ),
            ),
            Expanded(
              child: TextFormField(
                initialValue: initialValue,
                onChanged: (value) => onPress(value),
                cursorColor: color,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: color),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: color),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: color),
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: color),
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    vertical: constraints.maxHeight * 0.1,
                    horizontal: constraints.maxWidth * 0.05,
                  ),
                ),
                style: TextStyle(
                  fontSize: fontSize,
                  color: color,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
