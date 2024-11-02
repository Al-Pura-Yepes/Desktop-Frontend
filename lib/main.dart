import 'package:al_pura_frontend/config/theme/app_theme.dart';
import 'package:al_pura_frontend/feature/shared/widget/product_card.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme().getTheme(),
      title: 'Al Pura Yepes Tienda',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Test'),
        ),
        body: const Center(
          child: ProductCard(),
        ),
      ),
    );
  }
}
