import 'package:al_pura_frontend/feature/shared/domain/model/product.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatefulWidget {
  final Product product;
  final int? quantity;
  final void Function() callback;
  const ProductCard(
      {super.key,
      this.quantity,
      required this.product,
      required this.callback});

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  Color _getQuantityColor() {
    switch (widget.product.quantity) {
      case >= 10:
        return Colors.green;
      case > 5:
        return Colors.orangeAccent;
      default:
        return Colors.red;
    }
  }

  bool isFront = true;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
          color: _getQuantityColor(),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: _getQuantityColor(), width: 3)),
      child: Stack(
        children: [
          ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              child: _FrontCard(
                product: widget.product,
                callback: widget.callback,
              )),
          Align(
              alignment: Alignment.topRight,
              child: FractionallySizedBox(
                widthFactor: widget.product.weight != null ? 0.3 : 0.6,
                heightFactor: 0.3,
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: _getQuantityColor(),
                      borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(10))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.product.weight == null
                            ? widget.product.quantity.toStringAsFixed(3)
                            : widget.product.quantity.toString(),
                        style: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        widget.product.weight == null ? "Kg" : "u",
                        style: const TextStyle(color: Colors.white),
                      )
                    ],
                  ),
                ),
              ))
        ],
      ),
    );
  }

  void setDisplay(bool isFront) {
    setState(() {
      this.isFront = isFront;
    });
  }
}

class _FrontCard extends StatelessWidget {
  final Product product;
  final void Function()? callback;
  final int? quantity;
  const _FrontCard({this.callback, required this.product, this.quantity});

  @override
  Widget build(BuildContext context) {
    final secondaryColor = Theme.of(context).colorScheme.secondary;
    final textTheme = Theme.of(context).textTheme;
    final primaryColor = Theme.of(context).primaryColor;
    return GestureDetector(
      onTap: callback,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.network(
            product.imageURL,
            fit: BoxFit.fill,
            loadingBuilder: (context, child, loadingProgress) {
              return Container(
                color: Colors.grey,
                child: child,
              );
            },
          ),
          Positioned(
              bottom: 0,
              right: 0,
              left: 0,
              height: 50,
              child: Container(
                color: primaryColor,
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Text(
                  '${product.flavor} - ${product.weight?.toStringAsFixed(0) ?? 0}${product.weightValue}',
                  style: textTheme.bodySmall?.copyWith(color: Colors.white),
                ),
              )),
          if (quantity != null)
            Positioned(
                right: 0,
                top: 0,
                child: Container(
                  decoration: BoxDecoration(
                      color: secondaryColor,
                      borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(8))),
                  height: 60,
                  width: 60,
                  alignment: Alignment.center,
                  child: Text(
                    quantity.toString(),
                    style: textTheme.bodyLarge?.copyWith(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ))
        ],
      ),
    );
  }
}

class _BackCard extends StatelessWidget {
  final List<Object> options;
  final void Function()? callback;

  const _BackCard({required this.options, this.callback});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final primaryColor = Theme.of(context).primaryColor;
    return Container(
      color: primaryColor,
      child: Column(
        children: [
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return GridView.builder(
                  padding: const EdgeInsets.all(10),
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisExtent: options.length > 2
                        ? constraints.maxHeight / 2
                        : constraints.maxHeight,
                  ),
                  itemCount: options.length,
                  itemBuilder: (context, index) {
                    return Align(
                      alignment: Alignment.center,
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8)),
                        alignment: Alignment.center,
                        height: constraints.maxHeight / 2 - 20,
                        width: constraints.maxHeight / 2 - 20,
                        child: Text("${options[index]}L"),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          GestureDetector(
            onTap: callback,
            child: Container(
              color: Colors.transparent,
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              height: 50,
              child: Container(
                height: 5,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
