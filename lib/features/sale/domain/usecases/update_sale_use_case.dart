import 'package:al_pura_frontend/core/entities/i_use_case.dart';
import 'package:al_pura_frontend/features/sale/domain/entities/sale.dart';
import 'package:al_pura_frontend/features/sale/domain/repositories/sale_repository.dart';

class UpdateSaleUseCase implements IUseCase<Future<void>, Sale> {
  final SaleRepository repository;

  UpdateSaleUseCase({required this.repository});

  @override
  Future<void> execute(Sale value) {
    return repository.update(value);
  }
}
