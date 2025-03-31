import 'package:al_pura_frontend/feature/sale/presentation/providers/cart_provider.dart';
import 'package:al_pura_frontend/feature/shared/widget/buttons/custom_button.dart';
import 'package:al_pura_frontend/feature/shared/widget/fields/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OptionBar extends ConsumerWidget {
  const OptionBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
              ),
              Spacer(),
              CustomButton(
                  size: 60,
                  color: Colors.red,
                  icon: Icons.remove,
                  onPress: () {
                    ref.read(cartProvider.notifier).createTheReduceItem();
                  },
              ),

            ],
          );
        },
      ),
    );
  }
}
