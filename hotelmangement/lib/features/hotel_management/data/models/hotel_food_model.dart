import 'package:hotelmangement/features/hotel_management/domain/entities/food.dart';

class HotelFoodModel extends Food {
  const HotelFoodModel(
      {required super.id,
      required super.hotelId,
      required super.name,
      required super.price,
      required super.availability,
      required super.type});

  factory HotelFoodModel.fromJson(Map<String, dynamic> json) {
    return HotelFoodModel(
      id: json['id'] as String,
      name: json['name'] as String,
      price: (json['price'] as num).toDouble(),
      availability: json['available'] as bool,
      type: json['type'] as String,
      hotelId: json['hotel_id'] as String,
    );
  }
}
