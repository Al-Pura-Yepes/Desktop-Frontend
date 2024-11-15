import 'package:flutter/material.dart';

class CustomNavigationItemModel {
  final String title;
  final IconData icon;
  final String goTo;

  const CustomNavigationItemModel(
      {required this.title, required this.icon, this.goTo = ''});
}
