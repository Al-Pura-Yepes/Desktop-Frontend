import 'package:flutter/material.dart';

class StateButton extends StatelessWidget {
  final String text;

  const StateButton({
    super.key,
    required this.text
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Row(
      children: [
        Expanded(
          child: Container(
            height: 40,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: colorScheme.tertiary,
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(5),
                  bottomLeft: Radius.circular(5)
              )
            ),
            child: Text(text, style: textTheme.titleSmall!.copyWith(color: Colors.white),)
          ),
        ),
        Container(
          width: 50,
          height: 40,
          decoration: BoxDecoration(
              color: colorScheme.primary,
              borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(5),
                  bottomRight: Radius.circular(5)
              )
          ),
          child: const Icon(Icons.arrow_forward_ios_rounded, color: Colors.white,)
        )
      ],
    );
  }
}
