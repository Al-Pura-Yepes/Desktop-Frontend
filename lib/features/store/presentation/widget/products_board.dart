import 'package:al_pura_frontend/features/product/domain/entities/product.dart';
import 'package:al_pura_frontend/features/product/presentation/widgets/product_card.dart';
import 'package:al_pura_frontend/features/store/presentation/provider/store_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class StoreBoard extends ConsumerWidget {
  final void Function(Product product)? callback;

  const StoreBoard({super.key, this.callback});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final store = ref.watch(storeProvider).store;
    final categories = store.keys.toList();

    if (store.isEmpty) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return ListView.builder(
      itemCount: categories.length,
      itemBuilder: (context, index) {
        List<Product> productList = [];
        store[categories[index]]!.forEach((key, value) {
          productList = [
            ...productList,
            ...value.map(
              (e) => e.product,
            )
          ];
        });
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: _ProductsSection(
              callback: (Product product) {
                callback!(product);
              },
              category: categories[index].label,
              products: productList),
        );
      },
    );
  }
}

class _ProductsSection extends StatelessWidget {
  final String category;
  final List<Product> products;
  final void Function(Product product) callback;

  const _ProductsSection(
      {required this.category, required this.products, required this.callback});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      spacing: 5,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          category,
          textAlign: TextAlign.start,
          style: textTheme.titleMedium,
        ),
        GridView.builder(
          itemCount: products.length,
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7, mainAxisSpacing: 5, crossAxisSpacing: 5),
          itemBuilder: (context, index) {
            final data = products[index];
            return ProductCard(
              product: data,
              callback: (Product product) {
                callback(product);
              },
            );
          },
        ),
        const SizedBox(
          height: 15,
        )
      ],
    );
  }
}
