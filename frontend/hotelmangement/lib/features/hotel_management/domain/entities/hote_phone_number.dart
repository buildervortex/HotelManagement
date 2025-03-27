import 'package:equatable/equatable.dart';

class HotelPhoneNumber extends Equatable {
  final String id;
  final String role;
  final String phoneNumber;
  final String hotelId;

  const HotelPhoneNumber({
    required this.id,
    required this.role,
    required this.phoneNumber,
    required this.hotelId,
  });
  @override
  List<Object?> get props => [id, role, phoneNumber, hotelId];
}
