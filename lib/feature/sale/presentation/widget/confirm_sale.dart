import 'package:al_pura_frontend/feature/sale/presentation/providers/cart_provider.dart';
import 'package:al_pura_frontend/feature/shared/widget/buttons/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ConfirmSale extends ConsumerWidget {
  const ConfirmSale({super.key});

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
                'Deseas  ',
                textAlign: TextAlign.center,
                style: textTheme.bodyMedium?.copyWith(color: Colors.white),
              ),
              Text(
                'CONFIRMAR',
                textAlign: TextAlign.center,
                style: textTheme.bodyLarge?.copyWith(color: Colors.green),
              ),
              Text(
                ' el pedido?',
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
                      ref.read(cartProvider.notifier).sale();
                      ref.read(cartProvider.notifier).resetCart();
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
                      ref.read(cartProvider.notifier).changeWidgetOption(
                          ref.read(cartProvider).lastWidget);
                    },
                  )),
            ],
          )
        ],
      ),
    );
  }
}
