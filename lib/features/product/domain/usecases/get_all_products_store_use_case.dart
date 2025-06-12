import 'package:al_pura_frontend/core/entities/i_use_case.dart';
import 'package:al_pura_frontend/features/product/domain/entities/stock.dart';
import 'package:al_pura_frontend/features/product/domain/repository/filters/product/i_product_filter.dart';
import 'package:al_pura_frontend/features/product/domain/repository/product_store_repository.dart';

class GetAllProductsStoreUseCase implements IUseCase<Future<List<ProductStore>>, IProductFilter>{

  final ProductStoreRepository repository;

  const GetAllProductsStoreUseCase({required this.repository});

  @override
  Future<List<ProductStore>> execute(IProductFilter filter) async{
    return repository.getAll(filter);
  }
}