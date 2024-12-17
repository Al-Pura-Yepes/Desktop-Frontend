import 'package:al_pura_frontend/feature/shared/widget/fields/custom_text_field.dart';
import 'package:flutter/material.dart';

class OptionBar extends StatelessWidget {
  const OptionBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      height: 100,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      margin: const EdgeInsets.symmetric(horizontal: 10),
      alignment: Alignment.center,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final width = constraints.maxWidth;
          return Row(
            children: [
              SizedBox(
                width: width > 600 ? width * 0.4 : width,
                height: 50,
                child: const CustomTextField(),
              )
            ],
          );
        },
      ),
    );
  }
}
