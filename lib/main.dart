import 'package:al_pura_frontend/config/router/app_router.dart';
import 'package:al_pura_frontend/config/theme/app_theme.dart';
import 'package:al_pura_frontend/feature/shared/widget/navbar/custom_navigation_rail.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: AppTheme().getTheme(),
      title: 'Al Pura Yepes Tienda',
      routerConfig: router,
    );
  }
}
