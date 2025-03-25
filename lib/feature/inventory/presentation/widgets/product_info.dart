import 'package:al_pura_frontend/feature/shared/domain/model/product.dart';
import 'package:al_pura_frontend/feature/shared/widget/checkbox/custom_checkbox.dart';
import 'package:flutter/material.dart';

class ProductInfo extends StatelessWidget {
  final Product product;

  const ProductInfo({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            )),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Informacion',
                textAlign: TextAlign.start,
                style: textTheme.titleSmall,
              ),
              const SizedBox(
                height: 40,
              ),
              Column(
                children: [
                  Column(
                    children: [
                      FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Image.network(
                            product.imageURL,
                            width: 250,
                            height: 250,
                          )),
                      TextButton(
                          onPressed: () {}, child: const Text('Editar imagen'))
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  FittedBox(
                    child: Column(
                      children: [
                        _Label(
                            principalText: 'Categoria',
                            secondaryText: product.category),
                        _Label(
                            principalText: 'Sabor',
                            secondaryText: product.flavor),
                        _Label(
                            principalText: 'Tamaño/Peso',
                            secondaryText: product.weight?.toString() ??
                                'Sin tamaño fijo'),
                        _Label(
                            principalText: 'Precio',
                            secondaryText:
                                product.price?.toString() ?? 'Sin precio fijo'),
                        const _Label(
                            principalText: 'Fecha de expiracion proxima',
                            secondaryText: ''),
                        const SizedBox(
                          height: 20,
                        ),
                        const Wrap(
                          spacing: 10,
                          alignment: WrapAlignment.center,
                          children: [
                            FittedBox(
                                child: CustomCheckbox(
                                    title: 'Producto retornable')),
                            FittedBox(
                                child: CustomCheckbox(
                                    title: 'Producto de precio fijo'))
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ));
  }
}

class _Label extends StatelessWidget {
  final String principalText;
  final String secondaryText;

  const _Label({required this.principalText, required this.secondaryText});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;
    final secondaryColor = Theme.of(context).colorScheme.secondary;
    final primaryColor = Theme.of(context).colorScheme.primary;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: FittedBox(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
                decoration: BoxDecoration(
                  color: primaryColor,
                  border: Border.all(color: primaryColor),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                child: Text(
                  principalText,
                  style: const TextStyle(color: Colors.white),
                )),
            Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                decoration: BoxDecoration(border: Border.all()),
                child: Text(secondaryText)),
          ],
        ),
      ),
    );
  }
}
