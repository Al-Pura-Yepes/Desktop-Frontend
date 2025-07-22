import 'package:al_pura_frontend/core/entities/i_entity.dart';
import 'package:al_pura_frontend/core/models/i_request_dto.dart';
import 'package:al_pura_frontend/features/sale/domain/entities/payment_method.dart';

class PaymentMethodRequestDto implements IRequestDto<PaymentMethod> {
  @override
  Map<String, dynamic> toJson(PaymentMethod entity) {
    return {'id': entity.id, 'label': entity.label};
  }
}
