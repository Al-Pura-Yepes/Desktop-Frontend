import 'package:al_pura_frontend/feature/reservation/domain/model/reservation.dart';
import 'package:al_pura_frontend/feature/reservation/domain/model/status.dart';
import 'package:al_pura_frontend/feature/reservation/presentation/provider/reservation_provider.dart';
import 'package:al_pura_frontend/feature/reservation/presentation/widget/confirmation_modal.dart';
import 'package:al_pura_frontend/feature/shared/widget/buttons/state_button.dart';
import 'package:al_pura_frontend/feature/shared/widget/checkbox/custom_checkbox.dart';
import 'package:al_pura_frontend/feature/shared/widget/text/label_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../shared/widget/buttons/custom_button.dart';

class ReservationInformationBox extends ConsumerStatefulWidget {
  const ReservationInformationBox({super.key});

  @override
  ConsumerState<ReservationInformationBox> createState() =>
      _ReservationInformationBoxState();
}

class _ReservationInformationBoxState
    extends ConsumerState<ReservationInformationBox> {
  bool isPaymentSectionShown = false;
  bool isDeletionConfirmationModal = false;
  String? paymentMethod;

  Future<void> managePaymentConfirmation(Reservation reservation) async {
    setState(() {
      isPaymentSectionShown = false;
      paymentMethod = null;
    });
    var payConfirmed = await ref
        .read(reservationProvider.notifier)
        .repository
        .confirmPayment(reservation.id, paymentMethod ?? 'Efectivo');

    if (payConfirmed) {
      var reservationEditable = reservation;
      reservationEditable.status = Status.completed;
      ref
          .read(reservationProvider.notifier)
          .updateReservation(reservationEditable);
      ref.read(reservationProvider.notifier).loadReservations();
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Error happens while confirming payment')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final isInformationLoaded =
        ref.watch(reservationProvider).isReservationSelected;
    final reservation = ref.watch(reservationProvider).reservation;
    final subTotal = reservation?.products.fold(0.0, (accumulator, product) {
      return accumulator + (product.quantity * product.price!);
    });

    return Container(
      height: 330,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: Stack(children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              children: [
                Expanded(
                    child: Text(
                  'Información de la reserva',
                  textAlign: TextAlign.left,
                  style: textTheme.titleSmall,
                )),
                isInformationLoaded
                    ? CustomButton(
                        size: 40,
                        icon: Icons.delete,
                        filled: false,
                        color: colorScheme.error,
                        iconColor: colorScheme.error,
                        onPress: () {
                          setState(() {
                            isDeletionConfirmationModal = true;
                          });
                        },
                      )
                    : const SizedBox.shrink()
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
                                status: reservation!.status,
                                color: reservation.status == Status.pending
                                    ? Colors.yellow
                                    : reservation.status == Status.ready
                                        ? colorScheme.tertiary
                                        : Colors.green,
                                secondaryColor: colorScheme.primary,
                                textColor: reservation.status == Status.pending
                                    ? Colors.black
                                    : Colors.white,
                                onChange: () {
                                  if (reservation.status == Status.pending) {
                                    var reservationEditable = reservation;
                                    reservationEditable.status = Status.ready;
                                    ref
                                        .read(reservationProvider.notifier)
                                        .updateReservation(reservationEditable);
                                    ref
                                        .read(reservationProvider.notifier)
                                        .repository
                                        .updateStatus(
                                            reservation.id, Status.ready);
                                    ref
                                        .read(reservationProvider.notifier)
                                        .loadReservations();
                                  }
                                },
                                revertState: () {
                                  if (reservation.status == Status.ready) {
                                    var reservationEditable = reservation;
                                    reservationEditable.status = Status.pending;
                                    ref
                                        .read(reservationProvider.notifier)
                                        .updateReservation(reservationEditable);
                                    ref
                                        .read(reservationProvider.notifier)
                                        .repository
                                        .updateStatus(
                                            reservation.id, Status.pending);
                                    ref
                                        .read(reservationProvider.notifier)
                                        .loadReservations();
                                  } else if (reservation.status ==
                                      Status.completed) {
                                    var reservationEditable = reservation;
                                    reservationEditable.status = Status.ready;
                                    ref
                                        .read(reservationProvider.notifier)
                                        .updateReservation(reservationEditable);
                                    ref
                                        .read(reservationProvider.notifier)
                                        .repository
                                        .updateStatus(
                                            reservation.id, Status.ready);
                                    ref
                                        .read(reservationProvider.notifier)
                                        .loadReservations();
                                  }
                                },
                              ),
                              SizedBox(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Fecha de entrega:',
                                      style: textTheme.titleSmall!.copyWith(
                                          fontWeight: FontWeight.w300),
                                    ),
                                    Container(
                                      alignment: Alignment.centerLeft,
                                      height: 30,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: const Color(0xffC8C8C8)),
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                      child: Text(
                                          DateFormat('dd-MM-yyyy')
                                              .format(reservation.deliveryDate),
                                          style: textTheme.bodySmall),
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
                                  isEditable: false,
                                ),
                                CustomCheckbox(
                                  title: 'Venta al por mayor',
                                  value: reservation.isPerMajor,
                                  isEditable: false,
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Row(
                                  children: [
                                    const Text('Subtotal: Bs. '),
                                    Text(subTotal!.toStringAsFixed(2))
                                  ],
                                ),
                                Row(
                                  children: [
                                    const Text('Descuento: Bs. '),
                                    LabelBorder(
                                      text: reservation.discount
                                          .toStringAsFixed(2),
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
                                    onPress: () {
                                      if (reservation.status !=
                                          Status.completed) {
                                        setState(() {
                                          isPaymentSectionShown = true;
                                          paymentMethod = 'Efectivo';
                                        });
                                      }
                                    },
                                  ),
                                  const SizedBox(width: 10),
                                  CustomButton(
                                    size: 60,
                                    color: const Color(0xff464C59),
                                    icon: Icons.qr_code,
                                    onPress: () {
                                      if (reservation.status !=
                                          Status.completed) {
                                        setState(() {
                                          isPaymentSectionShown = true;
                                          paymentMethod = 'QR';
                                        });
                                      }
                                    },
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    'Total: ',
                                    style: textTheme.titleMedium,
                                  ),
                                  Text(
                                    'Bs. ${(subTotal - reservation.discount).toStringAsFixed(2)}',
                                    style: textTheme.titleMedium!
                                        .copyWith(fontWeight: FontWeight.bold),
                                  ),
                                ],
                              )
                            ])
                      ],
                    )
                  : Icon(
                      Icons.sticky_note_2_rounded,
                      color: colorScheme.secondary,
                      size: 40,
                    ),
            )
          ],
        ),
        isPaymentSectionShown
            ? Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                top: 0,
                child: Container(
                  color: colorScheme.primary,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    spacing: 20,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Confirmar pago por:',
                            style: textTheme.bodyMedium
                                ?.copyWith(color: Colors.white),
                          ),
                          Text(
                            ' $paymentMethod',
                            style: textTheme.titleSmall
                                ?.copyWith(color: Colors.green),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        spacing: 30,
                        children: [
                          CustomButton(
                            size: 60,
                            color: Colors.green,
                            icon: Icons.check,
                            onPress: () =>
                                managePaymentConfirmation(reservation!),
                          ),
                          CustomButton(
                            size: 60,
                            color: Colors.red,
                            icon: Icons.close,
                            onPress: () =>
                                managePaymentConfirmation(reservation!),
                          ),
                        ],
                      )
                    ],
                  ),
                ))
            : const SizedBox.shrink(),
        isDeletionConfirmationModal
            ? ConfirmationModal(
                leftText: '¿Deseas ',
                highlightedText: 'eliminar ',
                rightText: 'la reserva?',
                onConfirmation: () async {
                  var confirmation = await ref
                      .read(reservationProvider.notifier)
                      .repository
                      .deleteReservation(reservation!.id);
                  if (!confirmation) {
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text(
                              'We are having trouble removing the product')));
                    }
                  } else {
                    ref.read(reservationProvider.notifier).clearReservations();
                    ref.read(reservationProvider.notifier).loadReservations();
                  }
                  setState(() {
                    isDeletionConfirmationModal = false;
                  });
                },
                onCanceled: () {
                  setState(() {
                    isDeletionConfirmationModal = false;
                  });
                },
              )
            : const SizedBox.shrink()
      ]),
    );
  }
}
