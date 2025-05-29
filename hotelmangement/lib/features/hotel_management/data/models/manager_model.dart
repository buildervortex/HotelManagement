import 'package:hotelmangement/features/hotel_management/domain/entities/manager.dart';

class ManagerModel extends Manager {
  const ManagerModel(
      {required super.id,
      required super.username,
      required super.phoneNumber,
      required super.email});

  factory ManagerModel.fromJson(Map<String, dynamic> json) {
    return ManagerModel(
      id: json['id'] as String,
      username: json['username'] as String,
      phoneNumber: json['phonenumber'] as String,
      email: json['email'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'phone_number': phoneNumber,
    };
  }
}
