import 'package:hotelmangement/features/hotel_management/domain/entities/food_image.dart';

class HotelFoodImageModel extends FoodImage {
  const HotelFoodImageModel(
      {required super.foodId, required super.id, required super.imagePath});

  factory HotelFoodImageModel.fromJson(Map<String, dynamic> json) {
    return HotelFoodImageModel(
      id: json['id'] as String,
      foodId: json['food_id'] as String,
      imagePath: json['file'] as String,
    );
  }
}
