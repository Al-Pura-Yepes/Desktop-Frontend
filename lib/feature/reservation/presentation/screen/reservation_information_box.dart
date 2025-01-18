import 'package:al_pura_frontend/feature/reservation/presentation/provider/reservation_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ReservationInformationBox extends ConsumerWidget {
  const ReservationInformationBox({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final isInformationLoaded = ref.watch(reservationProvider).isReservationSelected;

    return Container(
      height: 300,
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
              )
            ],
          ),
          Expanded(
                child: Icon(
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
