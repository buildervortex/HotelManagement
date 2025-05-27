import 'package:hotelmangement/features/hotel_management/data/models/hotel_image_model.dart';
import 'package:hotelmangement/features/hotel_management/data/models/hotel_phone_number_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class HotelManagementDataSource {
  Future<HotelImageModel> addHotelImage(
      String uploadedImagePath, String hotelId);

  Future<HotelPhoneNumberModel> addHotelPhoneNumber(
      String hotelId, String phoneNumber, String role);
  
  // Future<HotelPhoneNumberModel> addHotelPhoneNumber(
  //     String hotelId, String phoneNumber, String role);
  
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
}
