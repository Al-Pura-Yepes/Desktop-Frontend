import 'package:al_pura_frontend/features/product/domain/entities/flavor.dart';
import 'package:al_pura_frontend/features/product/domain/repository/flavor_repository.dart';

enum FlavorTypes {
  CHIRIMOYA('Chirimoya', '#F4A300', '1', false),        // Golden yellow
  COCO('Coco', '#D4B896', '2', false),                 // Light brown (coconut shell)
  COCO_STEVIA('Coco', '#D4B896', '3', true),           // Light brown (coconut shell)
  DURAZNO('Durazno', '#FFB366', '4', false),           // Light peach
  FRUTILLA('Frutilla', '#FF9999', '5', false),         // Light strawberry red
  FRUTILLA_STEVIA('Frutilla', '#FF9999', '6', true),   // Light strawberry red
  MANGO('Mango', '#FFD700', '7', false),               // Bright mango yellow
  MARACUYA('Maracuya', '#FFC649', '8', false),         // Passion fruit orange
  MENTA('Menta', '#98E4D6', '9', false),               // Light mint green
  MENTA_STEVIA('Menta', '#98E4D6', '10', true),        // Light mint green
  MORA('Mora', '#B19CD9', '11', false),                // Light purple (blackberry)
  MORA_STEVIA('Mora', '#B19CD9', '12', true),          // Light purple (blackberry)
  NATURAL('Natural', '#87CEEB', '13', false),          // Sky blue
  CRIOLLO('Criollo', '#F4C430', '14', false),          // Saffron yellow
  CRIOLLO_MESA('Criollo Mesa', '#F4C430', '15', false), // Saffron yellow
  MOZZARELLA('Mozarella', '#FFF8DC', '16', false),     // Cornsilk (cheese color)
  RIO_GRANDE('Rio Grande', '#F5DEB3', '17', false);    // Wheat color

  final String title;
  final String colorHex;
  final String id;
  final bool hasStevia;

  const FlavorTypes(this.title, this.colorHex, this.id, this.hasStevia);
}

class LocalFlavorRepository implements FlavorRepository {
  @override
  Future<List<Flavor>> getAll() async {
    List<Flavor> categoryList = [];
    for (var value in FlavorTypes.values) {
      categoryList.add(Flavor(
          label: value.title,
          id: value.id,
          hexColor: value.colorHex,
          hasStevia: value.hasStevia));
    }
    return categoryList;
  }
}
