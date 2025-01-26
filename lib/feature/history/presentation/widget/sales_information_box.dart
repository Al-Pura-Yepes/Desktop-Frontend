import 'package:al_pura_frontend/feature/history/presentation/provider/sales_provider.dart';
import 'package:al_pura_frontend/feature/shared/widget/checkbox/custom_checkbox.dart';
import 'package:al_pura_frontend/feature/shared/widget/text/label_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';


class SalesInformationBox extends ConsumerStatefulWidget {
  const SalesInformationBox({super.key});

  @override
  ConsumerState<SalesInformationBox> createState() => _SalesInformationBoxState();
}


class _SalesInformationBoxState extends ConsumerState<SalesInformationBox> {
  String? paymentMethod;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final isInformationLoaded = ref.watch(salesProvider).isSaleSelected;
    final sale = ref.watch(salesProvider).sale;
    final subTotal = sale?.products.keys.fold(0.0, (accumulator, product) {
      return accumulator + (sale.products[product]! * product.price!);
    });

    return Container(
      height: 330,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10))
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child: Text('Información de venta',
              textAlign: TextAlign.left,
              style: textTheme.titleSmall,
            ),
          ),
          Expanded(
            child: isInformationLoaded
              ? Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    spacing: 10,
                    children: [
                      Expanded(
                        child: Container(
                          height: 40,
                          decoration: BoxDecoration(
                              color: colorScheme.primary,
                              borderRadius: BorderRadius.circular(10)
                          ),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Pago por: ',
                                    style: textTheme.titleSmall!.copyWith(color: Colors.white, fontWeight: FontWeight.normal)),
                                Text(paymentMethod ?? 'Efectivo',
                                    style: textTheme.titleSmall!.copyWith(color: Colors.white, fontWeight: FontWeight.bold))
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Fecha de venta:',
                              style: textTheme.titleSmall!.copyWith(fontWeight: FontWeight.w300),),
                            Container(
                              alignment: Alignment.centerLeft,
                              height: 30,
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              decoration: BoxDecoration(
                                  border: Border.all(color: const Color(0xffC8C8C8)),
                                  borderRadius: BorderRadius.circular(8)),
                              child: Text(
                                  DateFormat('dd-MM-yyyy').format(sale!.dateTime),
                                  style: textTheme.bodySmall
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomCheckbox(
                            title: 'Envío por delivery',
                            value: sale.isDelivery,
                            isEditable: false,),
                          CustomCheckbox(
                            title: 'Venta al por mayor',
                            value: sale.isPerMajor,
                            isEditable: false,),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Row(
                            children: [
                              const Text('Subtotal: Bs. '),
                              Text(
                                  subTotal!.toStringAsFixed(2)
                              )
                            ],
                          ),
                          Row(
                            children: [
                              const Text('Descuento: Bs. '),
                              LabelBorder(
                                text: sale.discount.toStringAsFixed(2),
                                textStyle: textTheme.bodySmall!,
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Text('Total: ',
                                style: textTheme.titleMedium,),
                              Text('Bs. ${(subTotal - sale.discount).toStringAsFixed(2)}',
                                style: textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold),),
                            ],
                          )
                        ],
                      ),
                    ],
                  )
                ],
              ) : Icon(
              Icons.sticky_note_2_rounded,
              color: colorScheme.secondary,
              size: 40,
            ),
          )
        ],
      ),
    );
  }
}
