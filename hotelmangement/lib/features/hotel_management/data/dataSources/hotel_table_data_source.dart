import 'package:hotelmangement/features/hotel_management/data/models/hotel_table_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class HotelTableDataSource {
  Future<HotelTableModel> createTable(String hotelId, String tableNumber,
      int space, String floor, bool available);

  Future<void> deleteTable(String tableId, String hotelId);
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
}
