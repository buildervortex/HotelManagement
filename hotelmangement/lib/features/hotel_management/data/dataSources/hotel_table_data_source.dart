import 'package:hotelmangement/features/hotel_management/data/models/hotel_table_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class HotelTableDataSource {
  Future<HotelTableModel> createTable(String hotelId, String tableNumber,
      int space, String floor, bool available);

  Future<void> deleteTable(String tableId, String hotelId);
  Future<List<HotelTableModel>> getTables(String hotelId);
  Future<HotelTableModel> updateTable(String tableId, String hotelId,
      String? tableNumber, int? space, String? floor, bool? available);
}

class HotelTableDataSourceImpl implements HotelTableDataSource {
  final SupabaseClient client;

  HotelTableDataSourceImpl({required this.client});

  @override
  Future<HotelTableModel> createTable(String hotelId, String tableNumber,
      int space, String floor, bool available) async {
    final response = await client.from("hotel_table").insert({
      "hotel_id": hotelId,
      "tablenumber": tableNumber,
      "space": space,
      "floor": floor,
      "available": available,
    }).select();
    if (response.isEmpty) {
      throw Exception("Failed to create table");
    } else {
      final data = response.first;
      return HotelTableModel.fromJson(data);
    }
  }

  @override
  Future<void> deleteTable(String tableId, String hotelId) async {
    final response = await client
        .from("hotel_table")
        .delete()
        .eq("id", tableId)
        .eq("hotel_id", hotelId);
    if (response != null) {
      throw Exception("Failed to delete table: ${response.toString()}");
    }
  }

  @override
  Future<List<HotelTableModel>> getTables(String hotelId) async {
    final response =
        await client.from("hotel_table").select().eq("hotel_id", hotelId);

    if (response.isEmpty) {
      throw Exception("Tables not found");
    } else {
      return response
          .map<HotelTableModel>((data) => HotelTableModel.fromJson(data))
          .toList();
    }
  }
  
  @override
  Future<HotelTableModel> updateTable(String tableId, String hotelId, String? tableNumber, int? space, String? floor, bool? available) {
    final Map<String, dynamic> updates = {};
    if (tableNumber != null) updates["tablenumber"] = tableNumber;
    if (space != null) updates["space"] = space;
    if (floor != null) updates["floor"] = floor;
    if (available != null) updates["available"] = available;
    if (updates.isEmpty) {
      throw Exception("No fields to update");
    }
    return client.from("hotel_table").update(updates).eq("id", tableId).eq("hotel_id", hotelId).select().then((response) {
      if (response.isEmpty) {
        throw Exception("Failed to update hotel table");
      } else {
        final data = response.first;
        return HotelTableModel.fromJson(data);
      }
    });
    
  }
}
