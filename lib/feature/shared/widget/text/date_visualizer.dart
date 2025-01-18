import 'package:al_pura_frontend/feature/shared/widget/text/label_border.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateVisualizer extends StatelessWidget {
  final DateTime dateTime;

  const DateVisualizer({
    super.key,
    required this.dateTime
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return LabelBorder(
      text: DateFormat('dd-MM-yyyy').format(dateTime),
      textStyle: textTheme.bodySmall!.copyWith(
          color: determinateColorText(dateTime)),
      color: determinateColor(dateTime),
      filled: true,
    );
  }

  determinateColor(DateTime date) {
    final now = DateTime.now();
    
    if (date.isBefore(now)) {
      bool isSameDay = date.year == now.year &&
          date.month == now.month &&
          date.day == now.day;
      if (isSameDay) {
        return Colors.yellow;
      }
      return Colors.green;
    } else {
      return Colors.red;
    }
  }

  determinateColorText(DateTime date) {
    final now = DateTime.now();

    if (date.isBefore(now)) {
      bool isSameDay = date.year == now.year &&
          date.month == now.month &&
          date.day == now.day;
      if (isSameDay) {
        return Colors.black;
      }
      return Colors.white;
    } else {
      return Colors.white;
    }
  }
}
