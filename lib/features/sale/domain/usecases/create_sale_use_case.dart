import 'package:al_pura_frontend/core/entities/i_use_case.dart';
import 'package:al_pura_frontend/features/sale/domain/entities/sale.dart';
import 'package:al_pura_frontend/features/sale/domain/repositories/sale_repository.dart';

class CreateSaleUseCase implements IUseCase<Future<Sale>, Sale> {
  final SaleRepository repository;

  CreateSaleUseCase({required this.repository});

  @override
  Future<Sale> execute(Sale value) {
    return repository.create(value);
  }
}
