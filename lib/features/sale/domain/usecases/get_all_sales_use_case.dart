import 'package:al_pura_frontend/core/entities/i_use_case.dart';
import 'package:al_pura_frontend/features/sale/domain/entities/sale.dart';
import 'package:al_pura_frontend/features/sale/domain/repositories/sale_repository.dart';

class GetAllSalesUseCase implements IUseCase<Future<List<Sale>>, void> {
  final SaleRepository repository;

  GetAllSalesUseCase({required this.repository});

  @override
  Future<List<Sale>> execute(void _) {
    return repository.getAll();
  }
}
