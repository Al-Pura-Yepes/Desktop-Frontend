import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomEmptyField extends StatelessWidget {
  final String? suffix;
  final List<TextInputFormatter>? formatters;
  final void Function(String)? onChanged;

  const CustomEmptyField(
      {super.key, this.suffix, this.formatters, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double height = constraints.maxHeight;
        return Row(
          children: [
            Flexible(
              child: TextFormField(
                cursorHeight: height * 0.7,
                cursorWidth: 1,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: height * 0.6),
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.zero,
                  border: InputBorder.none,
                ),
                onChanged: onChanged,
                inputFormatters: formatters,
              ),
            ),
            if (suffix != null)
              Container(
                  alignment: Alignment.center, width: 40, child: Text(suffix!)),
          ],
        );
      },
    );
  }
}
