import 'package:equatable/equatable.dart';
import 'package:hotelmangement/features/hotel_management/domain/entities/hotel_image.dart';
import 'package:hotelmangement/features/hotel_management/domain/entities/hotel_phone_number.dart';

class Hotel extends Equatable {
  final String id;
  final String managerId;
  final String name;
  final String address;
  final double longitude;
  final double latitude;
  final String? mainImage;
  final DateTime? createdAt;
  final List<HotelImage> images;
  final List<HotelPhoneNumber> phoneNumbers;

  const Hotel({
    required this.id,
    required this.managerId,
    required this.name,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.createdAt,
    this.mainImage,
    this.images = const [],
    this.phoneNumbers = const [],
  });

  @override
  List<Object?> get props => [
        id,
        managerId,
        name,
        address,
        longitude,
        latitude,
        mainImage,
        createdAt,
        images,
        phoneNumbers
      ];
}
