import 'package:al_pura_frontend/features/product/domain/entities/category.dart';
import 'package:al_pura_frontend/features/product/domain/entities/flavor.dart';
import 'i_product_filter.dart';

class FirebaseProductFilter implements IProductFilter {
  @override
  Map<String, dynamic> toMap() {
    return {
      'flavor.flavorLabel': this.flavor?.flavorLabel,
      'category.categoryLabel': this.category?.categoryLabel,
    };
  }

  @override
  Category? category;

  @override
  Flavor? flavor;

  FirebaseProductFilter({this.category, this.flavor});
}