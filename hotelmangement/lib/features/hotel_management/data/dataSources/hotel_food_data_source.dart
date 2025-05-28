import 'package:hotelmangement/features/hotel_management/data/models/hotel_food_image_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class HotelFoodDataSource {
  Future<HotelFoodImageModel> addFoodImage(
      String foodId, String localImagePath);
}

class HotelFoodDataSourceImpl implements HotelFoodDataSource {
  final SupabaseClient client;

  HotelFoodDataSourceImpl({required this.client});

  @override
  Future<HotelFoodImageModel> addFoodImage(
      String foodId, String imagePath) async {
    final response = await client
        .from("food_image")
        .insert({"food_id": foodId, "file": imagePath}).select();

    if (response.isEmpty) {
      throw Exception("Failed to add room image");
    } else {
      final data = response.first;
      return HotelFoodImageModel.fromJson(data);
    }
  }
}
