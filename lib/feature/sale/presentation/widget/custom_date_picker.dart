import 'package:al_pura_frontend/feature/sale/presentation/providers/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class CustomDatePickerField extends ConsumerStatefulWidget {
  final Color color;
  final String title;
  final DateTime? initialDate;
  final void Function(DateTime date) onDateSelected;

  const CustomDatePickerField(
      {super.key,
      this.color = Colors.white,
      required this.title,
      required this.onDateSelected,
      this.initialDate});

  @override
  _CustomDatePickerFieldState createState() => _CustomDatePickerFieldState();
}

class _CustomDatePickerFieldState extends ConsumerState<CustomDatePickerField> {
  DateTime? date;

  @override
  void initState() {
    super.initState();
    date = widget.initialDate;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double fontSize = constraints.maxHeight * 0.25;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                widget.title,
                style: TextStyle(fontSize: fontSize + 3, color: Colors.white),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2100),
                    builder: (context, child) {
                      return Theme(
                        data: ThemeData.light().copyWith(
                          primaryColor: widget.color,
                          colorScheme: ColorScheme.light(primary: widget.color),
                          buttonTheme: const ButtonThemeData(
                              textTheme: ButtonTextTheme.primary),
                        ),
                        child: child!,
                      );
                    },
                  );
                  if (pickedDate != null) {
                    widget.onDateSelected(pickedDate);
                    setState(() {
                      ref
                          .read(cartProvider.notifier)
                          .setReservationDate(pickedDate);
                      date = pickedDate;
                    });
                  }
                },
                child: Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.symmetric(
                    vertical: constraints.maxHeight * 0.1,
                    horizontal: constraints.maxWidth * 0.05,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    date == null
                        ? 'Seleccionar fecha'
                        : DateFormat('dd/MM/yyyy').format(date!),
                    style: TextStyle(
                      fontSize: fontSize,
                      color: Colors.white,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
