import 'package:al_pura_frontend/features/product/domain/entities/category.dart';
import 'package:al_pura_frontend/features/product/domain/entities/flavor.dart';

abstract class IProductFilter {
  Flavor? flavor;
  Category? category;

  Map<String, dynamic> toMap();
}