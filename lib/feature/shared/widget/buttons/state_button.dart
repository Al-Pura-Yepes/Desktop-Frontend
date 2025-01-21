import 'package:flutter/material.dart';

class StateButton extends StatelessWidget {
  final String text;
  final Color color;
  final Color secondaryColor;
  final Color textColor;
  final Function? onChange;

  const StateButton({
    super.key,
    required this.text,
    this.color = Colors.blue,
    this.secondaryColor = Colors.black38,
    this.textColor = Colors.white,
    this.onChange
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => onChange!(),
        child: Row(
          children: [
            Expanded(
              child: Container(
                height: 40,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(5),
                      bottomLeft: Radius.circular(5)
                  )
                ),
                child: Text(text, style: textTheme.titleSmall!.copyWith(color: textColor),)
              ),
            ),
            Container(
              width: 50,
              height: 40,
              decoration: BoxDecoration(
                  color: secondaryColor,
                  borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(5),
                      bottomRight: Radius.circular(5)
                  )
              ),
              child: const Icon(Icons.arrow_forward_ios_rounded, color: Colors.white,)
            )
          ],
        ),
      ),
    );
  }
}
