import 'package:flutter/material.dart';

class ClientInformationBox extends StatelessWidget {
  const ClientInformationBox({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return SizedBox(
        height: 100,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(10))
          ),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        'Información del Cliente',
                        textAlign: TextAlign.left,
                        style: textTheme.titleSmall,
                      ),
                    ),
                  ],
                ),
                Icon(
                  Icons.person,
                  color: colorScheme.secondary,
                  size: 40,
                ),
              ],
            ),
          ),
        )
    );
  }
}
