import 'package:al_pura_frontend/core/models/i_response_dto.dart';
import 'package:al_pura_frontend/features/product/domain/entities/category.dart';

class CategoryResponseDto implements IResponseDto<Category> {
  @override
  Category fromJson(Map<String, dynamic> map) {
    return Category(
      id: map['id'] as String,
      label: map['label'] as String,
    );
  }
}
