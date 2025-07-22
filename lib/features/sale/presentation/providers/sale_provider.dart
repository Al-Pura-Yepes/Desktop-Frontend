import 'package:al_pura_frontend/features/product/domain/entities/product.dart';
import 'package:al_pura_frontend/features/sale/domain/entities/payment_method.dart';
import 'package:al_pura_frontend/features/sale/domain/entities/sale.dart';
import 'package:al_pura_frontend/features/sale/domain/entities/sale_type.dart';
import 'package:al_pura_frontend/features/sale/domain/entities/product_sale.dart';
import 'package:al_pura_frontend/features/sale/domain/repositories/sale_repository.dart';
import 'package:al_pura_frontend/features/sale/domain/usecases/get_sale_by_id_use_case.dart';
import 'package:al_pura_frontend/features/sale/domain/usecases/create_sale_use_case.dart';
import 'package:al_pura_frontend/features/sale/domain/usecases/update_sale_use_case.dart';
import 'package:al_pura_frontend/features/sale/presentation/providers/sale_repository_provider.dart';
import 'package:al_pura_frontend/features/sale/presentation/providers/sales_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SaleState {
  final String id;
  final PaymentMethod paymentMethod;
  final SaleType saleType;
  final Map<String, ProductSale> products;
  final double discount;
  final double totalPrice;
  final double subtotal;
  final DateTime saleDate;
  final bool isDelivery;
  final bool isAvailable;
  final bool isLoading;
  final String? error;

  SaleState({
    this.id = '',
    PaymentMethod? paymentMethod,
    SaleType? saleType,
    Map<String, ProductSale>? products,
    this.discount = 0.0,
    this.totalPrice = 0.0,
    this.subtotal = 0.0,
    DateTime? saleDate,
    this.isDelivery = false,
    this.isAvailable = true,
    this.isLoading = false,
    this.error,
  })  : paymentMethod = paymentMethod ??
            PaymentMethod(
                id: PaymentMethods.CASH.id, label: PaymentMethods.CASH.title),
        saleType = saleType ??
            SaleType(
                id: SaleTypes.DIRECT_SALE.id,
                label: SaleTypes.DIRECT_SALE.title),
        products = products ?? const {},
        saleDate = saleDate ?? DateTime.now();

  SaleState copyWith({
    String? id,
    PaymentMethod? paymentMethod,
    SaleType? saleType,
    Map<String, ProductSale>? products,
    double? discount,
    double? totalPrice,
    double? subtotal,
    DateTime? saleDate,
    bool? isDelivery,
    bool? isAvailable,
    bool? isLoading,
    String? error,
  }) {
    return SaleState(
      id: id ?? this.id,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      saleType: saleType ?? this.saleType,
      products: products ?? this.products,
      discount: discount ?? this.discount,
      totalPrice: totalPrice ?? this.totalPrice,
      subtotal: subtotal ?? this.subtotal,
      saleDate: saleDate ?? this.saleDate,
      isDelivery: isDelivery ?? this.isDelivery,
      isAvailable: isAvailable ?? this.isAvailable,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }

  List<ProductSale> get productsList => products.values.toList();
}

class SaleNotifier extends StateNotifier<SaleState> {
  final String saleId;
  final void Function(Sale sale) onSaleCreated;
  final void Function(Sale sale) onSaleUpdated;
  final SaleRepository _repository;

  SaleNotifier({
    required this.saleId,
    required SaleRepository repository,
    required this.onSaleCreated,
    required this.onSaleUpdated,
  })  : _repository = repository,
        super(SaleState()) {
    if (saleId.isNotEmpty) {
      loadSale();
    }
  }

  (double, double) _calculateTotalPrice(
      Map<String, ProductSale> products, double discount) {
    final subtotal = products.values.fold<double>(
      0,
      (sum, productSale) =>
          sum + (productSale.product.productPrice * productSale.quantity),
    );
    return (subtotal, subtotal - discount);
  }

  Future<void> loadSale() async {
    if (saleId.isEmpty) return;

    try {
      state = state.copyWith(isLoading: true, error: null);

      final getSaleUseCase = GetSaleByIdUseCase(repository: _repository);
      final sale = await getSaleUseCase.execute(saleId);

      if (sale != null) {
        final productsMap = {
          for (var product in sale.products) product.id: product
        };

        state = state.copyWith(
          id: sale.id,
          paymentMethod: sale.paymentMethod,
          saleType: sale.saleType,
          products: productsMap,
          discount: sale.discount,
          subtotal: sale.subtotal,
          totalPrice: sale.totalPrice,
          saleDate: sale.saleDate,
          isDelivery: sale.isDelivery,
          isAvailable: sale.isAvailable,
          isLoading: false,
        );
      } else {
        state = state.copyWith(
          isLoading: false,
          error: 'Sale not found',
        );
      }
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
      rethrow;
    }
  }

  void addProduct(Product product) {
    if (product.isFixedPrice == false && state.products[product.id!] != null) return;
    final productSale =
        ProductSale(id: product.id!, product: product, quantity: 1);
    final updatedProducts = Map<String, ProductSale>.from(state.products);

    if (updatedProducts.containsKey(productSale.id)) {
      final existing = updatedProducts[productSale.id]!;
      updatedProducts[productSale.id] = existing.copyWith(
        quantity: existing.quantity + 1,
      );
    } else {
      updatedProducts[productSale.id] = productSale.copyWith(quantity: 1);
    }

    final (newSubtotal, newTotal) = _calculateTotalPrice(updatedProducts, state.discount);

    state = state.copyWith(
      products: updatedProducts,
      totalPrice: newTotal,
      subtotal: newSubtotal
    );
  }

