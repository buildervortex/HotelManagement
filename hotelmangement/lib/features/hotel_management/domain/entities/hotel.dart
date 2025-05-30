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

  get location => null;

  get imageUrls => null;

  get rating => null;

  Hotel copyWith({
    String? id,
    String? managerId,
    String? name,
    String? address,
    double? longitude,
    double? latitude,
    String? mainImage,
    DateTime? createdAt,
    List<HotelImage>? images,
    List<HotelPhoneNumber>? phoneNumbers,
  }) {
    return Hotel(
      id: id ?? this.id,
      managerId: managerId ?? this.managerId,
      name: name ?? this.name,
      address: address ?? this.address,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      createdAt: createdAt ?? this.createdAt,
      images: images ?? this.images,
      phoneNumbers: phoneNumbers ?? this.phoneNumbers,
    );
  }
}
