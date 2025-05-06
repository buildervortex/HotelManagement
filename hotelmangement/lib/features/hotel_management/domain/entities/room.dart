import 'package:equatable/equatable.dart';

class Room extends Equatable {
  final String id;
  final String hotelId;
  final String roomNumber;
  final String description;
  final String space;
  final String floor;
  final double price;

  const Room({
    required this.id,
    required this.hotelId,
    required this.roomNumber,
    required this.description,
    required this.space,
    required this.floor,
    required this.price,
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
      ];
}
