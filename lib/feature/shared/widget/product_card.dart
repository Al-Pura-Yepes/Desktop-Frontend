import 'package:flutter/material.dart';

class ProductCard extends StatefulWidget {
  final int? quantity;
  const ProductCard({super.key, this.quantity});

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  bool isFront = true;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        child: isFront
            ? _FrontCard(
                callback: () => setDisplay(false),
                quantity: 2,
              )
            : _BackCard(
                options: [1, 2, 3],
                callback: () => setDisplay(true),
              ));
  }

  void setDisplay(bool isFront) {
    setState(() {
      this.isFront = isFront;
    });
  }
}

class _FrontCard extends StatelessWidget {
  final void Function()? callback;
  final int? quantity;
  const _FrontCard({super.key, this.callback, this.quantity});

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
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRkp6vYs35kehbhWkTJFVsWPd6295PZSWg1pwgIqN29Mkw-60InZs9L13MCt3a5GY2dIzI&usqp=CAU",
            fit: BoxFit.fill,
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
                  "Yogurt Probiotico SA Mango",
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
                      borderRadius:
                          BorderRadius.only(bottomLeft: Radius.circular(8))),
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

  const _BackCard({super.key, required this.options, this.callback});

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
