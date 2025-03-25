import 'package:al_pura_frontend/feature/history/presentation/provider/sales_provider.dart';
import 'package:al_pura_frontend/feature/shared/domain/model/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider/reservation_provider.dart';

class ClientInformationBox extends ConsumerWidget {
  final bool onHistoryScreen;

  const ClientInformationBox({super.key, required this.onHistoryScreen});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    late bool isInformationLoaded;
    late User? client;
    if (onHistoryScreen) {
      isInformationLoaded = ref.watch(salesProvider).isSaleSelected;
      client = ref.watch(salesProvider).client;
    } else {
      isInformationLoaded =
          ref.watch(reservationProvider).isReservationSelected;
      client = ref.watch(reservationProvider).reservation?.client;
    }

    return SizedBox(
        height: 100,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(10))),
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
                                  style: textTheme.titleSmall!
                                      .copyWith(fontWeight: FontWeight.w300),
                                ),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  height: 30,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: const Color(0xffC8C8C8)),
                                      borderRadius: BorderRadius.circular(8)),
                                  child: Text(
                                    client?.fullName ?? 'undefined',
                                    style: textTheme.bodySmall,
                                  ),
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
                                  style: textTheme.titleSmall!
                                      .copyWith(fontWeight: FontWeight.w300),
                                ),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  height: 30,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: const Color(0xffC8C8C8)),
                                      borderRadius: BorderRadius.circular(8)),
                                  child: Text(
                                    client?.phoneNumber.toString() ??
                                        'undefined',
                                    style: textTheme.bodySmall,
                                  ),
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
        ));
  }
}
