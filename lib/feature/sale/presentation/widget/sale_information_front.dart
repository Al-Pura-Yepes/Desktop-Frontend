import 'package:al_pura_frontend/feature/shared/widget/buttons/custom_button.dart';
import 'package:al_pura_frontend/feature/shared/widget/checkbox/custom_checkbox.dart';
import 'package:flutter/material.dart';

class SaleInformationFront extends StatelessWidget {
  const SaleInformationFront({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final secondaryColor = Theme.of(context).colorScheme.secondary;


    return Container(
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(8), bottomRight: Radius.circular(8))),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: FittedBox(
                  fit: BoxFit.cover,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Información de la venta',
                    style: textTheme.titleMedium
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(
                width: 30,
              ),
              const Flexible(
                child: FittedBox(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CustomButton(
                        size: 40,
                        color: Color(0xff464C59),
                        filled: false,
                        icon: Icons.notification_add,
                        iconColor: Color(0xff464C59),
                      ),
                      SizedBox(width: 10),
                      CustomButton(
                        size: 40,
                        color: Colors.red,
                        filled: false,
                        icon: Icons.delete,
                        iconColor: Colors.red,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Expanded(
                  child: FittedBox(
                      fit: BoxFit.scaleDown,
                      alignment: Alignment.centerLeft,
                      child: CustomCheckbox(
                        title: 'Envio por delivery',
                        size: 20,
                      ))),
              const SizedBox(
                width: 30,
              ),
              Flexible(
                child: FittedBox(
                  alignment: Alignment.centerRight,
                  fit: BoxFit.scaleDown,
                  child: Row(
                    children: [
                      Text(
                        'Subtotal: ',
                        style: textTheme.bodyMedium,
                      ),
                      Text(
                        'Bs. 35.00',
                        style: textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                  child: FittedBox(
                      fit: BoxFit.scaleDown,
                      alignment: Alignment.centerLeft,
                      child: CustomCheckbox(
                        color: secondaryColor,
                        title: 'Venta al por mayor',
                        size: 20,
                      ))),
              const SizedBox(
                width: 30,
              ),
              Flexible(
                child: FittedBox(
                  alignment: Alignment.centerRight,
                  fit: BoxFit.scaleDown,
                  child: Row(
                    children: [
                      Text(
                        'Descuento: ',
                        style: textTheme.bodyMedium,
                      ),
                      Text(
                        'Bs. 35.00',
                        style: textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: FittedBox(
                  alignment: Alignment.centerLeft,
                  fit: BoxFit.scaleDown,
                  child: Row(
                    children: [
                      CustomButton(
                        size: 60,
                        color: secondaryColor,
                        icon: Icons.attach_money,
                      ),
                      SizedBox(width: 10),
                      CustomButton(
                        size: 60,
                        color: Color(0xff464C59),
                        icon: Icons.qr_code,
                      ),
                      SizedBox(width: 10),
                      CustomButton(
                        size: 60,
                        color: Color(0xff1C1897),
                        icon: Icons.bookmark
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                width: 30,
              ),
              Flexible(
                  child: FittedBox(
                      child: Text(
                'Total: Bs 45',
                style: textTheme.titleMedium
                    ?.copyWith(fontWeight: FontWeight.bold),
              )))
            ],
          )
        ],
      ),
    );
  }
}
