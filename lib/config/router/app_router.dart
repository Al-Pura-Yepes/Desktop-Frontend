import 'package:al_pura_frontend/feature/history/presentation/screen/history_screen.dart';
import 'package:al_pura_frontend/feature/inventory/presentation/screen/inventory_screen.dart';
import 'package:al_pura_frontend/feature/reservation/presentation/screen/reservation_screen.dart';
import 'package:al_pura_frontend/feature/sale/presentation/screen/sale_screen.dart';
import 'package:al_pura_frontend/feature/shared/widget/navbar/custom_navigation_rail.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();

final GoRouter router =
    GoRouter(navigatorKey: _rootNavigatorKey, initialLocation: '/', routes: [
  ShellRoute(
      builder: (context, state, child) {
        return Scaffold(
          body: Row(
            children: [const CustomNavigationRail(), Expanded(child: child)],
          ),
        );
      },
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => const SaleScreen(),
        ),
        GoRoute(
          path: '/history',
          builder: (context, state) => const HistoryScreen(),
        ),
        GoRoute(
          path: '/inventory',
          builder: (context, state) => const InventoryScreen(),
        ),
        GoRoute(
          path: '/reservation',
          builder: (context, state) => const ReservationScreen(),
        ),
      ])
]);
