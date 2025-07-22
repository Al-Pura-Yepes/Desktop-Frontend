import 'package:al_pura_frontend/features/sale/domain/entities/sale.dart';
import 'package:al_pura_frontend/features/sale/presentation/providers/sales_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class SalesDataTable extends ConsumerWidget {
  final void Function(String itemId) selectCallback;

  const SalesDataTable({super.key, required this.selectCallback});

  Color? _getRowColor(Sale sale){
    if (!sale.isAvailable) return Colors.grey.withOpacity(0.5);
    if (sale.paymentMethod.id == '1') return Colors.blue.withOpacity(0.5);
    return null;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;

    final salesState = ref.watch(salesProvider);
    final sales = salesState.sales.values.toList();

    return DataTable(
        dataTextStyle: textTheme.bodySmall,
        headingRowColor: const WidgetStatePropertyAll(
            Colors.black),
        headingTextStyle:
        textTheme.bodySmall?.copyWith(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
        columns: const [
          DataColumn(
              label: Text('N°'),
              numeric: true,
              columnWidth: FlexColumnWidth(1)
          ),
          DataColumn(
              label: Text('Descripcion'),
              columnWidth: FlexColumnWidth(2)
          ),
          DataColumn(
              columnWidth: FlexColumnWidth(1),
              label: Text('Fecha')
          ),
          DataColumn(
              columnWidth: FlexColumnWidth(1),
              label: Text('Tipo de pago')),
          DataColumn(
              columnWidth: FlexColumnWidth(1),
              label: Text('Total')
          ),
        ],
        rows: List<DataRow>.generate(sales.length,
                (int index) {
              var sale = sales[index];
              return DataRow(
                  color: WidgetStatePropertyAll(_getRowColor(sale)),
                  cells: <DataCell>[
                    DataCell(Text(index.toString())),
                    DataCell(Text(sale.products.toString(), overflow: TextOverflow.ellipsis,)),
                    DataCell(Text(DateFormat('dd-MM-yyyy').format(sale.saleDate))),
                    DataCell(Text(sale.paymentMethod.label)),
                    DataCell(Text(sale.totalPrice.toString())),
                  ],
                  onSelectChanged: (bool? value) {
                    selectCallback(sale.id);
                  });
            }));
  }
}