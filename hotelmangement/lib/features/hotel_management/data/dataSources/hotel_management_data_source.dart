import 'package:hotelmangement/features/hotel_management/data/models/hotel_image_model.dart';
import 'package:hotelmangement/features/hotel_management/data/models/hotel_model.dart';
import 'package:hotelmangement/features/hotel_management/data/models/hotel_phone_number_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class HotelManagementDataSource {
  Future<HotelImageModel> addHotelImage(
      String uploadedImagePath, String hotelId);

  Future<HotelPhoneNumberModel> addHotelPhoneNumber(
      String hotelId, String phoneNumber, String role);

  Future<HotelModel> createHotel(String name, String address, double longitude,
      double latitude, String managerId);

  Future<void> deleteHotel(String hotelId);
  Future<HotelImageModel> deleteHotelImage(String hotelImageId);
  Future<void> deleteHotelPhoneNumber(String phoneNumberId);
  Future<HotelModel> getHotel(String hotelId);
  Future<List<HotelImageModel>> getHotelImages(String hotelId);
  Future<List<HotelPhoneNumberModel>> getHotelPhoneNumbers(String hotelId);
  Future<bool> isImageExists(String imageId, String hotelId);
  Future<HotelModel> updateHotel(String hotelId, String? name, String? address,
      double? longitude, double? latitude, String? mainImage);
  Future<List<HotelModel>> getHotels(String managerId);
}

class HotelManagementDataSourceImpl implements HotelManagementDataSource {
  final SupabaseClient client;

  HotelManagementDataSourceImpl({required this.client});

  @override
  Future<HotelImageModel> addHotelImage(
      String uploadedImagePath, String hotelId) async {
    final response = await client
        .from("hotel_image")
        .insert({"hotel_id": hotelId, "file": uploadedImagePath}).select();
    if (response.isEmpty) {
      throw Exception("Failed to add hotel image");
    } else {
      final data = response.first;
      return HotelImageModel.fromJson(data);
    }
  }

  @override
  Future<HotelPhoneNumberModel> addHotelPhoneNumber(
      String hotelId, String phoneNumber, String role) async {
    final response = await client.from("hotel_phone_number").insert(
        {"hotel_id": hotelId, "number": phoneNumber, "role": role}).select();

    if (response.isEmpty) {
      throw Exception("Failed to add hotel phone number");
    } else {
      final data = response.first;
      return HotelPhoneNumberModel.fromJson(data);
    }
  }

  @override
  Future<HotelModel> createHotel(String name, String address, double longitude,
      double latitude, String managerId) async {
    final response = await client.from("hotel").insert({
      "name": name,
      "address": address,
      "longitude": longitude,
      "latitude": latitude,
      "manager_id": managerId
    }).select();
    if (response.isEmpty) {
      throw Exception("Failed to create hotel");
    } else {
      final data = response.first;
      return HotelModel.fromJson(data);
    }
  }

  @override
  Future<void> deleteHotel(String hotelId) async {
    final response = await client.from("hotel").delete().eq("id", hotelId);
    if (response != null) {
      throw Exception("Failed to delete hotel: ${response.toString()}");
    }
  }

  @override
  Future<HotelImageModel> deleteHotelImage(String hotelImageId) async {
    final response = await client
        .from("hotel_image")
        .delete()
        .eq("id", hotelImageId)
        .select();
    if (response.isEmpty) {
      throw Exception("Failed to delete hotel image");
    } else {
      final data = response.first;
      return HotelImageModel.fromJson(data);
    }
  }

  @override
  Future<void> deleteHotelPhoneNumber(String phoneNumberId) async {
    final response = await client
        .from("hotel_phone_number")
        .delete()
        .eq("id", phoneNumberId);

    if (response != null) {
      throw Exception("Failed to delete hotel: ${response.toString()}");
    }
  }

  @override
  Future<HotelModel> getHotel(String hotelId) async {
    final response =
        await client.from("hotel").select().eq("id", hotelId).single();

    if (response.isEmpty) {
      throw Exception("Hotel not found");
    } else {
      return HotelModel.fromJson(response);
    }
  }

  @override
  Future<List<HotelImageModel>> getHotelImages(String hotelId) async {
    final response =
        await client.from("hotel_image").select().eq("hotel_id", hotelId);

    if (response.isEmpty) {
      throw Exception("Hotel images not found");
    } else {
      return response
          .map<HotelImageModel>((data) => HotelImageModel.fromJson(data))
          .toList();
    }
  }

  @override
  Future<List<HotelPhoneNumberModel>> getHotelPhoneNumbers(
      String hotelId) async {
    final response = await client
        .from("hotel_phone_number")
        .select()
        .eq("hotel_id", hotelId);

    if (response.isEmpty) {
      throw Exception("Hotel phone numbers not found");
    } else {
      return response
          .map<HotelPhoneNumberModel>(
              (data) => HotelPhoneNumberModel.fromJson(data))
          .toList();
    }
  }

  @override
  Future<bool> isImageExists(String imageId, String hotelId) async {
    try {
      final response = await client
          .from("hotel_image")
          .select()
          .eq("id", imageId)
          .eq("hotel_id", hotelId)
          .single();
      if (response.isEmpty) {
        return false;
      }
      return true;
    } catch (e) {
      print("Error checking if image exists: $e");
      return false;
    }
  }

  @override
  Future<HotelModel> updateHotel(String hotelId, String? name, String? address,
      double? longitude, double? latitude, String? mainImage) async {
    final Map<String, dynamic> updates = {};
    if (name != null) updates["name"] = name;
    if (address != null) updates["address"] = address;
    if (longitude != null) updates["longitude"] = longitude;
    if (latitude != null) updates["latitude"] = latitude;
    if (mainImage != null) updates["mainimage"] = mainImage;
    if (updates.isEmpty) {
      throw Exception("No fields to update");
    }

    final response =
        await client.from("hotel").update(updates).eq("id", hotelId).select();
    if (response.isEmpty) {
      throw Exception("Failed to create hotel");
    } else {
      final data = response.first;
      return HotelModel.fromJson(data);
    }
  }

  @override
  Future<List<HotelModel>> getHotels(String managerId) async {
    final response =
        await client.from("hotel").select().eq("manager_id", managerId);

    if (response.isEmpty) {
      throw Exception("Hotel not found");
    } else {
      return response.map((hotel) => HotelModel.fromJson(hotel)).toList();
    }
  }
}
