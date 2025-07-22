import 'package:al_pura_frontend/core/widgets/side_bar/side_bar_menu_item.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SideBarMenu extends StatefulWidget {
  const SideBarMenu({super.key});

  static const List<CustomNavigationItemModel> _options = [
    CustomNavigationItemModel(
        title: 'Venta', icon: Icons.shopping_cart, goTo: '/'),
    CustomNavigationItemModel(
        title: 'Reserva', icon: Icons.receipt, goTo: '/reservation'),
    CustomNavigationItemModel(
        title: 'Historial', icon: Icons.book, goTo: '/history'),
    CustomNavigationItemModel(
        title: 'Inventario', icon: Icons.inventory, goTo: '/inventory')
  ];

  @override
  State<SideBarMenu> createState() => _SideBarMenuState();
}

class _SideBarMenuState extends State<SideBarMenu> {
  late String actualRoute;

  String _getSelectedOption(String route) {
    switch (route) {
      case '/':
        return 'Venta';
      case '/reservation':
        return 'Reserva';
      case '/history':
        return 'Historial';
      case '/inventory':
        return 'Inventario';
      default:
        return 'Venta';
    }
  }

  @override
  void initState() {
    this.actualRoute = GoRouter.of(context).routerDelegate.currentConfiguration.uri.path;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final optionSelected = _getSelectedOption(actualRoute);

    return Row(
      children: [
        Container(
          alignment: Alignment.center,
          child: Column(
            children: [
              Image.asset('assets/logo_dark.png', height: 70, width: 70,),

              Flexible(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                  ...SideBarMenu._options.map(
                        (e) {
                      return SizedBox(
                        width: 70,
                        height: 70,
                        child: Padding(
                          padding: const EdgeInsetsGeometry.symmetric(horizontal: 5, vertical: 5),
                          child: SideBarMenuItem(
                              item: e,
                              isSelected: optionSelected == e.title,
                              onPress: () {
                                setState(() {
                                  context.go(e.goTo);
                                  actualRoute = GoRouter.of(context).routerDelegate.currentConfiguration.uri.path;
                                });
                              }),
                        ),
                      );
                    },
                  ),
                ]),
              ),
            ],
          ),
        ),
        VerticalDivider(color: Colors.black, width: 0.2,)
      ],
    );
  }
}
