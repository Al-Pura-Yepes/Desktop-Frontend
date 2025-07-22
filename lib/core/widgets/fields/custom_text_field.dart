import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: const Color(0xffC8C8C8))),
        child: const Row(
          children: [
            Expanded(
                child: TextField(
              decoration: null,
              style: TextStyle(fontSize: 15),
            )),
            Icon(
              Icons.search,
              color: Color(0xffC8C8C8),
            )
          ],
        ));
  }
}
