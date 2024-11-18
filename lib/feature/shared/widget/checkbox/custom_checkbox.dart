import 'package:flutter/material.dart';

class CustomCheckbox extends StatefulWidget {
  final String title;
  final Color color;
  final bool value;
  final void Function()? onChange;

  const CustomCheckbox(
      {super.key,
      required this.title,
      this.color = Colors.black,
      this.value = false,
      this.onChange});

  @override
  State<CustomCheckbox> createState() => _CustomCheckboxState();
}

class _CustomCheckboxState extends State<CustomCheckbox> {
  bool currentValue = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          widget.title,
          style: TextStyle(color: widget.color),
        ),
        SizedBox(
          height: 50,
          width: 50,
          child: FittedBox(
            fit: BoxFit.cover,
            child: Checkbox(
              activeColor: widget.color,
              side: BorderSide(width: 1, color: widget.color),
              value: currentValue,
              onChanged: (value) {
                widget.onChange ?? ();
                setState(() {
                  currentValue = value ?? false;
                });
              },
            ),
          ),
        )
      ],
    );
  }
}
