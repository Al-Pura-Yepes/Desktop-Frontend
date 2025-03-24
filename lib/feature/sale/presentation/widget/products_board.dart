import 'package:al_pura_frontend/feature/sale/presentation/providers/cart_provider.dart';
import 'package:al_pura_frontend/feature/shared/domain/model/product.dart';
import 'package:al_pura_frontend/feature/shared/Provider/products_provider.dart';
import 'package:al_pura_frontend/feature/shared/widget/product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductsBoard extends ConsumerWidget {
  const ProductsBoard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productsState = ref.watch(productsProvider).products;
    final categories = productsState.keys.toList();

    if (productsState.isEmpty) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return ListView.builder(
      itemCount: categories.length,
      itemBuilder: (context, index) {
        final List<Product> productsList =
            productsState[categories[index]] ?? [];
        return _ProductsCategoryContent(
            category: categories[index], products: productsList);
      },
    );
  }
}

class _ProductsCategoryContent extends ConsumerWidget {
  final String category;
  final List<Product> products;

  const _ProductsCategoryContent(
      {required this.category, required this.products});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            category,
            textAlign: TextAlign.start,
            style: textTheme.titleMedium,
          ),
          const SizedBox(
            height: 10,
          ),
          LayoutBuilder(
            builder: (context, constraints) {
              int columnsNumber = constraints.maxWidth > 1000 ? 5 : 4;
              return GridView.builder(
                itemCount: products.length,
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: columnsNumber,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemBuilder: (context, index) {
                  final data = products[index];
                  return ProductCard(
                    product: data,
                    callback: () {
                      ref.read(cartProvider.notifier).addItemToCart(data);
                    },
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