  void setProductQuantity(String productId, double quantity) {
    if (quantity < 1) return;

    final updatedProducts = Map<String, ProductSale>.from(state.products);

    if (updatedProducts.containsKey(productId)) {
      updatedProducts[productId] = updatedProducts[productId]!.copyWith(
        quantity: quantity,
      );

      final (newSubtotal, newTotal) = _calculateTotalPrice(updatedProducts, state.discount);

      state = state.copyWith(
        products: updatedProducts,
        totalPrice: newTotal,
        subtotal: newSubtotal
      );
    }
  }

  /// Updates the price of a variable-price product and recalculates totals
  void updateProductPrice(String productId, double newPrice) {
    if (newPrice < 0) return;

    final updatedProducts = Map<String, ProductSale>.from(state.products);
    final productSale = updatedProducts[productId];
    
    if (productSale != null && !productSale.product.isFixedPrice) {
      // Create a new product with the updated price
      final updatedProduct = productSale.product.copyWith(productPrice: newPrice);
      
      // Update the ProductSale with the new product
      updatedProducts[productId] = productSale.copyWith(product: updatedProduct);

      // Recalculate totals
      final (newSubtotal, newTotal) = _calculateTotalPrice(updatedProducts, state.discount);

      state = state.copyWith(
        products: updatedProducts,
        totalPrice: newTotal,
        subtotal: newSubtotal,
      );
    }
  }

  void deleteProduct(String productId) {
    if (state.products.length == 1 && state.id.isNotEmpty) return;
    final updatedProducts = Map<String, ProductSale>.from(state.products);
    updatedProducts.remove(productId);

    final (newSubtotal, newTotal) = _calculateTotalPrice(updatedProducts, state.discount);

    state = state.copyWith(
      products: updatedProducts,
      totalPrice: newTotal,
      subtotal: newSubtotal
    );
  }

  void updateDiscount(double discount) {
    if (discount < 0) return;

    final (newSubtotal, newTotal) = _calculateTotalPrice(state.products, discount);

    state = state.copyWith(
      discount: discount,
      totalPrice: newTotal,
      subtotal: newSubtotal,
    );
  }

  Future<Sale> createSale() async {
    try {
      state = state.copyWith(isLoading: true, error: null);
      
      final sale = Sale(
        id: state.id.isEmpty ? DateTime.now().millisecondsSinceEpoch.toString() : state.id,
        paymentMethod: state.paymentMethod,
        saleType: state.saleType,
        products: state.productsList,
        discount: state.discount,
        totalPrice: state.totalPrice,
        subtotal: state.subtotal,
        saleDate: state.saleDate,
        isDelivery: state.isDelivery,
        isAvailable: true,
      );

      final createSaleUseCase = CreateSaleUseCase(repository: _repository);
      final createdSale =  await createSaleUseCase.execute(sale);

      clear();
      onSaleCreated(createdSale);
      return createdSale;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'Failed to create sale: ${e.toString()}',
      );
      rethrow;
    }
  }

  void updatePaymentMethod(PaymentMethod paymentMethod) {
    state = state.copyWith(
      paymentMethod: paymentMethod,
    );
  }

  void updateSaleType(SaleType saleType) {
    state = state.copyWith(
      saleType: saleType,
    );
  }

  void clear() {
    state = SaleState(
      id: '',
      paymentMethod: PaymentMethod(
        id: PaymentMethods.CASH.id,
        label: PaymentMethods.CASH.title,
      ),
      saleType: SaleType(
        id: SaleTypes.DIRECT_SALE.id,
        label: SaleTypes.DIRECT_SALE.title,
      ),
      products: {},
      discount: 0.0,
      totalPrice: 0.0,
      subtotal: 0.0,
      saleDate: DateTime.now(),
      isDelivery: false,
      isAvailable: true,
      isLoading: false,
      error: null,
    );
  }

  Future<void> toggleSale() async {
    if (state.id.isEmpty) return;
    try {      
      final updatedSale = Sale(
        id: state.id,
        paymentMethod: state.paymentMethod,
        saleType: state.saleType,
        products: state.productsList,
        discount: state.discount,
        totalPrice: state.totalPrice,
        subtotal: state.subtotal,
        saleDate: state.saleDate,
        isDelivery: state.isDelivery,
        isAvailable: !state.isAvailable,
      );
      final updateUseCase = UpdateSaleUseCase(repository: _repository);
      await updateUseCase.execute(updatedSale);
      state = state.copyWith(
        isAvailable: !state.isAvailable
      );
      onSaleUpdated(updatedSale);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'Failed to disable sale: ${e.toString()}',
      );
      rethrow;
    }
  }

  Future<void> updateSale() async {
    if (state.id.isEmpty) return;
    try {
      final updatedSale = Sale(
        id: state.id,
        paymentMethod: state.paymentMethod,
        saleType: state.saleType,
        products: state.productsList,
        discount: state.discount,
        totalPrice: state.totalPrice,
        subtotal: state.subtotal,
        saleDate: state.saleDate,
        isDelivery: state.isDelivery,
        isAvailable: state.isAvailable,
      );
      final updateUseCase = UpdateSaleUseCase(repository: _repository);
      await updateUseCase.execute(updatedSale);
      onSaleUpdated(updatedSale);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'Failed to update sale: ${e.toString()}',
      );
      rethrow;
    }
  }
}

final saleProvider =
    StateNotifierProvider.family.autoDispose<SaleNotifier, SaleState, String>(
  (ref, saleId) {
    final repository = ref.watch(saleRepositoryProvider);
    final salesNotifier = ref.read(salesProvider.notifier);
    return SaleNotifier(
      saleId: saleId, 
      repository: repository, 
      onSaleCreated: salesNotifier.createSale,
      onSaleUpdated: salesNotifier.updateSale,
    );
  },
);
