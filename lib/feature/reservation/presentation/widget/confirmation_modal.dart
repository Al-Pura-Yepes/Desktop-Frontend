import 'package:al_pura_frontend/feature/shared/widget/buttons/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ConfirmationModal extends ConsumerWidget {
  final String leftText;
  final String rightText;
  final String highlightedText;
  final Function? onConfirmation;
  final Function? onCanceled;

  const ConfirmationModal({
    super.key,
    required this.leftText,
    required this.highlightedText,
    required this.rightText,
    this.onConfirmation,
    this.onCanceled
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final primaryColor = Theme.of(context).primaryColor;
    final secondaryColor = Theme.of(context).colorScheme.secondary;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      decoration: BoxDecoration(
          color: primaryColor,
          borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(8), bottomRight: Radius.circular(8))),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                leftText,
                textAlign: TextAlign.center,
                style: textTheme.bodyMedium?.copyWith(color: Colors.white),
              ),
              Text(
                highlightedText.toUpperCase(),
                textAlign: TextAlign.center,
                style: textTheme.bodyLarge?.copyWith(color: Colors.green),
              ),
              Text(
                rightText,
                textAlign: TextAlign.center,
                style: textTheme.bodyMedium?.copyWith(color: Colors.white),
              ),
            ],
          ),
          const SizedBox(
            height: 40,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FittedBox(
                  fit: BoxFit.scaleDown,
                  child: CustomButton(
                    size: 60,
                    color: Colors.green,
                    icon: Icons.check,
                    onPress: () {
                      if (onConfirmation != null) {
                        onConfirmation!();
                      }
                    },
                  )),
              const SizedBox(
                width: 70,
              ),
              FittedBox(
                  fit: BoxFit.scaleDown,
                  child: CustomButton(
                    size: 60,
                    color: Colors.red,
                    icon: Icons.close,
                    onPress: () {
                      if (onCanceled != null) {
                        onCanceled!();
                      }
                    },
                  )),
            ],
          )
        ],
      ),
    );
  }
}