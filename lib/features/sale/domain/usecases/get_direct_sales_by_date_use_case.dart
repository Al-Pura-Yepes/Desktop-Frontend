import 'package:al_pura_frontend/core/entities/i_use_case.dart';
import 'package:al_pura_frontend/features/sale/domain/entities/sale.dart';
import 'package:al_pura_frontend/features/sale/domain/repositories/sale_repository.dart';

class GetDirectSalesByDateUseCase
    implements IUseCase<Future<List<Sale>>, DateTime> {
  final SaleRepository repository;

  GetDirectSalesByDateUseCase({required this.repository});

  @override
  Future<List<Sale>> execute(DateTime date) {
    return repository.getDirectSalesByDate(date);
  }
}
