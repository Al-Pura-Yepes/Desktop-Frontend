import 'package:al_pura_frontend/config/router/app_router.dart';
import 'package:al_pura_frontend/feature/shared/widget/navbar/custom_navigation_item.dart';
import 'package:al_pura_frontend/feature/shared/widget/navbar/custom_navigation_item_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomNavigationRail extends StatefulWidget {
  const CustomNavigationRail({super.key});

  @override
  State<CustomNavigationRail> createState() => _CustomNavigationRailState();
}

class _CustomNavigationRailState extends State<CustomNavigationRail> {
  final List<CustomNavigationItemModel> _options = const [
    CustomNavigationItemModel(
        title: 'Venta', icon: Icons.shopping_cart, goTo: '/'),
    CustomNavigationItemModel(
        title: 'Reserva', icon: Icons.receipt, goTo: '/history'),
    CustomNavigationItemModel(title: 'Historial', icon: Icons.book)
  ];
  String optionSelected = 'Venta';

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final primaryColor = Theme.of(context).primaryColor;
    final size = MediaQuery.of(context).size;

    return LayoutBuilder(
      builder: (context, constraints) {
        final size = MediaQuery.of(context).size;
        final double width = size.width < 1900 ? 90 : 120;

        return Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          width: width,
          color: primaryColor,
          child: Column(children: [
            Image.asset('assets/logo_white.png'),
            const SizedBox(
              height: 50,
            ),
            ..._options.map(
              (e) {
                return CustomNavigationItem(
                    item: e,
                    isSelected: optionSelected == e.title,
                    onPress: () {
                      setState(() {
                        optionSelected = e.title;
                      });
                      context.go(e.goTo);
                    });
              },
            ).toList(),
          ]),
        );
      },
    );
  }
}
