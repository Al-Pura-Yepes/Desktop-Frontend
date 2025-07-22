import 'package:al_pura_frontend/core/utils/colors_utils.dart';
import 'package:al_pura_frontend/features/product/domain/entities/flavor.dart';
import 'package:al_pura_frontend/features/product/domain/entities/product.dart';
import 'package:al_pura_frontend/features/sale/domain/entities/product_sale.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final void Function(Product product) callback;
  const ProductCard({super.key, required this.product, required this.callback});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        callback(product);
      },
      child: Stack(
        fit: StackFit.expand,
        children: [
          _ProductImage(product: product),
          if (product.isFixedPrice)
            _ProductWeight(
              weight: product.weight!.toString(),
              weightLabel: product.weightLabel,
            ),
          _ProductFlavor(flavor: product.flavor)
        ],
      ),
    );
  }
}

class _ProductFlavor extends StatelessWidget {
  final Flavor flavor;

  const _ProductFlavor({super.key, required this.flavor});

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.bottomLeft,
        child: FractionallySizedBox(
          widthFactor: 0.7,
          heightFactor: 0.6,
          child: Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsetsGeometry.symmetric(
                  vertical: 10, horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                spacing: 2,
                children: [
                  if (flavor.hasStevia == false) const Expanded(flex: 3, child: SizedBox.shrink()),
                  if (flavor.hasStevia)
                    Expanded(
                        flex: 3,
                        child: FittedBox(
                            fit: BoxFit.fill,
                            child: Chip(
                              label: Text(
                                'Stevia',
                                style: TextStyle(
                                    color:
                                        ColorUtils.getTextColorForBackground(
                                            '8BC34A')),
                              ),
                              backgroundColor: const Color(0xff8BC34A),
                              side:
                                  const BorderSide(color: Color(0xff8BC34A)),
                            ))),
                  Expanded(
                    flex: 4,
                    child: SizedBox.expand(
                      child: FittedBox(
                        fit: BoxFit.fill,
                        child: Chip(
                          label: Text(flavor.label,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color: ColorUtils.getTextColorForBackground(
                                      flavor.hexColor))),
                          backgroundColor: ColorUtils.fromHex(flavor.hexColor),
                          side: BorderSide(
                              color: ColorUtils.fromHex(flavor.hexColor)),
                        ),
                      ),
                    ),
                  ),
                ],
              )),
        ));
  }
}

class _ProductImage extends StatelessWidget {
  const _ProductImage({
    required this.product,
  });

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Image.network(
      product.productImage,
      errorBuilder: (context, error, stackTrace) {
        return Container(
          color: Colors.grey,
        );
      },
      fit: BoxFit.fill,
      loadingBuilder: (context, child, loadingProgress) {
        return Container(
          color: Colors.grey,
          child: child,
        );
      },
    );
  }
}

class _ProductWeight extends StatelessWidget {
  final String weight;
  final String weightLabel;

  const _ProductWeight(
      {super.key, required this.weight, required this.weightLabel});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: FractionallySizedBox(
        heightFactor: 0.5,
        child: Container(
            alignment: Alignment.bottomRight,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            decoration: const BoxDecoration(
                gradient: RadialGradient(
                    center: Alignment.bottomRight,
                    radius: 1,
                    stops: [
                  0.3,
                  1
                ],
                    colors: [
                  Colors.black,
                  Colors.transparent,
                ])),
            child: LayoutBuilder(
              builder: (context, constraints) {
                return RichText(
                  textAlign: TextAlign.end,
                  text: TextSpan(
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: constraints.maxHeight * 0.4),
                    children: [
                      TextSpan(text: weight),
                      TextSpan(text: weightLabel)
                    ],
                  ),
                );
              },
            )),
      ),
    );
  }
}
