import 'package:al_pura_frontend/core/models/i_response_dto.dart';
import 'package:al_pura_frontend/features/product/domain/entities/flavor.dart';

class FlavorResponseDto implements IResponseDto<Flavor> {
  @override
  Flavor fromJson(Map<String, dynamic> map) {
    return Flavor(
        id: map['id'] as String,
        label: map['label'] as String,
        hexColor: map['hexColor'],
        hasStevia: map['hasStevia']);
  }
}
