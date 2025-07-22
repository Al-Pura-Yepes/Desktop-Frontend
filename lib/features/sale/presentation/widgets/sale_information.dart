import 'package:al_pura_frontend/core/widgets/buttons/custom_button.dart';
import 'package:al_pura_frontend/features/sale/domain/entities/payment_method.dart';
import 'package:al_pura_frontend/features/sale/domain/entities/sale_type.dart';
import 'package:al_pura_frontend/features/sale/presentation/providers/sale_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SaleInformation extends ConsumerWidget {

  final String saleId;
  final bool isNew;

  const SaleInformation({super.key, this.saleId = '', this.isNew = true});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;
    final saleState = ref.watch(saleProvider(saleId));

    return Container(
      decoration: const BoxDecoration(
          color: Colors.black,
      ),
      padding: const EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          //Titulo
          Expanded(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    'Información de la venta',
                    style: textTheme.titleSmall
                        ?.copyWith(fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  spacing: 5,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    if (!isNew) FractionallySizedBox(
                      heightFactor: 0.6,
                      child: CustomButton(
                        size: 45,
                        color: Colors.grey,
                        filled: false,
                        icon: Icons.refresh,
                        iconColor: Colors.grey,
                        onPress: () {
                          ref.read(saleProvider(saleId).notifier).loadSale();
                        },
                      ),
                    ),
                    if (!isNew) FractionallySizedBox(
                      heightFactor: 0.6,
                      child: CustomButton(
                        size: 45,
                        color: Colors.green,
                        filled: false,
                        icon: Icons.save,
                        iconColor: Colors.green,
                        onPress: () {
                          ref.read(saleProvider(saleId).notifier).updateSale();
                        },
                      ),
                    ),
                    FractionallySizedBox(
                      heightFactor: 0.6,
                      child: CustomButton(
                        size: 45,
                        color: saleState.isAvailable ? Colors.red : Colors.blue,
                        filled: false,
                        icon: saleState.isAvailable ? Icons.delete : Icons.restore,
                        iconColor: saleState.isAvailable ? Colors.red : Colors.blue,
                        onPress: () {
                          if (isNew){
                            ref.read(saleProvider(saleId).notifier).clear();
                          } else {
                            ref.read(saleProvider(saleId).notifier).toggleSale();
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          //Info adicional
          Expanded(
            flex: 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Spacer(),
                    Row(
                      children: [
                        Text(
                          'Subtotal: ',
                          style: textTheme.bodyMedium?.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Bs. ${saleState.subtotal.toStringAsFixed(2)}',
                          style: textTheme.bodyMedium?.copyWith(color: Colors.white),
                        ),
                      ],
                    ),
                  ],
                ),

                Row(
                  children: [
                    const Spacer(flex: 3,),
                    Text(
                      'Descuento: ',
                      style: textTheme.bodyMedium?.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Bs. ',
                      style: textTheme.bodyMedium?.copyWith(color: Colors.white),
                    ),
                    Expanded(
                      child: _DiscountField(
                        value: saleState.discount,
                        onChanged: (value) {
                          ref.read(saleProvider(saleId).notifier).updateDiscount(value);
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),


          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,

              children: [
                LayoutBuilder(builder: (context, constraints) {
                  return SizedBox(
                    width: constraints.maxHeight * 3,
                    child: Row(
                      spacing: 5,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          child: CustomButton(
                            onPress: () {
                              const saleType = SaleTypes.DIRECT_SALE;
                              const saleMethod = PaymentMethods.CASH;
                              ref.read(saleProvider(saleId).notifier).updateSaleType(SaleType(id: saleType.id, label: saleType.title));
                              ref.read(saleProvider(saleId).notifier).updatePaymentMethod(PaymentMethod(id: saleMethod.id, label: saleMethod.title));
                              if (isNew) {
                                ref.read(saleProvider(saleId).notifier).createSale();
                              } else {
                                ref.read(saleProvider(saleId).notifier).updateSale();
                              }
                            },
                            size: 60,
                            color: Colors.white,
                            icon: Icons.attach_money,
                            iconColor: Colors.black,
                          ),
                        ),

                        Expanded(
                          child: CustomButton(
                            size: 60,
                            color: Colors.white,
                            icon: Icons.qr_code,
                            iconColor: Colors.black,
                            onPress: () {
                              const saleType = SaleTypes.DIRECT_SALE;
                              const saleMethod = PaymentMethods.QR;
                              ref.read(saleProvider(saleId).notifier).updateSaleType(SaleType(id: saleType.id, label: saleType.title));
                              ref.read(saleProvider(saleId).notifier).updatePaymentMethod(PaymentMethod(id: saleMethod.id, label: saleMethod.title));
                              if (isNew) {
                                ref.read(saleProvider(saleId).notifier).createSale();
                              } else {
                                ref.read(saleProvider(saleId).notifier).updateSale();
                              }
                            },
                          ),
                        ),

                        Expanded(
                          child: isNew ? CustomButton(
                            size: 60,
                            color: Colors.white,
                            icon: Icons.bookmark,
                            iconColor: Colors.black,
                            onPress: () {
                              const saleType = SaleTypes.RESERVATION;
                              const saleMethod = PaymentMethods.CASH;
                              ref.read(saleProvider(saleId).notifier).updateSaleType(SaleType(id: saleType.id, label: saleType.title));
                              ref.read(saleProvider(saleId).notifier).updatePaymentMethod(PaymentMethod(id: saleMethod.id, label: saleMethod.title));
                              ref.read(saleProvider(saleId).notifier).createSale();
                            },
                          ) : const SizedBox(),
                        ),
                      ],
                    ),
                  );
                },),

                Expanded(
                    child: Text(
                      textAlign: TextAlign.end,
                                      'Total: Bs ${(saleState.totalPrice > 0 ? (saleState.totalPrice) : 0.00).toStringAsFixed(2)}',
                                      style: textTheme.titleMedium
                                          ?.copyWith(fontWeight: FontWeight.bold, color: Colors.white),
                                    ))
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _DiscountField extends ConsumerStatefulWidget {
  final double value;
  final void Function(double) onChanged;

  const _DiscountField({
    required this.value,
    required this.onChanged,
  });

  @override
  ConsumerState<_DiscountField> createState() => _DiscountFieldState();
}

class _DiscountFieldState extends ConsumerState<_DiscountField> {
  late TextEditingController _controller;
  bool _isUpdatingFromParent = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.value.toString());
  }

  @override
  void didUpdateWidget(_DiscountField oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Only update the controller if the value changed from outside (not from user input)
    if (widget.value != oldWidget.value && !_isUpdatingFromParent) {
      _controller.text = widget.value.toString();
    }
    _isUpdatingFromParent = false;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _controller,
      onChanged: (textValue) {
        _isUpdatingFromParent = true;
        final numericValue = double.tryParse(textValue) ?? 0.0;
        widget.onChanged(numericValue);
      },
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'^\d{0,3}(?:\.\d*)?$')),
      ],
      style: const TextStyle(fontSize: 20, color: Colors.white),
      textAlign: TextAlign.center,
      textAlignVertical: TextAlignVertical.center,
      cursorHeight: 20,
      cursorColor: Colors.white,
      decoration: const InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 12),
      ),
    );
  }
}
