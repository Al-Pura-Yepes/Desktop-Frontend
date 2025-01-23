import 'package:al_pura_frontend/feature/reservation/domain/model/status.dart';
import 'package:al_pura_frontend/feature/shared/widget/text/label_border.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateVisualizer extends StatelessWidget {
  final DateTime dateTime;
  final Status status;

  const DateVisualizer({
    super.key,
    required this.dateTime,
    required this.status
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return LabelBorder(
      text: DateFormat('dd-MM-yyyy').format(dateTime),
      textStyle: textTheme.bodySmall!.copyWith(
          color: status == Status.completed ? Colors.white : determinateColorText(dateTime)),
      color: status == Status.completed ? Colors.green : determinateColor(dateTime),
      filled: true,
    );
  }

  determinateColor(DateTime date) {
    final now = DateTime.now();
    
    if (date.isAfter(now)) {
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

    if (date.isAfter(now)) {
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
