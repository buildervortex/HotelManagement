import 'package:hotelmangement/features/hotel_management/data/models/hotel_image_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class HotelManagementDataSource {
  Future<HotelImageModel> addHotelImage(
      String uploadedImagePath, String hotelId);
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
}
