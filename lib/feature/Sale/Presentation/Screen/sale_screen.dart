import 'package:al_pura_frontend/feature/shared/widget/product_card.dart';
import 'package:flutter/material.dart';

class SaleScreen extends StatelessWidget {
  const SaleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;

    return Scaffold(

      //TODO: CHANGE TO SLIVER APP BAR
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: Colors.transparent,
        title: Text('Venta', style: textTheme.titleLarge!.copyWith(fontWeight: FontWeight.bold)),
      ),
      body: Row(
        children: [
          Container(
            color: Colors.red,
            width: size.width * 0.6,
            
          )
        ],
      ),
    );
  }
}
