import 'package:al_pura_frontend/feature/shared/widget/buttons/custom_button.dart';
import 'package:al_pura_frontend/feature/shared/widget/checkbox/custom_checkbox.dart';
import 'package:flutter/material.dart';

class SaleInformationFront extends StatelessWidget {
  const SaleInformationFront({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(8),
          bottomRight: Radius.circular(8)
        )
      ),
      padding: const EdgeInsets.all(16.0),
      child: Column(
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
                    style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
              ),

              SizedBox(width: 30,),

              Flexible(
                child: FittedBox(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CustomButton(
                        size: 35,
                        color: Colors.yellow,
                      ),
                      SizedBox(width: 10),
                      CustomButton(
                        size: 35,
                        color: Colors.green,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 20,),

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
                        size: 15,
                      ))),

              SizedBox(width: 30,),

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
              const Expanded(
                  child: FittedBox(
                      fit: BoxFit.scaleDown,
                      alignment: Alignment.centerLeft,
                      child: CustomCheckbox(
                        title: 'Venta al por mayor',
                        size: 15,
                      ))),

              SizedBox(width: 30,),

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

          SizedBox(height: 20,),

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
                        size: 45,
                        color: Colors.yellow,
                      ),
                      SizedBox(width: 10),
                      CustomButton(
                        size: 45,
                        color: Colors.green,
                      ),
                      SizedBox(width: 10),
                      CustomButton(
                        size: 45,
                        color: Colors.green,
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(width: 30,),


              Flexible(
                  child: FittedBox(child: Text('Total: Bs 45', style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),))
              )
            ],
          )
        ],
      ),
    );
  }
}
