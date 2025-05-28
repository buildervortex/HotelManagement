import 'package:hotelmangement/features/hotel_management/data/models/hotel_food_image_model.dart';
import 'package:hotelmangement/features/hotel_management/data/models/hotel_food_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class HotelFoodDataSource {
  Future<HotelFoodImageModel> addFoodImage(
      String foodId, String localImagePath);
  Future<HotelFoodModel> createFood(
      String hotelId, String name, double price, bool available, String type);
  Future<void> deleteFood(String foodId);
  Future<HotelFoodImageModel> deleteFoodImage(String imageId, String foodId);
  Future<List<HotelFoodImageModel>> getFoodImages(String foodId);
  Future<List<HotelFoodModel>> getFoods(String hotelId);
  Future<bool> isImageExists(String imageId, String foodId);
  Future<HotelFoodModel> updateFood(String foodId, String? name, double? price,
      bool? available, String? type);
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

  @override
  Future<HotelFoodImageModel> deleteFoodImage(
      String imageId, String foodId) async {
    final response =
        await client.from("food_image").delete().eq("id", imageId).select();
    if (response.isEmpty) {
      throw Exception("Failed to delete food image");
    } else {
      final data = response.first;
      return HotelFoodImageModel.fromJson(data);
    }
  }

  @override
  Future<List<HotelFoodImageModel>> getFoodImages(String foodId) async {
    final response =
        await client.from("food_image").select().eq("food_id", foodId);

    if (response.isEmpty) {
      throw Exception("Food images not found");
    } else {
      return response
          .map<HotelFoodImageModel>(
              (data) => HotelFoodImageModel.fromJson(data))
          .toList();
    }
  }

  @override
  Future<List<HotelFoodModel>> getFoods(String hotelId) async {
    final response =
        await client.from("hotel_food").select().eq("hotel_id", hotelId);

    if (response.isEmpty) {
      throw Exception("Foods not found");
    } else {
      return response
          .map<HotelFoodModel>((data) => HotelFoodModel.fromJson(data))
          .toList();
    }
  }

  @override
  Future<bool> isImageExists(String imageId, String foodId) async {
    try {
      final response = await client
          .from("food_image")
          .select()
          .eq("id", imageId)
          .eq("food_id", foodId)
          .single();
      if (response.isEmpty) {
        return false;
      }
      return true;
    } catch (e) {
      print("Error checking if food image exists: $e");
      return false;
    }
  }
  
  @override
  Future<HotelFoodModel> updateFood(String foodId, String? name, double? price, bool? available, String? type) {
    final Map<String, dynamic> updates = {};
    if (name != null) updates["name"] = name;
    if (price != null) updates["price"] = price;
    if (available != null) updates["available"] = available;
    if (type != null) updates["type"] = type;
    if (updates.isEmpty) {
      throw Exception("No fields to update");
    }
    return client.from("hotel_food").update(updates).eq("id", foodId).select().then((response) {
      if (response.isEmpty) {
        throw Exception("Failed to update hotel food");
      } else {
        final data = response.first;
        return HotelFoodModel.fromJson(data);
      }
    });
    
  }
}
