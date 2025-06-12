import 'package:al_pura_frontend/config/router/app_router.dart';
import 'package:al_pura_frontend/config/theme/app_theme.dart';
import 'package:al_pura_frontend/domain/repositories/filters/product/firebase_product_filter.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'features/product/domain/entities/category.dart';
import 'features/product/domain/entities/flavor.dart';
import 'domain/entities/product.dart';
import 'firebase_options.dart';
import 'features/product/data/data_sources/firebase_store_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  var repo = FirebaseStoreRepository();
  var product = await repo.getAll(FirebaseProductFilter(flavor: Flavor(flavorLabel: 'maracuya')));
  print(product);

  runApp(const ProviderScope(child: MyApp()));
}

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
