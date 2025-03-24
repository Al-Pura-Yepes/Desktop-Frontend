import 'package:al_pura_frontend/feature/sale/presentation/providers/cart_provider.dart';
import 'package:al_pura_frontend/feature/sale/presentation/widget/confirm_sale.dart';
import 'package:al_pura_frontend/feature/sale/presentation/widget/custom_date_picker.dart';
import 'package:al_pura_frontend/feature/sale/presentation/widget/sale_information_front.dart';
import 'package:al_pura_frontend/feature/shared/widget/buttons/custom_button.dart';
import 'package:al_pura_frontend/feature/shared/widget/chips/custom_chip.dart';
import 'package:al_pura_frontend/feature/shared/widget/fields/custom_title_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SaleInformationBack extends ConsumerWidget {
  const SaleInformationBack({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;
    final primaryColor = Theme.of(context).primaryColor;
    final secondaryColor = Theme.of(context).colorScheme.secondary;
    final cartState = ref.watch(cartProvider);

    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
          color: primaryColor,
          borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(8), bottomRight: Radius.circular(8))),
      child: LayoutBuilder(
        builder: (context, constraints) => Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: FittedBox(
                    fit: BoxFit.cover,
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Información de la venta',
                      style: textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 30,
                ),
                Flexible(
                  child: FittedBox(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        CustomButton(
                          size: 40,
                          color: Colors.red,
                          filled: false,
                          icon: Icons.delete,
                          iconColor: Colors.red,
                          onPress: () {
                            ref.read(cartProvider.notifier).resetCart();
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: constraints.maxHeight * 0.2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                      width: constraints.maxWidth * 0.45,
                      child: CustomTitleField(title: 'Nombre del cliente', onPress: (value) => ref.read(cartProvider.notifier).setClientName(value),)),
                  SizedBox(
                      width: constraints.maxWidth * 0.45,
                      child: CustomTitleField(title: 'Celular del cliente', onPress: (value) => ref.read(cartProvider.notifier).setClientPhone(value))),
                ],
              ),
            ),
            SizedBox(
              height: constraints.maxHeight * 0.4,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: constraints.maxWidth * 0.45,
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      alignment: Alignment.bottomLeft,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (cartState.isDelivery) CustomChip(
                              color: secondaryColor,
                              text: Text(
                                'Envio por delivery',
                                style: textTheme.bodySmall
                                    ?.copyWith(color: Colors.white),
                              )),
                          const SizedBox(
                            height: 5,
                          ),
                          if (cartState.isReservation) CustomChip(
                              color: secondaryColor,
                              text: Text(
                                'Reserva',
                                style: textTheme.bodySmall
                                    ?.copyWith(color: Colors.white),
                              ))
                        ],
                      ),
                    ),
                  ),
                  if (ref.read(cartProvider).isReservation)
                    SizedBox(
                      height: constraints.maxHeight * 0.22,
                      width: constraints.maxWidth * 0.45,
                      child: CustomDatePickerField(
                        color: Colors.black,
                        title: 'Fecha de reserva',
                        onDateSelected: (date) {
                          ref.read(cartProvider.notifier).setReservationDate(date);
                        },
                      ),
                    ),
                ],
              ),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FittedBox(
                      child: Row(
                    children: [
                      CustomButton(
                        size: 60,
                        filled: false,
                        color: Colors.green,
                        icon: Icons.check,
                        iconColor: Colors.green,
                        onPress: () {
                          ref
                              .read(cartProvider.notifier)
                              .changeWidgetOption(const ConfirmSale());
                        },
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      CustomButton(
                        size: 60,
                        filled: false,
                        color: Colors.red,
                        icon: Icons.close,
                        iconColor: Colors.red,
                        onPress: () {
                          ref.read(cartProvider.notifier).setIsReservation(false);
                          ref
                              .read(cartProvider.notifier)
                              .changeWidgetOption(const SaleInformationFront());
                        },
                      ),
                    ],
                  )),
                  FittedBox(
                      child: Text(
                        'Total: Bs ${(cartState.totalPrice - cartState.discount).toStringAsFixed(2)}',
                        style: textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.bold, color: Colors.white),
                      ))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
