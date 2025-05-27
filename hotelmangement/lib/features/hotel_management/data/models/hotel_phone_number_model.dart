import 'package:hotelmangement/features/hotel_management/domain/entities/hotel_phone_number.dart';

class HotelPhoneNumberModel extends HotelPhoneNumber {
  const HotelPhoneNumberModel(
      {required super.id,
      required super.role,
      required super.phoneNumber,
      required super.hotelId});

  factory HotelPhoneNumberModel.fromJson(Map<String, dynamic> json) {
    return HotelPhoneNumberModel(
      id: json['id'] as String,
      role: json['role'] as String,
      phoneNumber: json['numer'] as String,
      hotelId: json['hotel_id'] as String,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'role': role,
      'phone_number': phoneNumber,
      'hotel_id': hotelId,
    };
  }
}
