import 'package:al_pura_frontend/feature/reservation/domain/model/status.dart';
import 'package:al_pura_frontend/feature/reservation/presentation/provider/reservation_provider.dart';
import 'package:al_pura_frontend/feature/reservation/presentation/screen/reservation_information_box.dart';
import 'package:al_pura_frontend/feature/reservation/presentation/widget/no_editable_cart.dart';
import 'package:al_pura_frontend/feature/shared/widget/buttons/custom_button.dart';
import 'package:al_pura_frontend/feature/shared/widget/text/date_visualizer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import 'client_information_box.dart';

class ReservationScreen extends ConsumerStatefulWidget {
  const ReservationScreen({super.key});

  @override
  ConsumerState<ReservationScreen> createState() => _ReservationScreenState();
}

class _ReservationScreenState extends ConsumerState<ReservationScreen> {
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    ref.read(reservationProvider.notifier).loadReservations();
  }

  void _showCustomDatePicker(BuildContext context) async {
    DateTime firstDate = DateTime(2024);
    DateTime lastDate = DateTime.now();

    DateTime? selectedDate = await showDialog<DateTime>(
      context: context,
      builder: (BuildContext context) {
        return DatePickerDialog(
          firstDate: firstDate,
          lastDate: lastDate,
          confirmText: 'Confirmar',
          cancelText: 'Limpiar',
        );
      },
    );

    if (selectedDate != null) {
      ref.read(reservationProvider.notifier).selectDay(selectedDate);
    } else {
      ref.read(reservationProvider.notifier).selectDay(null);
    }
    ref.read(reservationProvider.notifier).loadReservations();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;
    final indexSelected = ref.watch(reservationProvider).indexSelected;
    final reservations = ref.watch(reservationProvider).reservations;
    final sortStatus = ref.watch(reservationProvider).isStatusAscending;
    final dayFiltered = ref.watch(reservationProvider).dayFiltered;

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
              child: Column(
                spacing: 10,
                children: [
                  Container(
                    width: double.maxFinite,
                    height: 50,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    alignment: Alignment.centerRight,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomButton(
                          size: 40,
                          filled: true,
                          color: Colors.green,
                          iconColor: Colors.white,
                          icon: Icons.refresh_rounded,
                          onPress: () async {
                            setState(() {
                              isLoading = true;
                            });
                            await ref.read(reservationProvider.notifier).loadReservations();
                            setState(() {
                              isLoading = false;
                            });
                          },
                        ),
                        TextButton.icon(
                            style: TextButton.styleFrom(
                              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                              backgroundColor: Colors.blueGrey.shade50,
                              foregroundColor: Colors.blueGrey,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                                side: BorderSide(
                                  color: Colors.blueGrey.shade300,
                                  width: 1.5,
                                ),
                              ),
                            ),
                            label: Text(
                                dayFiltered != null
                                    ? DateFormat('dd-MM-yyyy').format(dayFiltered)
                                    : 'dd-MM-yyyy'
                            ),
                            icon: const Icon(Icons.calendar_month_rounded, size: 20),
                            onPressed: () => _showCustomDatePicker(context),
                        ),
                      ],
                    )
                    //DatePickerDialog(firstDate: DateTime.now(), lastDate: dayFiltered ?? DateTime.now().add(const Duration(days: 1))),
                  ),
                  SingleChildScrollView(
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        return SizedBox(
                          width: constraints.maxWidth,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: isLoading ? const SizedBox(
                              height: 150,
                              child: Center(child: CircularProgressIndicator()),
                            )
                                : DataTable(
                                dataTextStyle: textTheme.bodySmall,
                                dividerThickness: 1,
                                headingRowColor: WidgetStatePropertyAll(
                                    colorScheme.primary),
                                headingTextStyle: textTheme.bodySmall?.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                                decoration: const BoxDecoration(
                                    color: Colors.white
                                ),
                                border: TableBorder.all(
                                    color: colorScheme.secondary),
                                columns: [
                                  const DataColumn(
                                    label: Text('N°'),
                                    headingRowAlignment: MainAxisAlignment.center,
                                    numeric: true,
                                  ),
                                  const DataColumn(
                                    label: Text('Cliente:'),
                                  ),
                                  const DataColumn(
                                      label: Text('Fecha de Entrega:'),
                                      headingRowAlignment: MainAxisAlignment
                                          .center
                                  ),
                                  const DataColumn(
                                      label: Text('Tipo de Entrega:')),
                                  DataColumn(
                                    label: Row(
                                      mainAxisAlignment: MainAxisAlignment
                                          .spaceBetween,
                                      spacing: 10,
                                      children: [
                                        Icon(
                                          sortStatus == null
                                              ? Icons.compare_arrows
                                              : sortStatus == true
                                              ? Icons.arrow_upward_rounded
                                              : Icons.arrow_downward_rounded,
                                          color: Colors.white,
                                        ),
                                        const Text('Estado:')
                                      ],
                                    ),
                                    onSort: (columnIndex, ascending) async {
                                      ref.read(reservationProvider.notifier)
                                          .iterateSortByStatus();
                                      await ref.read(reservationProvider.notifier)
                                          .loadReservations();
                                    },
                                  )
                                ],
                                rows: List<DataRow>.generate(
                                    reservations.length,
                                        (int index) {
                                      var reservation = reservations[index];
                                      return DataRow(
                                          cells: <DataCell>[
                                            DataCell(Center(
                                                child: Text(index.toString()))),
                                            DataCell(Text(
                                                reservation.client.fullName)),
                                            DataCell(
                                                DateVisualizer(
                                                  dateTime: reservation
                                                      .deliveryDate,
                                                  status: reservation.status,
                                                )
                                            ),
                                            DataCell(Text(
                                                reservation.isDelivery
                                                    ? "Entrega"
                                                    : "Delivery"
                                            )),
                                            DataCell(Text(statusToString(
                                                reservation.status))),
                                          ],
                                          selected: index == indexSelected,
                                          onSelectChanged: (bool? value) {
                                            ref.read(reservationProvider.notifier)
                                                .changeItemSelected(index);
                                          }
                                      );
                                    }
                                )
                            ),
                          ),
                        );
                      }
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    spacing: 10,
                    children: [
                      Expanded(
                          child: NoEditableCart(textTheme: textTheme, onHistoryScreen: false,)
                      ),
                      const ClientInformationBox(onHistoryScreen: false,),
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

