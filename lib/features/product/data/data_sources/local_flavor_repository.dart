import 'package:al_pura_frontend/features/product/domain/entities/category.dart';
import 'package:al_pura_frontend/features/product/domain/entities/flavor.dart';
import 'package:al_pura_frontend/features/product/domain/repository/category_repository.dart';
import 'package:al_pura_frontend/features/product/domain/repository/flavor_repository.dart';

enum FlavorTypes {NATURAL, COCO, CHIRIMOYA, }

class LocalFlavorRepository implements FlavorRepository {
  @override
  Future<List<Flavor>> getAll() async {
    List<Flavor> categoryList = [];
    for (var value in FlavorTypes.values){
      categoryList.add(Flavor(flavorLabel: value.name));
    }
    return categoryList;
  }
}
