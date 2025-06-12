import 'package:al_pura_frontend/features/product/domain/entities/category.dart';

abstract class CategoryRepository {
  Future<List<Category>> getAll();
}