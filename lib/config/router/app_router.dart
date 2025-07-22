import 'package:al_pura_frontend/features/product/data/repository/firebase_product_repository.dart';
import 'package:al_pura_frontend/features/product/data/repository/local_category_repository.dart';
import 'package:al_pura_frontend/features/product/data/repository/local_flavor_repository.dart';
import 'package:al_pura_frontend/features/product/domain/entities/category.dart';
import 'package:al_pura_frontend/features/product/domain/entities/flavor.dart';
import 'package:al_pura_frontend/features/product/domain/entities/product.dart';
import 'package:al_pura_frontend/features/product/domain/usecases/create_product_use_case.dart';
import 'package:al_pura_frontend/features/sale/presentation/screens/history_screen.dart';
import 'package:al_pura_frontend/core/widgets/side_bar/side_bar_menu.dart';
import 'package:al_pura_frontend/features/sale/presentation/screens/sale_screen.dart';
import 'package:al_pura_frontend/features/store/data/repositories/firebase_product_store_repository.dart';
import 'package:al_pura_frontend/features/store/domain/usecases/create_product_store_use_case.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();

final GoRouter router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/',
  routes: [
  ShellRoute(
      builder: (context, state, child) {
        final textTheme = Theme.of(context).textTheme;

        return Scaffold(

          backgroundColor: Colors.white,
          body: Row(
            children: [const SideBarMenu(), Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // APPBAR
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Venta',
                        textAlign: TextAlign.start,
                        style:
                        textTheme.titleLarge!.copyWith(fontWeight: FontWeight.bold)),
                  ),
                  const Divider(
                    color: Colors.black,
                    height: 0.2,
                  ),
                  Expanded(child: child),
                ],
              ),
            )],
          ),
        );
      },
      routes: [
        GoRoute(
            path: '/',
            pageBuilder: (context, state) {
              return MaterialPage(
                key: state.pageKey,
                child: const SaleScreen(),
              );
            }),
        GoRoute(
            path: '/history',
            pageBuilder: (context, state) {
              return MaterialPage(
                key: state.pageKey,
                child: const HistoryScreen(),
              );
            }),
        GoRoute(
            path: '/inventory',
            pageBuilder: (context, state) {
              return MaterialPage(
                key: state.pageKey,
                child: Container(),
              );
            }),
        GoRoute(
            path: '/reservation',
            pageBuilder: (context, state) {
              return MaterialPage(
                key: state.pageKey,
                child: Container(),
              );
            }),

      ])
]);
