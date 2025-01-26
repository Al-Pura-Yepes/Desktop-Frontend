import 'package:al_pura_frontend/feature/sale/domain/datasource/sale_datasource.dart';
import 'package:al_pura_frontend/feature/sale/domain/model/sale.dart';
import 'package:al_pura_frontend/feature/sale/domain/repository/sale_repository.dart';
import 'package:al_pura_frontend/feature/sale/infrastructure/datasource/sale_datasource_firebase.dart';
import 'package:al_pura_frontend/feature/sale/infrastructure/repository/sale_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../shared/domain/model/user.dart';

class SalesState {
  final bool isSaleSelected;
  final int? indexSelected;
  final bool isDateAscending;
  final List<Sale> sales;
  final Sale? sale;
  final User? client;
  final DateTime? dayFiltered;

  SalesState({
    this.isSaleSelected = false,
    this.isDateAscending = true,
    this.indexSelected,
    this.sales = const [],
    this.sale,
    this.client,
    this.dayFiltered
  });

  SalesState copyWith({
    bool? isSaleSelected,
    bool? isDateAscending,
    int? indexSelected,
    List<Sale>? sales,
    Sale? sale,
    User? client,
    DateTime? dayFiltered
  }) {
    return SalesState(
      isSaleSelected: isSaleSelected ?? this.isSaleSelected,
      isDateAscending: isDateAscending ?? this.isDateAscending,
      indexSelected: indexSelected ?? this.indexSelected,
      sales: sales ?? this.sales,
      sale: sale ?? this.sale,
      client: client ?? this.client,
      dayFiltered: dayFiltered
    );
  }
}

class SalesNotifier extends StateNotifier<SalesState> {
  final SaleRepository repository;

  SalesNotifier(super.state, this.repository);

  toggleSale() {
    state = state.copyWith(
        isSaleSelected: !state.isSaleSelected,
        dayFiltered: state.dayFiltered
    );
  }

  changeItemSelected(int index) {
    var user = User(
        id: index.toString(),
        fullName: state.sales[index].clientName ?? 'No definido',
        phoneNumber: state.sales[index].clientPhone != null
            ? int.parse(state.sales[index].clientPhone!) : 0
    );
    state = state.copyWith(
        indexSelected: index,
        isSaleSelected: true,
        sale: state.sales[index],
        client: user,
        dayFiltered: state.dayFiltered
    );
  }

  Future<void> loadSales() async {
    state = state.copyWith(
        sales: await repository.getAllSales(state.isDateAscending, state.dayFiltered),
        dayFiltered: state.dayFiltered
    );
  }

  iterateSortByStatus() {
    state = state.copyWith(
        isDateAscending: !state.isDateAscending,
        dayFiltered: state.dayFiltered,
    );
  }

  updateReservation(Sale sale) {
    state = state.copyWith(
        sale: sale,
        dayFiltered: state.dayFiltered
    );
  }

  clearReservations() {
    state = state.copyWith(
      sale: null,
      indexSelected: null,
      isSaleSelected: false,
      dayFiltered: state.dayFiltered
    );
  }

  selectDay(DateTime? day) {
    state = state.copyWith(
      dayFiltered: day
    );
  }
}

final salesProvider = StateNotifierProvider<SalesNotifier, SalesState>((ref) {
  final SaleDatasource datasource = SaleDatasourceFirebase();
  final SaleRepository repository = SaleRepositoryImpl(datasource: datasource);
  return SalesNotifier(SalesState(), repository);
});