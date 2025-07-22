import 'package:al_pura_frontend/core/models/i_response_dto.dart';
import 'package:al_pura_frontend/features/sale/domain/entities/sale_type.dart';

class SaleTypeResponseDto implements IResponseDto<SaleType> {
  @override
  SaleType fromJson(Map<String, dynamic> response) {
    return SaleType(id: response['id'], label: response['label']);
  }
}
