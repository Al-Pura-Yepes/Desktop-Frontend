import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

class CustomNavigationItemModel {
  final String title;
  final IconData icon;
  final String goTo;

  const CustomNavigationItemModel(
      {required this.title, required this.icon, this.goTo = ''});
}

class SideBarMenuItem extends StatelessWidget {
  final CustomNavigationItemModel item;
  final bool isSelected;
  final void Function()? onPress;

  const SideBarMenuItem(
      {super.key, required this.item, required this.isSelected, this.onPress});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        decoration: BoxDecoration(
            color: isSelected ? Colors.black : null,
            borderRadius: BorderRadius.circular(10)),
        alignment: Alignment.center,
        child: Icon(item.icon,
            color: isSelected ? Colors.white : const Color(0xff95999C)),
      )
    );
  }
}
