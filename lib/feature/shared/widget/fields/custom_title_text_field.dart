import 'package:flutter/material.dart';

class CustomTitleTextField extends StatelessWidget {
  const CustomTitleTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Nombre del cliente:',
            style: TextStyle(color: Colors.white),
          ),
          TextField(
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                border: InputBorder.none,
              )),
        ],
      ),
    );
  }
}
