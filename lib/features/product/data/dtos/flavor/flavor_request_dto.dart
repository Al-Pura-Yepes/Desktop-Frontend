import 'package:al_pura_frontend/core/models/i_request_dto.dart';
import 'package:al_pura_frontend/features/product/domain/entities/flavor.dart';

class FlavorRequestDto implements IRequestDto<Flavor> {
  @override
  Map<String, dynamic> toJson(Flavor entity) {
    return {
      'id': entity.id,
      'label': entity.label,
      'hexColor': entity.hexColor,
      'hasStevia': entity.hasStevia,
    };
  }
}
