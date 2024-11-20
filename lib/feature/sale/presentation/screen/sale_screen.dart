import 'package:al_pura_frontend/feature/sale/presentation/widget/product_static_price_sale.dart';
import 'package:al_pura_frontend/feature/sale/presentation/widget/products_board.dart';
import 'package:al_pura_frontend/feature/shared/widget/buttons/custom_button.dart';
import 'package:al_pura_frontend/feature/shared/widget/checkbox/custom_checkbox.dart';
import 'package:al_pura_frontend/feature/shared/widget/fields/custom_title_text_field.dart';
import 'package:al_pura_frontend/feature/shared/widget/options_bar/option_bar.dart';
import 'package:al_pura_frontend/feature/shared/widget/product_card.dart';
import 'package:flutter/material.dart';

class SaleScreen extends StatelessWidget {
  const SaleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;
    final secondaryColor = Theme.of(context).colorScheme.secondary;

    return Scaffold(
      //TODO: CHANGE TO SLIVER APP BAR
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: Colors.transparent,
        title: Text('Venta',
            style: textTheme.titleLarge!.copyWith(fontWeight: FontWeight.bold)),
      ),
      body: Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: Row(
          children: [
            SizedBox(
              width: size.width * 0.6,
              child: const Column(
                children: [
                  OptionBar(),
                  SizedBox(
                    height: 10,
                  ),
                  Expanded(child: ProductsBoard())
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: [
                    Expanded(
                      child: _SaleCart(textTheme: textTheme),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    _SaleInformationFrontCard(textTheme: textTheme, secondaryColor: secondaryColor)
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _SaleInformationBackCard extends StatelessWidget {
  const _SaleInformationBackCard({super.key});

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).colorScheme.primary;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(10),
            bottomRight: Radius.circular(10),
          )),
      child: CustomTitleTextField(),
    );
  }
}


class _SaleCart extends StatelessWidget {
  const _SaleCart({
    super.key,
    required this.textTheme,
  });

  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            )),
        height: const ProductStaticPriceSale().widgetHeight * 7,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                'Carrito',
                textAlign: TextAlign.start,
                style: textTheme.titleSmall,
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 6,
                itemBuilder: (context, index) {
                  return const ProductStaticPriceSale();
                },
              ),
            )
          ],
        ));
  }
}

class _SaleInformationFrontCard extends StatelessWidget {
  const _SaleInformationFrontCard({
    super.key,
    required this.textTheme,
    required this.secondaryColor,
  });

  final TextTheme textTheme;
  final Color secondaryColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10.0),
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(10),
            bottomRight: Radius.circular(10),
          )),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Informacion de la venta',
                textAlign: TextAlign.start,
                style: textTheme.titleSmall,
              ),
              const Row(
                children: [
                  CustomButton(
                    size: 60,
                    filled: false,
                    iconColor: Color(0xff464C59),
                    color: Color(0xff464C59),
                    icon: Icons.add_alert,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  CustomButton(
                    size: 60,
                    filled: false,
                    iconColor: Colors.red,
                    color: Colors.red,
                    icon: Icons.delete,
                  ),
                ],
              )
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const CustomCheckbox(
                title: 'Envio por delivery',
                color: Colors.green,
              ),
              Text(
                'Subtotal: Bs. ${3 + 3}',
                style: textTheme.bodyLarge,
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const CustomCheckbox(title: 'Venta al por mayor'),
              Text(
                'Descuento: Bs. ${3 + 3}',
                style: textTheme.bodyLarge?.copyWith(color: secondaryColor),
              )
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Row(
                children: [
                  CustomButton(
                    size: 70,
                    color: Color(0xff464C59),
                    icon: Icons.qr_code,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  CustomButton(
                    size: 70,
                    color: Color(0xff7AD0AC),
                    icon: Icons.attach_money,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  CustomButton(
                    size: 70,
                    color: Color(0xff1C1897),
                    icon: Icons.bookmark,
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'Total: ',
                    style: textTheme.titleMedium,
                  ),
                  Text(
                    'Bs. ${(4 + 4.00).toStringAsFixed(2)}',
                    style: textTheme.titleLarge,
                  ),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
