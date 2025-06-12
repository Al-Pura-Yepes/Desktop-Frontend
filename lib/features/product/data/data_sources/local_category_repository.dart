import 'package:al_pura_frontend/features/product/domain/entities/category.dart';
import 'package:al_pura_frontend/features/product/domain/repository/category_repository.dart';

enum CategoryTypes {YOGURT, LECHE, QUESO, VARIOS, GRIEGO}

class LocalCategoryRepository implements CategoryRepository {
  @override
  Future<List<Category>> getAll() async {
    List<Category> categoryList = [];
    for (var value in CategoryTypes.values){
      categoryList.add(Category(categoryLabel: value.name));
    }
    return categoryList;
  }
}