import 'package:hotelmangement/features/hotel_management/data/models/hotel_room_model.dart';
import 'package:hotelmangement/features/hotel_management/data/models/room_image_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class HotelRoomDataSource {
  Future<RoomImageModel> addRoomImage(String uploadedImagePath, String roomId);
  Future<HotelRoomModel> createRoom(
      String hotelId,
      String roomNumber,
      String description,
      int space,
      String floor,
      double price,
      bool available);
  Future<void> deleteRoom({required String roomId, required String hotelId});
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

  @override
  Future<HotelRoomModel> createRoom(
      String hotelId,
      String roomNumber,
      String description,
      int space,
      String floor,
      double price,
      bool available) async {
    final response = await client.from("hotel_room").insert({
      "room_number": roomNumber,
      "description": description,
      "space": space,
      "floor": floor,
      "price": price,
      "available": available,
      "hotel_id": hotelId,
    }).select();
    if (response.isEmpty) {
      throw Exception("Failed to create hotel");
    } else {
      final data = response.first;
      return HotelRoomModel.fromJson(data);
    }
  }

  @override
  Future<void> deleteRoom(
      {required String roomId, required String hotelId}) async {
    final response = await client
        .from("hotel_room")
        .delete()
        .eq("id", roomId)
        .eq("hotel_id", hotelId);
    if (response != null) {
      throw Exception("Failed to delete hotel room: ${response.toString()}");
    }
  }
}
