import 'package:al_pura_frontend/config/router/app_router.dart';
import 'package:al_pura_frontend/config/theme/app_theme.dart';
import 'package:al_pura_frontend/feature/shared/infrastructure/datasource/product_datasource_impl.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  void testFunc() async {
    ProductDatasourceImpl datasourceImpl = ProductDatasourceImpl();
    print(await datasourceImpl.readAllProduct());
  }

  @override
  Widget build(BuildContext context) {
    testFunc();

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: AppTheme().getTheme(),
      title: 'Al Pura Yepes Tienda',
      routerConfig: router,
    );
  }
}
