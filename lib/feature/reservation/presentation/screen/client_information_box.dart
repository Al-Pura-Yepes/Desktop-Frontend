import 'package:al_pura_frontend/feature/shared/widget/text/label_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider/reservation_provider.dart';

class ClientInformationBox extends ConsumerWidget {
  const ClientInformationBox({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final isInformationLoaded = ref.watch(reservationProvider).isReservationSelected;

    return SizedBox(
        height: 100,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(10))
          ),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        'Información del Cliente',
                        textAlign: TextAlign.left,
                        style: textTheme.titleSmall,
                      ),
                    ),
                  ],
                ),
                isInformationLoaded
                    ? Row(
                      spacing: 10,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Nombre del cliente:',
                                style: textTheme.titleSmall!.copyWith(fontWeight: FontWeight.w300),),
                              Container(
                                alignment: Alignment.centerLeft,
                                height: 30,
                                padding: const EdgeInsets.symmetric(horizontal: 10),
                                decoration: BoxDecoration(
                                    border: Border.all(color: const Color(0xffC8C8C8)),
                                    borderRadius: BorderRadius.circular(8)),
                                child: Text('Diego Figueroa', style: textTheme.bodySmall,),
                              )
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Celular del cliente:',
                                style: textTheme.titleSmall!.copyWith(fontWeight: FontWeight.w300),),
                              Container(
                                alignment: Alignment.centerLeft,
                                height: 30,
                                padding: const EdgeInsets.symmetric(horizontal: 10),
                                decoration: BoxDecoration(
                                    border: Border.all(color: const Color(0xffC8C8C8)),
                                    borderRadius: BorderRadius.circular(8)),
                                child: Text('69459340', style: textTheme.bodySmall,),
                              )
                            ],
                          ),
                        )
                      ],
                    )
                    : Icon(
                      Icons.person,
                      color: colorScheme.secondary,
                      size: 40,
                    ),
              ],
            ),
          ),
        )
    );
  }
}
