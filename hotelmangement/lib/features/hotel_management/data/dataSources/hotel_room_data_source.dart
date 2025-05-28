import 'package:hotelmangement/features/hotel_management/data/models/room_image_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class HotelRoomDataSource {
  Future<RoomImageModel> addRoomImage(String uploadedImagePath, String roomId);
}

class HotelRoomDataSourceImpl implements HotelRoomDataSource {
  final SupabaseClient client;

  HotelRoomDataSourceImpl({required this.client});

  @override
  Future<RoomImageModel> addRoomImage(
      String uploadedImagePath, String roomId) async {
    final response = await client
        .from("room_image")
        .insert({"room_id": roomId, "file": uploadedImagePath}).select();

    if (response.isEmpty) {
      throw Exception("Failed to add room image");
    } else {
      final data = response.first;
      return RoomImageModel.fromJson(data);
    }
  }
}
