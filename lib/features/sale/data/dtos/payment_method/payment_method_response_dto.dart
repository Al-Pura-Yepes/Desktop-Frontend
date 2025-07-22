import 'package:al_pura_frontend/core/models/i_response_dto.dart';
import 'package:al_pura_frontend/features/sale/domain/entities/payment_method.dart';

class PaymentMethodResponseDto implements IResponseDto<PaymentMethod> {
  @override
  PaymentMethod fromJson(Map<String, dynamic> response) {
    return PaymentMethod(id: response['id'], label: response['label']);
  }
}
