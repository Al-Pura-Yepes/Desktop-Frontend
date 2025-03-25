import 'package:al_pura_frontend/feature/sale/presentation/providers/cart_provider.dart';
import 'package:al_pura_frontend/feature/sale/presentation/widget/confirm_sale.dart';
import 'package:al_pura_frontend/feature/sale/presentation/widget/sale_information_back.dart';
import 'package:al_pura_frontend/feature/shared/widget/buttons/custom_button.dart';
import 'package:al_pura_frontend/feature/shared/widget/checkbox/custom_checkbox.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SaleInformationFront extends ConsumerWidget {
  const SaleInformationFront({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;
    final secondaryColor = Theme.of(context).colorScheme.secondary;
    final cartState = ref.watch(cartProvider);

    return Container(
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(8), bottomRight: Radius.circular(8))),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: FittedBox(
                  fit: BoxFit.cover,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Información de la venta',
                    style: textTheme.titleMedium
                        ?.copyWith(fontWeight: FontWeight.bold),
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
                      const CustomButton(
                        size: 40,
                        color: Color(0xff464C59),
                        filled: false,
                        icon: Icons.notification_add,
                        iconColor: Color(0xff464C59),
                      ),
                      const SizedBox(width: 10),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                  child: FittedBox(
                      fit: BoxFit.scaleDown,
                      alignment: Alignment.centerLeft,
                      child: CustomCheckbox(
                        value: ref.watch(cartProvider).isDelivery,
                        onChange: () {
                          ref.read(cartProvider.notifier).toggleIsDelivery();
                        },
                        title: 'Envio por delivery',
                        size: 20,
                      ))),
              const SizedBox(
                width: 30,
              ),
              Flexible(
                child: FittedBox(
                  alignment: Alignment.centerRight,
                  fit: BoxFit.scaleDown,
                  child: Row(
                    children: [
                      Text(
                        'Subtotal: ',
                        style: textTheme.bodyMedium,
                      ),
                      Text(
                        'Bs. ${cartState.subtotal.toStringAsFixed(2)}',
                        style: textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                  child: FittedBox(
                      fit: BoxFit.scaleDown,
                      alignment: Alignment.centerLeft,
                      child: CustomCheckbox(
                        onChange:
                            ref.read(cartProvider.notifier).toggleIsPerMajor,
                        value: ref.watch(cartProvider).isPerMajor,
                        color: secondaryColor,
                        title: 'Venta al por mayor',
                        size: 20,
                      ))),
              const SizedBox(
                width: 30,
              ),
              Flexible(
                child: FittedBox(
                  alignment: Alignment.centerRight,
                  fit: BoxFit.scaleDown,
                  child: Row(
                    children: [
                      Text(
                        'Descuento: ',
                        style: textTheme.bodyMedium,
                      ),
                      Text(
                        'Bs. ',
                        style: textTheme.bodyMedium,
                      ),
                      SizedBox(
                        width: 100,
                        height: 60,
                        child: _DiscountField(),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: FittedBox(
                  alignment: Alignment.centerLeft,
                  fit: BoxFit.scaleDown,
                  child: Row(
                    children: [
                      CustomButton(
                        onPress: () {
                          ref
                              .read(cartProvider.notifier)
                              .setPaymentMethod(true);
                          if (ref.read(cartProvider).isDelivery) {
                            ref.read(cartProvider.notifier).changeWidgetOption(
                                const SaleInformationBack(), context: context);
                          } else {
                            ref
                                .read(cartProvider.notifier)
                                .changeWidgetOption(const ConfirmSale(), context: context);
                          }
                        },
                        size: 60,
                        color: secondaryColor,
                        icon: Icons.attach_money,
                      ),
                      const SizedBox(width: 10),
                      CustomButton(
                        size: 60,
                        color: const Color(0xff464C59),
                        icon: Icons.qr_code,
                        onPress: () {
                          ref
                              .read(cartProvider.notifier)
                              .setPaymentMethod(false);
                          if (ref.read(cartProvider).isDelivery) {
                            ref.read(cartProvider.notifier).changeWidgetOption(
                                const SaleInformationBack(), context: context);
                          } else {
                            ref
                                .read(cartProvider.notifier)
                                .changeWidgetOption(const ConfirmSale(), context: context);
                          }
                        },
                      ),
                      const SizedBox(width: 10),
                      CustomButton(
                        size: 60,
                        color: const Color(0xff1C1897),
                        icon: Icons.bookmark,
                        onPress: () {
                          ref
                              .read(cartProvider.notifier)
                              .setIsReservation(true);
                          ref
                              .read(cartProvider.notifier)
                              .changeWidgetOption(const SaleInformationBack(), context: context);
                        },
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                width: 30,
              ),
              Flexible(
                  child: FittedBox(
                      child: Text(
                'Total: Bs ${(cartState.totalPrice > 0 ? (cartState.totalPrice) : 0.00).toStringAsFixed(2)}',
                style: textTheme.titleMedium
                    ?.copyWith(fontWeight: FontWeight.bold),
              )))
            ],
          )
        ],
      ),
    );
  }
}

class _DiscountField extends ConsumerStatefulWidget {
  const _DiscountField({super.key});

  @override
  ConsumerState<_DiscountField> createState() => _DiscountFieldState();
}

class _DiscountFieldState extends ConsumerState<_DiscountField> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(
      text: ref.read(cartProvider).discount.toStringAsFixed(2),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void resetForm() {
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    final discount = ref.watch(cartProvider).discount;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (discount == 0 && _controller.text.isNotEmpty) {
        resetForm();
      }
    });
    return TextFormField(
      controller: _controller,
      enabled: ref.read(cartProvider).widgetOption is SaleInformationFront,
      onChanged: (value) {
        ref.read(cartProvider.notifier).decrementQuantity(double.tryParse(value) ?? 0);
      },
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'^\d{0,3}(?:\.\d*)?$')),
      ],
      style: const TextStyle(fontSize: 20),
      textAlign: TextAlign.center,
      textAlignVertical: TextAlignVertical.center,
      cursorHeight: 20,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
