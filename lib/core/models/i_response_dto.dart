import 'package:al_pura_frontend/core/entities/i_entity.dart';

abstract class IResponseDto<T extends IEntity> {
  T fromJson(Map<String, dynamic> response);
}
