import 'package:al_pura_frontend/feature/reservation/presentation/provider/reservation_provider.dart';
import 'package:al_pura_frontend/feature/shared/widget/buttons/state_button.dart';
import 'package:al_pura_frontend/feature/shared/widget/checkbox/custom_checkbox.dart';
import 'package:al_pura_frontend/feature/shared/widget/text/label_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../shared/widget/buttons/custom_button.dart';

class ReservationInformationBox extends ConsumerWidget {
  const ReservationInformationBox({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final isInformationLoaded = ref.watch(reservationProvider).isReservationSelected;

    return Container(
      height: 330,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10))
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            children: [
              Expanded(
                  child: Text('Información de la reserva',
                    textAlign: TextAlign.left,
                    style: textTheme.titleSmall,
                  )
              ),
              isInformationLoaded
                ? CustomButton(
                  size: 40,
                  icon: Icons.delete,
                  filled: false,
                  color: colorScheme.error,
                  iconColor: colorScheme.error,
                ) : const SizedBox.shrink()
            ],
          ),
          Expanded(
            child: isInformationLoaded
              ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 250,
                    child: Column(
                      children: [
                        const StateButton(text: 'En espera',),
                        SizedBox(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Fecha de entrega:',
                                style: textTheme.titleSmall!.copyWith(fontWeight: FontWeight.w300),),
                              Container(
                                alignment: Alignment.centerLeft,
                                height: 30,
                                padding: const EdgeInsets.symmetric(horizontal: 10),
                                decoration: BoxDecoration(
                                    border: Border.all(color: const Color(0xffC8C8C8)),
                                    borderRadius: BorderRadius.circular(8)),
                                child: Text('10-02-2024', style: textTheme.bodySmall,),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomCheckbox(title: 'Envío por delivery'),
                          CustomCheckbox(title: 'Venta al por mayor'),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const Row(
                            children: [
                              Text('Subtotal: Bs. '),
                              Text('23.00')
                            ],
                          ),
                          Row(
                            children: [
                              const Text('Descuento: Bs. '),
                              LabelBorder(text: '1000.00', textStyle: textTheme.bodySmall!,)
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          CustomButton(
                            size: 60,
                            color: colorScheme.secondary,
                            icon: Icons.attach_money,
                          ),
                          const SizedBox(width: 10),
                          const CustomButton(
                            size: 60,
                            color: Color(0xff464C59),
                            icon: Icons.qr_code,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text('Total: ',
                            style: textTheme.titleMedium,),
                          Text('Bs. 23.00',
                            style: textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold),),
                        ],
                      )
                    ]
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
