import 'package:al_pura_frontend/feature/reservation/domain/model/status.dart';
import 'package:al_pura_frontend/feature/reservation/presentation/provider/reservation_provider.dart';
import 'package:al_pura_frontend/feature/shared/widget/buttons/state_button.dart';
import 'package:al_pura_frontend/feature/shared/widget/checkbox/custom_checkbox.dart';
import 'package:al_pura_frontend/feature/shared/widget/text/label_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../shared/widget/buttons/custom_button.dart';

class ReservationInformationBox extends ConsumerWidget {
  const ReservationInformationBox({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final isInformationLoaded = ref.watch(reservationProvider).isReservationSelected;
    final reservation = ref.watch(reservationProvider).reservation;
    final subTotal = reservation?.products.fold(0.0, (accumulator, product) {
      return accumulator + (product.quantity * product.price!);
    });

    return Stack(
      children: [
        Container(
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
                            StateButton(
                              text: statusToString(reservation!.status),
                              color: reservation.status == Status.pending
                                  ? Colors.yellow
                                  : reservation.status == Status.ready
                                    ? colorScheme.tertiary
                                    : Colors.green,
                              secondaryColor: colorScheme.primary,
                              textColor: reservation.status == Status.pending
                                  ? Colors.black : Colors.white,
                              onChange: () {
                                if (reservation.status == Status.pending) {
                                  var reservationEditable = reservation;
                                  reservationEditable.status = Status.ready;
                                  ref.read(reservationProvider.notifier)
                                      .updateReservation(reservationEditable);
                                  ref.read(reservationProvider.notifier)
                                      .repository.updateStatus(reservation.id, Status.ready);
                                  ref.read(reservationProvider.notifier).loadReservations();
                                }
                              },
                            ),
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
                                    child: Text(
                                      DateFormat('dd-MM-yyyy').format(reservation.deliveryDate),
                                      style: textTheme.bodySmall
                                    ),
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
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomCheckbox(
                                title: 'Envío por delivery',
                                value: reservation.isDelivery,
                                isEditable: false,),
                              CustomCheckbox(
                                title: 'Venta al por mayor',
                                value: reservation.isPerMajor,
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
                                    text: reservation.discount.toStringAsFixed(2),
                                    textStyle: textTheme.bodySmall!,
                                  )
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
                              Text('Bs. ${(subTotal - reservation.discount).toStringAsFixed(2)}',
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
        ),
      ]
    );
  }
}
