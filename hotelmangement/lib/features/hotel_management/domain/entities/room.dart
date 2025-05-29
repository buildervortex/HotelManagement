import 'package:equatable/equatable.dart';

class Room extends Equatable {
  final String id;
  final String hotelId;
  final String roomNumber;
  final String description;
  final int space;
  final String floor;
  final double price;
  final bool available;

  const Room({
    required this.id,
    required this.hotelId,
    required this.roomNumber,
    required this.description,
    required this.space,
    required this.floor,
    required this.price,
    required this.available,
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
  }) {
    return Room(
        id: id ?? this.id,
        hotelId: hotelId ?? this.hotelId,
        roomNumber: roomNumber ?? this.roomNumber,
        description: description ?? this.description,
        space: space ?? this.space,
        floor: floor ?? this.floor,
        price: price ?? this.price,
        available: available ?? this.available);
  }
}
