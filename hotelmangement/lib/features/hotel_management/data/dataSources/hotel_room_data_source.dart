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
  Future<void> deleteRoom(String roomId, String hotelId);
  Future<RoomImageModel> deleteRoomImage(String imageId);
  Future<List<RoomImageModel>> getRoomImages(String roomId);
  Future<List<HotelRoomModel>> getRooms(String hotelId);
  Future<bool> isImageExists(String imageId, String roomId);
  Future<HotelRoomModel> updateRoom(
    String roomId,
    String hotelId,
    String? roomNumber,
    String? description,
    int? space,
    String? floor,
    double? price,
    bool? available,
  );
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
  Future<void> deleteRoom(roomId, String hotelId) async {
    final response = await client
        .from("hotel_room")
        .delete()
        .eq("id", roomId)
        .eq("hotel_id", hotelId);
    if (response != null) {
      throw Exception("Failed to delete hotel room: ${response.toString()}");
    }
  }

  @override
  Future<RoomImageModel> deleteRoomImage(String imageId) async {
    final response =
        await client.from("room_image").delete().eq("id", imageId).select();
    if (response.isEmpty) {
      throw Exception("Failed to delete hotel image");
    } else {
      final data = response.first;
      return RoomImageModel.fromJson(data);
    }
  }

  @override
  Future<List<RoomImageModel>> getRoomImages(String roomId) async {
    final response =
        await client.from("room_image").select().eq("room_id", roomId);

    if (response.isEmpty) {
      throw Exception("Room images not found");
    } else {
      return response
          .map<RoomImageModel>((data) => RoomImageModel.fromJson(data))
          .toList();
    }
  }

  @override
  Future<List<HotelRoomModel>> getRooms(String hotelId) async {
    final response =
        await client.from("hotel_room").select().eq("hotel_id", hotelId);

    if (response.isEmpty) {
      throw Exception("Rooms not found");
    } else {
      return response
          .map<HotelRoomModel>((data) => HotelRoomModel.fromJson(data))
          .toList();
    }
  }

  @override
  Future<bool> isImageExists(String imageId, String roomId) async {
    try {
      final response = await client
          .from("room_image")
          .select()
          .eq("id", imageId)
          .eq("room_id", roomId)
          .single();
      if (response.isEmpty) {
        return false;
      }
      return true;
    } catch (e) {
      print("Error checking if room image exists: $e");
      return false;
    }
  }
  
  @override
  Future<HotelRoomModel> updateRoom(String roomId, String hotelId, String? roomNumber, String? description, int? space, String? floor, double? price, bool? available) {
    final Map<String, dynamic> updates = {};
    if (roomNumber != null) updates["room_number"] = roomNumber;
    if (description != null) updates["description"] = description;
    if (space != null) updates["space"] = space;
    if (floor != null) updates["floor"] = floor;
    if (price != null) updates["price"] = price;
    if (available != null) updates["available"] = available;
    if (updates.isEmpty) {
      throw Exception("No fields to update");
    }
    return client.from("hotel_room").update(updates).eq("id", roomId).eq("hotel_id", hotelId).select().then((response) {
      if (response.isEmpty) {
        throw Exception("Failed to update hotel room");
      } else {
        final data = response.first;
        return HotelRoomModel.fromJson(data);
      }
    });
  }
}
