import 'package:al_pura_frontend/features/product/domain/entities/category.dart';
import 'package:al_pura_frontend/features/product/domain/repository/category_repository.dart';

enum CategoryTypes {
  YOGURT('1', 'Yogurts Probioticos'),
  LECHE('2', 'Leches'),
  QUESO('3', 'Quesos'),
  VARIOS('4', 'Productos Varios'),
  GRIEGO('5', 'Yogurts Griegos');

  final String id;
  final String title;

  const CategoryTypes(this.id, this.title);
}

class LocalCategoryRepository implements CategoryRepository {
  @override
  Future<List<Category>> getAll() async {
    List<Category> categoryList = [];
    for (var value in CategoryTypes.values) {
      categoryList.add(Category(label: value.title, id: value.id));
    }
    return categoryList;
  }
}
