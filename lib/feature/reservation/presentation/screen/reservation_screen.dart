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
  Set<String> selectedStatusFilter = {'pendiente', 'preparado'};

  @override
  void initState() {
    super.initState();
    ref.read(reservationProvider.notifier).loadReservations();
  }

  void _showCustomDatePicker(BuildContext context) async {
    DateTime? selectedDate = await showDialog<DateTime>(
      context: context,
      builder: (BuildContext context) {
        return DatePickerDialog(
          initialDate: DateTime.now(),
          firstDate: DateTime(2024),
          lastDate: DateTime(2030),
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

    final filteredReservations = reservations.values.where((reservation) {
      final statusString = statusToString(reservation.status).toLowerCase();
      return selectedStatusFilter.contains(statusString);
    }).toList();

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: Colors.transparent,
        title: const Text('Reservas'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: size.width * 0.6,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 10,
                children: [
                  Container(
                    width: double.maxFinite,
                    height: 50,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    alignment: Alignment.centerRight,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
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
                            await ref
                                .read(reservationProvider.notifier)
                                .loadReservations();
                            setState(() {
                              isLoading = false;
                            });
                          },
                        ),
                        TextButton.icon(
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16.0, vertical: 8.0),
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
                          label: Text(dayFiltered != null
                              ? DateFormat('dd-MM-yyyy').format(dayFiltered)
                              : 'dd-MM-yyyy'),
                          icon: const Icon(Icons.calendar_month_rounded,
                              size: 20),
                          onPressed: () => _showCustomDatePicker(context),
                        ),
                      ],
                    ),
                  ),
                  _SegmentedButton(
                    onSelectionChanged: (selection) {
                      setState(() {
                        selectedStatusFilter = selection;
                      });
                    },
                  ),
                  SingleChildScrollView(
                    child: LayoutBuilder(builder: (context, constraints) {
                      return SizedBox(
                        width: constraints.maxWidth,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: isLoading
                              ? const SizedBox(
                                  height: 150,
                                  child: Center(
                                      child: CircularProgressIndicator()),
                                )
                              : DataTable(
                                  dataTextStyle: textTheme.bodySmall,
                                  dividerThickness: 1,
                                  headingRowColor: WidgetStatePropertyAll(
                                      colorScheme.primary),
                                  headingTextStyle:
                                      textTheme.bodySmall?.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  decoration:
                                      const BoxDecoration(color: Colors.white),
                                  border: TableBorder.all(
                                      color: colorScheme.primary),
                                  columns: [
                                    const DataColumn(
                                      label: Text('N°'),
                                      headingRowAlignment:
                                          MainAxisAlignment.center,
                                      numeric: true,
                                    ),
                                    const DataColumn(
                                      label: Text('Cliente:'),
                                    ),
                                    const DataColumn(
                                      label: Text('Fecha de Entrega:'),
                                      headingRowAlignment:
                                          MainAxisAlignment.center,
                                    ),
                                    const DataColumn(
                                      label: Text('Tipo de Entrega:'),
                                    ),
                                    DataColumn(
                                      label: Row(
                                        spacing: 10,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Icon(
                                            sortStatus == null
                                                ? Icons.compare_arrows
                                                : sortStatus == true
                                                    ? Icons.arrow_upward_rounded
                                                    : Icons
                                                        .arrow_downward_rounded,
                                            color: Colors.white,
                                          ),
                                          const Text('Estado:')
                                        ],
                                      ),
                                      onSort: (columnIndex, ascending) async {
                                        ref
                                            .read(reservationProvider.notifier)
                                            .iterateSortByStatus();
                                        await ref
                                            .read(reservationProvider.notifier)
                                            .loadReservations();
                                      },
                                    )
                                  ],
                                  rows: List<DataRow>.generate(
                                    filteredReservations.length,
                                    (int index) {
                                      var reservation =
                                          filteredReservations[index];
                                      return DataRow(
                                        cells: <DataCell>[
                                          DataCell(Center(
                                              child: Text(index.toString()))),
                                          DataCell(Text(
                                              reservation.client.fullName)),
                                          DataCell(DateVisualizer(
                                            dateTime: reservation.deliveryDate,
                                            status: reservation.status,
                                          )),
                                          DataCell(Text(reservation.isDelivery
                                              ? "Delivery"
                                              : "Entrega")),
                                          DataCell(Text(statusToString(
                                              reservation.status))),
                                        ],
                                        selected: reservation.id ==
                                            ref
                                                .watch(reservationProvider)
                                                .indexSelected,
                                        onSelectChanged: (bool? value) {
                                          ref
                                              .read(
                                                  reservationProvider.notifier)
                                              .changeItemSelected(
                                                  reservation.id);
                                        },
                                      );
                                    },
                                  ),
                                ),
                        ),
                      );
                    }),
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
                      child: NoEditableCart(
                        textTheme: textTheme,
                        onHistoryScreen: false,
                      ),
                    ),
                    const ClientInformationBox(onHistoryScreen: false),
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

class _SegmentedButton extends StatefulWidget {
  final void Function(Set<String> selection)? onSelectionChanged;
  const _SegmentedButton({this.onSelectionChanged});

  @override
  State<_SegmentedButton> createState() => _SegmentedButtonState();
}

class _SegmentedButtonState extends State<_SegmentedButton> {
  Set<String> option = {'pendiente', 'preparado'};

  @override
  Widget build(BuildContext context) {
    return SegmentedButton<String>(
      showSelectedIcon: false,
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.resolveWith<Color>(
          (states) {
            if (states.contains(WidgetState.selected)) {
              return Colors.green;
            }
            return Theme.of(context).primaryColor;
          },
        ),
        textStyle: WidgetStateProperty.all(
          const TextStyle(color: Colors.white),
        ),
        fixedSize: WidgetStateProperty.all(
          const Size(100, 100),
        ),
      ),
      multiSelectionEnabled: true,
      segments: const [
        ButtonSegment<String>(
          value: 'pendiente',
          label: Text('Pendiente', style: TextStyle(color: Colors.white)),
        ),
        ButtonSegment<String>(
          value: 'preparado',
          label: Text('Preparado', style: TextStyle(color: Colors.white)),
        ),
        ButtonSegment<String>(
          value: 'completado',
          label: Text('Completado', style: TextStyle(color: Colors.white)),
        ),
        ButtonSegment<String>(
          value: 'eliminado',
          label: Text('Eliminado', style: TextStyle(color: Colors.white)),
        ),
      ],
      selected: option,
      onSelectionChanged: (newSelection) {
        setState(() {
          option = newSelection;
        });
        if (widget.onSelectionChanged != null) {
          widget.onSelectionChanged!(newSelection);
        }
      },
    );
  }
}
