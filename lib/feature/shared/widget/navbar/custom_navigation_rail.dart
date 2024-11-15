import 'package:al_pura_frontend/feature/shared/widget/navbar/custom_navigation_item.dart';
import 'package:al_pura_frontend/feature/shared/widget/navbar/custom_navigation_item_model.dart';
import 'package:flutter/material.dart';

class CustomNavigationRail extends StatefulWidget {


  const CustomNavigationRail({super.key});

  @override
  State<CustomNavigationRail> createState() => _CustomNavigationRailState();
}

class _CustomNavigationRailState extends State<CustomNavigationRail> {
  final List<CustomNavigationItemModel> _options = const [
    CustomNavigationItemModel(title: 'Venta', icon: Icons.shopping_cart),
    CustomNavigationItemModel(title: 'Reserva', icon: Icons.receipt),
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
        final double width = size.width < 1900 ? 80 : 110;

        return Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          width: width,
          color: primaryColor,
          child: Column(
            children: [
              Icon(Icons.business_center_rounded, size: width, color: Colors.white,),

              SizedBox(height: 50,),

              ..._options.map((e) {
                return CustomNavigationItem(
                  item: e,
                  isSelected: optionSelected == e.title,
                  onPress: () => setState(() {
                    optionSelected = e.title;
                  }),
                );
              },).toList(),
            ]
          ),
        );
      },
    );
  }
}
