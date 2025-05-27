import 'package:equatable/equatable.dart';

class Hotel extends Equatable {
  final String id;
  final String managerId;
  final String name;
  final String address;
  final double longitude;
  final double latitude;
  final String? mainImage;
  final DateTime? createdAt;

  const Hotel({
    required this.id,
    required this.managerId,
    required this.name,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.createdAt,
    this.mainImage,
  });

  @override
  List<Object?> get props =>
      [id, managerId, name, address, longitude, latitude, mainImage, createdAt];
}
