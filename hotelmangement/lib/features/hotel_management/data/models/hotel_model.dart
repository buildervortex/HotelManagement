import 'package:hotelmangement/features/hotel_management/domain/entities/hotel.dart';

class HotelModel extends Hotel {
  const HotelModel({
    required super.id,
    required super.managerId,
    required super.name,
    required super.address,
    required super.latitude,
    required super.longitude,
    required super.createdAt,
    super.mainImage,
  });

  factory HotelModel.fromJson(Map<String, dynamic> json) {
    return HotelModel(
      id: json['id'] as String,
      name: json['name'] as String,
      address: json['address'] as String,
      longitude: (json['longitude'] as num).toDouble(),
      latitude: (json['latitude'] as num).toDouble(),
      managerId: json['manager_id'] as String,
      mainImage: json['mainimage'] as String?,
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'manager_id': managerId,
      'name': name,
      'address': address,
      'latitude': latitude,
      'longitude': longitude,
      'mainimage': mainImage,
      'created_at': createdAt?.toIso8601String().toString(),
    };
  }
}
