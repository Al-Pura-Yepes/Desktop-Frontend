import 'package:al_pura_frontend/feature/history/presentation/provider/sales_provider.dart';
import 'package:al_pura_frontend/feature/history/presentation/widget/sales_information_box.dart';
import 'package:al_pura_frontend/feature/reservation/presentation/screen/client_information_box.dart';
import 'package:al_pura_frontend/feature/reservation/presentation/widget/no_editable_cart.dart';
import 'package:al_pura_frontend/feature/shared/widget/buttons/custom_button.dart';
import 'package:al_pura_frontend/feature/shared/widget/text/label_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class HistoryScreen extends ConsumerStatefulWidget {
  const HistoryScreen({super.key});

  @override
  ConsumerState<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends ConsumerState<HistoryScreen> {
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    ref.read(salesProvider.notifier).loadSales();
  }

  void _showCustomDatePicker(BuildContext context) async {
    final currentDay = ref.read(salesProvider).dayFiltered ?? DateTime.now();

    DateTime? selectedDate = await showDialog<DateTime>(
      context: context,
      builder: (BuildContext context) {
        return DatePickerDialog(
          initialDate: currentDay,
          firstDate: DateTime(2020),
          lastDate: DateTime(2030),
          confirmText: 'Confirmar',
          cancelText: 'Limpiar',
        );
      },
    );

    if (selectedDate != null) {
      ref.read(salesProvider.notifier).selectDay(selectedDate);
    } else {
      ref.read(salesProvider.notifier).selectDay(DateTime.now());
    }

    await ref.read(salesProvider.notifier).loadSales();
  }


  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;
    final indexSelected = ref.watch(salesProvider).indexSelected;
    final sales = ref.watch(salesProvider).sales;
    final sortDate = ref.watch(salesProvider).isDateAscending;
    final dayFiltered = ref.watch(salesProvider).dayFiltered;
    final salesProviderState = ref.watch(salesProvider);

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: Colors.transparent,
        title: const Text('Historial'),
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
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      alignment: Alignment.centerRight,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white),
                      child: Row(
                        spacing: 8,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          
                          Column(
                            spacing: 3,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              RichText(text: TextSpan(
                                text: 'Subtotal efectivo: ',
                                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
                                children: [
                                  TextSpan(text: "Bs. ${salesProviderState.subtotalMoney ?? 0 - (salesProviderState.subtotalMoneyExpenses ?? 0)} ", style: const TextStyle(fontSize: 25, fontWeight: FontWeight.normal)),
                                  TextSpan(text: "(${salesProviderState.subtotalMoney ?? 0} - ${(salesProviderState.subtotalMoneyExpenses ?? 0)})", style: const TextStyle(fontSize: 20, fontWeight: FontWeight.normal, color: Colors.red))

                                ]
                              ),
                              ),
                              RichText(text: TextSpan(
                                  text: 'Subtotal en QR: ',
                                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
                                  children: [
                                    TextSpan(text: "Bs. ${salesProviderState.subtotalQR ?? 0 - (salesProviderState.subtotalQRExpenses ?? 0)} ", style: const TextStyle(fontSize: 25, fontWeight: FontWeight.normal)),
                                    TextSpan(text: "(${salesProviderState.subtotalQR ?? 0} - ${(salesProviderState.subtotalQRExpenses ?? 0)})", style: const TextStyle(fontSize: 20, fontWeight: FontWeight.normal, color: Colors.red))


                                  ]
                              ),
                              ),
                              const SizedBox(height: 5,),
                              RichText(text: TextSpan(
                                  text: 'Total: ',
                                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
                                  children: [
                                    TextSpan(text: "Bs. ${salesProviderState.total}", style: const TextStyle(fontSize: 40, fontWeight: FontWeight.normal))
                                  ]
                              ),
                              ),
                            ],
                          ),
                          
                          const Spacer(),
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
                                  .read(salesProvider.notifier)
                                  .loadSales();
                              setState(() {
                                isLoading = false;
                              });
                            },
                          ),
                        ],
                      )
                      //DatePickerDialog(firstDate: DateTime.now(), lastDate: dayFiltered ?? DateTime.now().add(const Duration(days: 1))),
                      ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: LayoutBuilder(
                        builder: (context, constrains) => SizedBox(
                          width: constrains.maxWidth,
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
                                        color: colorScheme.secondary),
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
                                      DataColumn(
                                          label: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            spacing: 10,
                                            children: [
                                              Icon(
                                                sortDate == true
                                                    ? Icons.arrow_upward_rounded
                                                    : Icons
                                                        .arrow_downward_rounded,
                                                color: Colors.white,
                                              ),
                                              const Text('Fecha de venta:')
                                            ],
                                          ),
                                          headingRowAlignment:
                                              MainAxisAlignment.center),
                                      const DataColumn(
                                          label: Text('Tipo de pago:')),
                                      const DataColumn(label: Text('Total:')),
                                    ],
                                    rows: List<DataRow>.generate(sales.length,
                                        (int index) {
                                      var sale = sales[index];
                                      return DataRow(
                                          cells: <DataCell>[
                                            DataCell(Center(
                                                child: Text(index.toString()))),
                                            DataCell(
                                                Text(sale.clientName ?? 'N/C')),
                                            DataCell(Center(
                                              child: LabelBorder(
                                                text: DateFormat('dd-MM-yyyy')
                                                    .format(sale.saleDate),
                                                textStyle: textTheme.bodySmall!
                                                    .copyWith(
                                                        color: Colors.black),
                                              ),
                                            )),
                                            DataCell(Text(sale.isByCash != null
                                                ? (sale.isByCash
                                                    ? 'Efectivo'
                                                    : 'QR')
                                                : 'Efectivo')),
                                            DataCell(
                                                Text(sale.totalPrice.toString())),
                                          ],
                                          selected: index == indexSelected,
                                          onSelectChanged: (bool? value) {
                                            ref
                                                .read(salesProvider.notifier)
                                                .changeItemSelected(index);
                                          });
                                    })),
                          ),
                        ),
                      ),
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
                        child: NoEditableCart(
                      textTheme: textTheme,
                      onHistoryScreen: true,
                    )),
                    const ClientInformationBox(
                      onHistoryScreen: true,
                    ),
                    const SalesInformationBox()
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
