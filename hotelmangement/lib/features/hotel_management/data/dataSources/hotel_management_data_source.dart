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
}
