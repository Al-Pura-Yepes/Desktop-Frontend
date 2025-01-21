import 'package:al_pura_frontend/feature/reservation/domain/model/status.dart';
import 'package:al_pura_frontend/feature/shared/Domain/model/i_entity.dart';
import 'package:al_pura_frontend/feature/shared/domain/model/product.dart';
import 'package:al_pura_frontend/feature/shared/domain/model/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Reservation extends IEntity {
  @override
  final String id;
  final User client;
  final DateTime deliveryDate;
  final double discount;
  final double totalPrice;
  Status status;
  final bool isDelivery;
  final bool isPerMajor;
  final bool isActive;
  final List<Product> products;

  Reservation({
    required this.id,
    required this.client,
    required this.deliveryDate,
    required this.discount,
    required this.totalPrice,
    required this.status,
    required this.isDelivery,
    required this.isPerMajor,
    required this.isActive,
    required this.products
  });

  Map<String, dynamic> toMap() {
    return {
      "client": client.toMap(),
      "deliveryDate": deliveryDate,
      "discount": discount,
      "totalPrice": totalPrice,
      "status": getIntFromStatus(status),
      "isDelivery": isDelivery,
      "isPerMajor": isPerMajor,
      "isActive": isActive,
      "products": products,
    };
  }

  factory Reservation.fromMap(Map<String, dynamic> map, String id) {
    return Reservation(
        id: id,
        client: User.fromMap(map['client'] as Map<String, dynamic>, 'client'),
        deliveryDate: (map['deliveryDate'] as Timestamp).toDate(),
        discount: (map['discount'] is int)
            ? (map['discount'] as int).toDouble()
            : map['discount'] as double,
        totalPrice: (map['totalPrice'] is int)
            ? (map['totalPrice'] as int).toDouble()
            : map['totalPrice'] as double,
        status: getStatusFromInt(map['status'] as int),
        isDelivery: map['isDelivery'] as bool,
        isPerMajor: map['isPerMajor'] as bool,
        isActive: map['isActive'] as bool,
        products: (map['products'] as List<dynamic>)
            .map((entity) => Product.fromJson(entity)).toList()
    );
  }
}