import 'package:al_pura_frontend/core/entities/i_entity.dart';

abstract class IRequestDto<T extends IEntity> {
  Map<String, dynamic> toJson(T entity);
}
