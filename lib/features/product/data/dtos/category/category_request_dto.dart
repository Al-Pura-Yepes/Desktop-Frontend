import 'package:al_pura_frontend/core/models/i_request_dto.dart';
import 'package:al_pura_frontend/features/product/domain/entities/category.dart';

class CategoryRequestDto implements IRequestDto<Category> {
  @override
  Map<String, dynamic> toJson(Category entity) {
    return {
      'id': entity.id,
      'label': entity.label,
    };
  }
}
