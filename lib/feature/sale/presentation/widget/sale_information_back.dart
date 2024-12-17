import 'package:al_pura_frontend/feature/shared/widget/buttons/custom_button.dart';
import 'package:al_pura_frontend/feature/shared/widget/chips/custom_chip.dart';
import 'package:al_pura_frontend/feature/shared/widget/fields/custom_title_field.dart';
import 'package:flutter/material.dart';

class SaleInformationBack extends StatelessWidget {
  const SaleInformationBack({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final primaryColor = Theme.of(context).primaryColor;
    final secondaryColor = Theme.of(context).colorScheme.secondary;


    return Container(
      padding: const EdgeInsets.all(16.0),

      decoration: BoxDecoration(
          color: primaryColor,
          borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(8), bottomRight: Radius.circular(8))),
      child: LayoutBuilder(
        builder: (context, constraints) => Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: FittedBox(
                    fit: BoxFit.cover,
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Información de la venta',
                      style: textTheme.titleMedium
                          ?.copyWith(fontWeight: FontWeight.bold, color: Colors.white),
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

            SizedBox(
              height: constraints.maxHeight * 0.2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                      width: constraints.maxWidth * 0.45,
                      child: const CustomTitleField()),
                  SizedBox(
                      width: constraints.maxWidth * 0.45,
                      child: const CustomTitleField()),
                ],
              ),
            ),

            SizedBox(
              height: constraints.maxHeight * 0.4,
              child: Row(

                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  SizedBox(
                    width: constraints.maxWidth * 0.45,
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      alignment: Alignment.bottomLeft,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomChip(color: secondaryColor, text: Text('Envio por delivery', style: textTheme.bodySmall?.copyWith(color: Colors.white),)),
                          const SizedBox(height: 5,),
                          CustomChip(color: secondaryColor, text: Text('Reserva', style: textTheme.bodySmall?.copyWith(color: Colors.white),))
                        ],
                      ),
                    ),
                  ),

                  SizedBox(
                      height: constraints.maxHeight * 0.2,
                      width: constraints.maxWidth * 0.45,
                      child: const CustomTitleField()),

                ],
              ),
            ),

            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const FittedBox(child: Row(
                    children: [
                      CustomButton(size: 60, filled: false, color: Colors.green, icon: Icons.check, iconColor: Colors.green,),
                      SizedBox(width: 10,),
                      CustomButton(size: 60, filled: false, color: Colors.red, icon: Icons.close, iconColor: Colors.red,),
                    ],
                  )),
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text('PRECIO', style: textTheme.titleMedium
                        ?.copyWith(fontWeight: FontWeight.bold, color: Colors.white),),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
