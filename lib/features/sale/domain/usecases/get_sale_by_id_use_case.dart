import 'package:al_pura_frontend/core/entities/i_use_case.dart';
import 'package:al_pura_frontend/features/sale/domain/entities/sale.dart';
import 'package:al_pura_frontend/features/sale/domain/repositories/sale_repository.dart';

class GetSaleByIdUseCase implements IUseCase<Future<Sale?>, String> {
  final SaleRepository repository;

  GetSaleByIdUseCase({required this.repository});

  @override
  Future<Sale?> execute(String value) {
    return repository.get(value);
  }
}
