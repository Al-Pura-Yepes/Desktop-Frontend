import 'package:al_pura_frontend/features/sale/domain/entities/sale.dart';
import 'package:al_pura_frontend/features/sale/domain/entities/product_sale.dart';
import 'package:al_pura_frontend/features/sale/domain/entities/payment_method.dart';
import 'package:al_pura_frontend/features/sale/domain/repositories/sale_repository.dart';
import 'package:al_pura_frontend/features/sale/domain/usecases/get_direct_sales_by_date_use_case.dart';
import 'package:al_pura_frontend/features/sale/domain/usecases/update_sale_use_case.dart';
import 'package:al_pura_frontend/features/sale/presentation/providers/sale_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SalesState {
  final Map<String, Sale> sales;
  final DateTime currentDate;
  final bool isLoading;
  final String? error;
  final double totalSales;
  final double subtotalQRSales;
  final double subtotalCashSales;

  SalesState({
    Map<String, Sale>? sales,
    DateTime? currentDate,
    this.isLoading = false,
    this.error,
    double? totalSales,
    double? subtotalQRSales,
    double? subtotalCashSales,
    Map<String, ProductSale>? products,
  })  : sales = sales ?? const {},
        currentDate = currentDate ?? DateTime.now(),
        totalSales = totalSales ?? 0.0,
        subtotalQRSales = subtotalQRSales ?? 0.0,
        subtotalCashSales = subtotalCashSales ?? 0.0;

  SalesState copyWith({
    Map<String, Sale>? sales,
    DateTime? currentDate,
    bool? isLoading,
    String? error,
    double? totalSales,
    double? subtotalQRSales,
    double? subtotalCashSales,
    Map<String, ProductSale>? products,
  }) {
    return SalesState(
      sales: sales ?? this.sales,
      currentDate: currentDate ?? this.currentDate,
      isLoading: isLoading ?? this.isLoading,
      error: error,
      totalSales: totalSales ?? this.totalSales,
      subtotalQRSales: subtotalQRSales ?? this.subtotalQRSales,
      subtotalCashSales: subtotalCashSales ?? this.subtotalCashSales,
    );
  }
}

class SalesNotifier extends StateNotifier<SalesState> {
  final SaleRepository _repository;

  SalesNotifier(this._repository) : super(SalesState()) {
    loadSales();
  }

 // TODO: ACTUALIZAR EL LOAD PARA QUE CARGUE LOS SALES AL MISMO TIEMPO QUE ITERA LA LISTA PARA CREAR EL MAP
  Future<void> loadSales() async {
    try {
      final getSalesUseCase =
          GetDirectSalesByDateUseCase(repository: _repository);
      final salesList = await getSalesUseCase.execute(state.currentDate);
      print(salesList);

      final salesMap = {for (var sale in salesList) sale.id: sale};
      
      final (total, qrTotal, cashTotal) = _updateFinancialTotals(salesMap.values.toList());
      
      state = state.copyWith(
        sales: salesMap,
        isLoading: false,
        totalSales: total,
        subtotalQRSales: qrTotal,
        subtotalCashSales: cashTotal
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
      rethrow;
    }
  }

  
  Future<void> disableSale(String saleId) async {
    try {
      final sale = state.sales[saleId];
      if (sale == null) return;

      final updatedSale = sale.copyWith(isAvailable: false);

      final updateUseCase = UpdateSaleUseCase(repository: _repository);
      await updateUseCase.execute(updatedSale);

      final updatedSales = Map<String, Sale>.from(state.sales);
      updatedSales[saleId] = updatedSale;

      final (newTotal, newQrTotal, newCashTotal) = _updateFinancialByIndividualSale(updatedSale);
      
      state = state.copyWith(
        sales: updatedSales,
        totalSales: newTotal,
        subtotalQRSales: newQrTotal,
        subtotalCashSales: newCashTotal
      );
    } catch (e) {
      state = state.copyWith(error: e.toString());
      rethrow;
    }
  }


  (double, double, double) _updateFinancialTotals(List<Sale> sales) {
    double total = 0.0;
    double qrTotal = 0.0;
    double cashTotal = 0.0;
    
    for (final sale in sales) {
      if (!sale.isAvailable) continue; 
      
      total += sale.totalPrice;
      if (sale.paymentMethod.id == PaymentMethods.QR.id) {
        qrTotal += sale.totalPrice;
      } else if (sale.paymentMethod.id == PaymentMethods.CASH.id) {
        cashTotal += sale.totalPrice;
      }
    }
    
    return (total, qrTotal, cashTotal);
  }

  void createSale(Sale sale) {
    var updatedSales = Map<String, Sale>.from( {sale.id: sale, ...state.sales});
    
    final (newTotal, newQrTotal, newCashTotal) = _updateFinancialByIndividualSale(sale);
    
    state = state.copyWith(
      sales: updatedSales,
      totalSales: newTotal,
      subtotalQRSales: newQrTotal,
      subtotalCashSales: newCashTotal,
    );
  }

  void updateSale(Sale sale) {
    final updatedSales = Map<String, Sale>.from(state.sales);
    
    if (updatedSales.containsKey(sale.id)) {
      updatedSales[sale.id] = sale;
      
      final (newTotal, newQrTotal, newCashTotal) = _updateFinancialTotals(updatedSales.values.toList());
      
      state = state.copyWith(
        sales: updatedSales,
        totalSales: newTotal,
        subtotalQRSales: newQrTotal,
        subtotalCashSales: newCashTotal,
      );
    }
  }

  (double, double, double) _updateFinancialByIndividualSale(Sale sale) {
    double amount = sale.isAvailable ? sale.totalPrice : -sale.totalPrice;
    
    double newTotal = state.totalSales + amount;
    double newQrTotal = state.subtotalQRSales;
    double newCashTotal = state.subtotalCashSales;

    if (sale.paymentMethod.id == PaymentMethods.QR.id) {
      newQrTotal += amount;
    } else if (sale.paymentMethod.id == PaymentMethods.CASH.id) {
      newCashTotal += amount;
    }

    return (newTotal, newQrTotal, newCashTotal);
  }

  void setCurrentDate(DateTime date) {
    state = state.copyWith(currentDate: date);
    loadSales();
  }
}

final salesProvider = StateNotifierProvider<SalesNotifier, SalesState>((ref) {
  final repository = ref.watch(saleRepositoryProvider);
  return SalesNotifier(repository);
});
