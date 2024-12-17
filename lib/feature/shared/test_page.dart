import 'package:al_pura_frontend/feature/sale/presentation/widget/sale_information_back.dart';
import 'package:flutter/material.dart';

class TestPage extends StatelessWidget {
  const TestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: SizedBox(
          width: 400,
          height: 300,
          child: SaleInformationBack(),
        ),
      ),
    );
  }
}
