import 'package:al_pura_frontend/core/utils/firebase_collections.dart';
import 'package:al_pura_frontend/features/sale/data/dtos/sale/sale_request_dto.dart';
import 'package:al_pura_frontend/features/sale/data/dtos/sale/sale_response_dto.dart';
import 'package:al_pura_frontend/features/sale/domain/entities/sale.dart';
import 'package:al_pura_frontend/features/sale/domain/entities/sale_type.dart';
import 'package:al_pura_frontend/features/sale/domain/repositories/sale_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseSaleRepository implements SaleRepository {
  late CollectionReference sales;

  FirebaseSaleRepository() {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    sales = firestore.collection(FirebaseCollections.saleCollections);
  }

  @override
  Future<Sale> create(Sale sale) async {
    try {
      final dto = SaleRequestDto();
      final newSale = await sales.add(dto.toJson(sale));
      final docSnapshot = await newSale.get();
      final Map<String, dynamic> data =
          docSnapshot.data() as Map<String, dynamic>;
      return SaleResponseDto().fromJson({...data, "id": docSnapshot.id});
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Sale?> get(String id) async {
    try {
      DocumentSnapshot doc = await sales.doc(id).get();
      if (doc.exists) {
        Map<String, dynamic> saleData = doc.data() as Map<String, dynamic>;
        return SaleResponseDto().fromJson({
          ...saleData,
          "id": doc.id,
        });
      }
      return null;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<Sale>> getAll() async {
    List<Sale> fetchSales = [];
    try {
      QuerySnapshot snapshot = await sales.get();
      for (DocumentSnapshot doc in snapshot.docs) {
        Map<String, dynamic> saleData = doc.data() as Map<String, dynamic>;
        fetchSales.add(SaleResponseDto().fromJson({
          "id": doc.id,
          ...saleData,
        }));
      }
    } catch (e) {
      rethrow;
    }
    return fetchSales;
  }

  @override
  Future<Sale> update(Sale sale) async {
    try {
      final dto = SaleRequestDto();
      await sales.doc(sale.id).update(dto.toJson(sale));
      return sale;
    } catch (e) {
      rethrow;
    }
  }

  // Funciones temporales

  @override
  Future<List<Sale>> getDirectSalesByDate(DateTime date) async {
    try {
      final startOfDay = DateTime(date.year, date.month, date.day);
      final endOfDay = startOfDay.add(const Duration(days: 1));

      final startUtc = startOfDay.toUtc();
      final endUtc = endOfDay.toUtc();

      final querySnapshot = await sales
          .where('saleDate', isGreaterThanOrEqualTo: Timestamp.fromDate(startUtc))
          .where('saleDate', isLessThan: Timestamp.fromDate(endUtc))
          .where('saleType.id', isEqualTo: SaleTypes.DIRECT_SALE.id)
          .orderBy('saleDate', descending: true)
          .get();

      return querySnapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        print(data);
        return SaleResponseDto().fromJson({
          ...data,
          'id': doc.id,
        });
      }).toList();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<Sale>> getAllReservations() async {
    try {
      final querySnapshot = await sales
          .where('saleType.id', isEqualTo: SaleTypes.RESERVATION.id)
          .get();

      return querySnapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return SaleResponseDto().fromJson({
          'id': doc.id,
          ...data,
        });
      }).toList();
    } catch (e) {
      rethrow;
    }
  }
}
