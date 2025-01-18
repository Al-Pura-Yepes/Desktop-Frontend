import 'package:al_pura_frontend/feature/reservation/presentation/provider/reservation_provider.dart';
import 'package:al_pura_frontend/feature/reservation/presentation/screen/reservation_information_box.dart';
import 'package:al_pura_frontend/feature/sale/presentation/widget/sale_cart.dart';
import 'package:al_pura_frontend/feature/shared/widget/text/date_visualizer.dart';
import 'package:al_pura_frontend/feature/shared/widget/text/label_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'client_information_box.dart';

class ReservationScreen extends ConsumerWidget {
  const ReservationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;
    final indexSelected = ref.watch(reservationProvider).indexSelected;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: Colors.transparent,
        title: const Text('Reservas'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: size.width * 0.6,
              child: SingleChildScrollView(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: DataTable(
                      dataTextStyle: textTheme.bodySmall,
                      dividerThickness: 2,
                      headingRowColor: WidgetStatePropertyAll(colorScheme.primary),
                      headingTextStyle: textTheme.bodySmall?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                      ),
                      decoration: const BoxDecoration(
                        color: Colors.white
                      ),
                      border: TableBorder.all(color: colorScheme.secondary),
                      columns: const [
                        DataColumn(
                            label: Text('Cliente:')),
                        DataColumn(
                            label: Text('Fecha de Entrega:')),
                        DataColumn(
                            label: Text('Tipo de Entrega:')),
                        DataColumn(
                            label: Text('Estado:'))
                      ],
                      rows: List<DataRow>.generate(
                        10,
                        (int index) => DataRow(
                          cells: <DataCell>[
                            const DataCell(Text("Lorem ipsum")),
                            DataCell(
                                DateVisualizer(
                                  dateTime: DateTime(2025, 1, 10)
                                )
                            ),
                            const DataCell(Text("Lorem ipsum")),
                            const DataCell(Text("Lorem ipsum")),
                          ],
                          selected: index == indexSelected,
                          onSelectChanged: (bool? value) {
                            ref.read(reservationProvider.notifier).changeItemSelected(index);
                            print(ref.read(reservationProvider).indexSelected);
                          }
                        ),
                      )
                  ),
                ),
              ),
            ),
            Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    spacing: 10,
                    children: [
                      Expanded(
                          child: SaleCart(textTheme: textTheme, isOnReservationMode: true,)
                      ),
                      const ClientInformationBox(),
                      const ReservationInformationBox()
                    ],
                  ),
                ),
            )
          ],
        ),
      ),
    );
  }
}

