import 'package:hotelmangement/features/hotel_management/data/models/hotel_food_image_model.dart';
import 'package:hotelmangement/features/hotel_management/data/models/hotel_food_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class HotelFoodDataSource {
  Future<HotelFoodImageModel> addFoodImage(
      String foodId, String localImagePath);
  Future<HotelFoodModel> createFood(
      String hotelId, String name, double price, bool available, String type);
  Future<void> deleteFood(String foodId);
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

  @override
  Future<HotelFoodModel> createFood(String hotelId, String name, double price,
      bool available, String type) async {
    final response = await client.from("hotel_food").insert({
      "name": name,
      "price": price,
      "available": available,
      "type": type,
      "hotel_id": hotelId,
    }).select();
    if (response.isEmpty) {
      throw Exception("Failed to create food");
    } else {
      final data = response.first;
      return HotelFoodModel.fromJson(data);
    }
  }

  @override
  Future<void> deleteFood(String foodId) async {
    final response = await client.from("hotel_food").delete().eq("id", foodId);
    if (response != null) {
      throw Exception("Failed to delete hotel food: ${response.toString()}");
    }
  }
}
