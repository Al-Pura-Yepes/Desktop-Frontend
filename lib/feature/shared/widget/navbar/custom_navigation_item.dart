import 'package:al_pura_frontend/feature/shared/widget/navbar/custom_navigation_item_model.dart';
import 'package:flutter/material.dart';

class CustomNavigationItem extends StatelessWidget {
  final CustomNavigationItemModel item;
  final bool isSelected;
  final void Function()? onPress;

  const CustomNavigationItem(
      {super.key, required this.item, required this.isSelected, this.onPress});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final double width = constraints.maxWidth;
          return Container(
            margin: const EdgeInsets.symmetric(vertical: 5),
            width: width - 10,
            height: width - 10,
            decoration: BoxDecoration(
                color: isSelected ? const Color(0xff505764) : null,
                borderRadius: BorderRadius.circular(10)),
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(item.icon,
                    color: isSelected ? Colors.white : const Color(0xff95999C),
                    size: width * 0.5),
                Text(
                  item.title,
                  style: TextStyle(
                      color:
                          isSelected ? Colors.white : const Color(0xff95999C),
                      fontSize: width * 0.15),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
