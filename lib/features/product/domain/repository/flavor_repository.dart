import 'package:al_pura_frontend/features/product/domain/entities/flavor.dart';

abstract class FlavorRepository {
  Future<List<Flavor>> getAll();
}
