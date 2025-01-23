import 'package:flutter/material.dart';

class CustomCheckbox extends StatefulWidget {
  final String title;
  final Color color;
  final bool value;
  final double size;
  final void Function()? onChange;
  final bool isEditable;

  const CustomCheckbox({
    super.key,
    this.size = 20,
    required this.title,
    this.color = Colors.black,
    this.value = false,
    this.onChange,
    this.isEditable = true
  });

  @override
  State<CustomCheckbox> createState() => _CustomCheckboxState(currentValue: value);
}

class _CustomCheckboxState extends State<CustomCheckbox> {
  bool currentValue;

  _CustomCheckboxState({
    required this.currentValue
  });

  @override
  void didUpdateWidget(CustomCheckbox oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != oldWidget.value) {
      setState(() {
        currentValue = widget.value;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (widget.isEditable) {
          setState(() {
            currentValue = !currentValue;
          });
        }
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            widget.title,
            style: TextStyle(color: widget.color, fontSize: widget.size),
          ),
          SizedBox(
            height: widget.size * 2.2,
            width: widget.size * 2.2,
            child: FittedBox(
              fit: BoxFit.cover,
              child: Checkbox(
                activeColor: widget.color,
                side: BorderSide(width: 1, color: widget.color),
                value: currentValue,
                onChanged: (value) {
                  if (widget.isEditable) {
                    widget.onChange ?? ();
                    setState(() {
                      currentValue = value ?? false;
                    });
                  }
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
