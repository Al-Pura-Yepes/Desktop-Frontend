import 'package:al_pura_frontend/feature/sale/domain/model/product_model.dart';
import 'package:al_pura_frontend/feature/sale/domain/model/products_model.dart';
import 'package:al_pura_frontend/feature/shared/widget/product_card.dart';
import 'package:flutter/material.dart';

class ProductsBoard extends StatelessWidget {
  final List<ProductsModel> allProducts = const [
    ProductsModel(category: 'Yogurt Griego', products: [
      ProductModel(name: 'Griego', category: 'Griego'),
      ProductModel(name: 'Griego', category: 'Griego'),
      ProductModel(name: 'Griego', category: 'Griego'),
      ProductModel(name: 'Griego', category: 'Griego'),
      ProductModel(name: 'Griego', category: 'Griego'),
      ProductModel(name: 'Griego', category: 'Griego')
    ]),
    ProductsModel(category: 'Yogurt Probiotico', products: [
      ProductModel(name: 'Griego', category: 'Griego'),
    ]),
    ProductsModel(category: 'Yogurt Griego', products: [
      ProductModel(name: 'Griego', category: 'Griego'),
      ProductModel(name: 'Griego', category: 'Griego'),
      ProductModel(name: 'Griego', category: 'Griego'),
      ProductModel(name: 'Griego', category: 'Griego'),
      ProductModel(name: 'Griego', category: 'Griego'),
      ProductModel(name: 'Griego', category: 'Griego')
    ]),
  ];

  const ProductsBoard({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: allProducts.length,
      itemBuilder: (context, index) {
        return _ProductsCategoryContent(products: allProducts[index]);
      },
    );
  }
}

class _ProductsCategoryContent extends StatelessWidget {
  final ProductsModel products;

  const _ProductsCategoryContent({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            products.category,
            textAlign: TextAlign.start,
            style: textTheme.titleMedium,
          ),
          const SizedBox(
            height: 10,
          ),
          GridView.builder(
            itemCount: products.products.length,
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 5,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemBuilder: (context, index) {
              return const ProductCard();
            },
          ),
        ],
      ),
    );
  }
}
