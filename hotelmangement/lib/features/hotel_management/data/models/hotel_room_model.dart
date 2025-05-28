import 'package:hotelmangement/features/hotel_management/domain/entities/room.dart';

class HotelRoomModel extends Room {
  const HotelRoomModel({
    required super.id,
    required super.hotelId,
    required super.roomNumber,
    required super.description,
    required super.space,
    required super.floor,
    required super.price,
    required super.available,
  });

  factory HotelRoomModel.fromJson(Map<String, dynamic> json) {
    return HotelRoomModel(
      id: json['id'] as String,
      roomNumber: json['room_number'] as String,
      description: json['description'] as String,
      space: json['space'] as int,
      floor: json['floor'] as String,
      price: (json['price'] as num).toDouble(),
      available: json['available'] as bool,
      hotelId: json['hotel_id'] as String,
    );
  }
}
