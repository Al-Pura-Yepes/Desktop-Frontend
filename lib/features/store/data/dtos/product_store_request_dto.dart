import 'package:al_pura_frontend/core/models/i_request_dto.dart';
import 'package:al_pura_frontend/features/store/domain/entities/product_store.dart';

class ProductStoreRequestDto implements IRequestDto<ProductStore> {
  @override
  Map<String, dynamic> toJson(ProductStore entity) {
    return {'product': entity.product.id, 'stock': entity.stock};
  }
}
