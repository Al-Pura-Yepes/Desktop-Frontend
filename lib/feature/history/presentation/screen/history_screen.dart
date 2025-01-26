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

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;
    final indexSelected = ref.watch(salesProvider).indexSelected;
    final sales = ref.watch(salesProvider).sales;
    final sortDate = ref.watch(salesProvider).isDateAscending;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: Colors.transparent,
        title: Row(
          spacing: 20,
            children: [
              const Text('Historial'),
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
                  await ref.read(salesProvider.notifier).loadSales();
                  setState(() {
                    isLoading = false;
                  });
                },
              ),
            ]
        ),
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
                  child: isLoading ? const SizedBox(
                      height: 150,
                      child: Center(child: CircularProgressIndicator()),
                  )
                      : DataTable(
                      dataTextStyle: textTheme.bodySmall,
                      dividerThickness: 1,
                      headingRowColor: WidgetStatePropertyAll(colorScheme.primary),
                      headingTextStyle: textTheme.bodySmall?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                      ),
                      decoration: const BoxDecoration(
                        color: Colors.white
                      ),
                      border: TableBorder.all(color: colorScheme.secondary),
                      columns: [
                        const DataColumn(
                            label: Text('N°'),
                            headingRowAlignment: MainAxisAlignment.center,
                            numeric: true,
                        ),
                        const DataColumn(
                            label: Text('Cliente:'),
                        ),
                        DataColumn(
                            label: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              spacing: 10,
                              children: [
                                Icon(
                                  sortDate == true
                                      ? Icons.arrow_upward_rounded
                                      : Icons.arrow_downward_rounded,
                                  color: Colors.white,
                                ),
                                const Text('Fecha de venta:')
                              ],
                            ),
                            headingRowAlignment: MainAxisAlignment.center
                        ),
                        const DataColumn(
                            label: Text('Tipo de pago:')),
                        const DataColumn(
                            label: Text('Total:')),
                      ],
                      rows: List<DataRow>.generate(
                        sales.length,
                        (int index) {
                          var sale = sales[index];
                          return DataRow(
                              cells: <DataCell>[
                                DataCell(Center(child: Text(index.toString()))),
                                DataCell(Text(sale.clientName ?? 'N/C')),
                                DataCell(
                                    LabelBorder(
                                      text: DateFormat('dd-MM-yyyy').format(sale.dateTime),
                                      textStyle: textTheme.bodySmall!.copyWith(color: Colors.white),
                                      color: Colors.green,
                                      filled: true,
                                    )
                                ),
                                DataCell(Text(sale.isByCash != null
                                    ? (sale.isByCash! ? 'Efectivo' : 'QR')
                                    : 'Efectivo')),
                                DataCell(Text(sale.totalPrice.toString())),
                              ],
                              selected: index == indexSelected,
                              onSelectChanged: (bool? value) {
                                ref.read(salesProvider.notifier).changeItemSelected(index);
                              }
                          );
                        }
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
                          child: NoEditableCart(textTheme: textTheme, onHistoryScreen: true,)
                      ),
                      const ClientInformationBox(onHistoryScreen: true,),
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

