import 'package:equatable/equatable.dart';
import 'package:hotelmangement/features/hotel_management/domain/entities/room_image.dart';

class Room extends Equatable {
  final String id;
  final String hotelId;
  final String roomNumber;
  final String description;
  final int space;
  final String floor;
  final double price;
  final bool available;
  final List<RoomImage> images;

  const Room({
    required this.id,
    required this.hotelId,
    required this.roomNumber,
    required this.description,
    required this.space,
    required this.floor,
    required this.price,
    required this.available,
    this.images = const [],
  });

  @override
  List<Object?> get props => [
        id,
        hotelId,
        roomNumber,
        description,
        space,
        floor,
        price,
        available,
        images,
      ];

  Room copyWith({
    String? id,
    String? hotelId,
    String? roomNumber,
    String? description,
    int? space,
    String? floor,
    double? price,
    bool? available,
    List<RoomImage>? images,
  }) {
    return Room(
      id: id ?? this.id,
      hotelId: hotelId ?? this.hotelId,
      roomNumber: roomNumber ?? this.roomNumber,
      description: description ?? this.description,
      space: space ?? this.space,
      floor: floor ?? this.floor,
      price: price ?? this.price,
      available: available ?? this.available,
      images: images ?? this.images,
    );
  }
}
