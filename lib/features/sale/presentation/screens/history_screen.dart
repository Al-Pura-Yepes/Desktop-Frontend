
import 'package:al_pura_frontend/features/sale/presentation/providers/sales_provider.dart';
import 'package:al_pura_frontend/features/sale/presentation/widgets/products_cart.dart';
import 'package:al_pura_frontend/features/sale/presentation/widgets/sale_information.dart';
import 'package:al_pura_frontend/features/sale/presentation/widgets/sales_data_table.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class HistoryScreen extends ConsumerStatefulWidget {
  const HistoryScreen({super.key});

  @override
  ConsumerState<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends ConsumerState<HistoryScreen> {
  var saleId = '';

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    // TODO: MANDAR A TODOS LOS COMPONENTES HIJOS ESTE STATE
    final saleState = ref.watch(salesProvider);

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: Column(
            children: [
              Expanded(
                flex: 3,
                child: SingleChildScrollView(
                  child: LayoutBuilder(
                    builder: (context, constrains) => SizedBox(
                      width: constrains.maxWidth,
                      child: SalesDataTable(
                        selectCallback: (itemId) {
                          setState(() {
                            saleId = itemId;
                          });
                        },
                      ),
                    ),
                  ),
                ),
              ),
              const Divider(
                color: Colors.black,
                height: 0.2,
              ),
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: _HistoryInformation(
                    total: saleState.totalSales,
                    cashTotal: saleState.subtotalCashSales,
                    qrTotal: saleState.subtotalQRSales,
                  ),
                ),
              )
            ],
          ),
        ),
        Expanded(
          flex: 1,
          child: Column(
            children: [
              Expanded(
                  child: ProductsCart(
                    saleId: saleId,
                    isEditable: true,
              ),
                flex: 3,
              ),
              Expanded(flex:2, child: SaleInformation(saleId: saleId, isNew: false,))
            ],
          ),
        )
      ],
    );
  }
}

class _HistoryInformation extends StatelessWidget {

  final double total;
  final double cashTotal;
  final double qrTotal;

  const _HistoryInformation({super.key, required this.total, required this.cashTotal, required this.qrTotal});

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 8,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          spacing: 5,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(text: TextSpan(
                text: 'Subtotal efectivo: ',
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
                children: [
                  TextSpan(text: "Bs.  $cashTotal", style: const TextStyle(fontSize: 25, fontWeight: FontWeight.normal)),
                ]
            ),
            ),
            RichText(text: TextSpan(
                text: 'Subtotal en QR: ',
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
                children: [
                  TextSpan(text: "Bs. $qrTotal", style: const TextStyle(fontSize: 25, fontWeight: FontWeight.normal)),
                ]
            ),
            ),
            RichText(text: TextSpan(
                text: 'Total: ',
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
                children: [
                  TextSpan(text: "Bs. $total", style: const TextStyle(fontSize: 40, fontWeight: FontWeight.normal))
                ]
            ),
            ),
          ],
        ),
      ],
    );
  }
}
