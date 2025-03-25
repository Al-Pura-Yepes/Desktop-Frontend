import 'package:al_pura_frontend/feature/shared/domain/model/i_entity.dart';

class User extends IEntity {
  @override
  final String id;
  final String fullName;
  final int phoneNumber;

  User({required this.id, required this.fullName, required this.phoneNumber});

  Map<String, dynamic> toMap() {
    return {"fullName": fullName, "phoneNumber": phoneNumber};
  }

  factory User.fromMap(Map<String, dynamic> map, String id) {
    return User(
        id: id,
        fullName: map['fullName'] as String,
        phoneNumber: map['phoneNumber'] as int);
  }
}
