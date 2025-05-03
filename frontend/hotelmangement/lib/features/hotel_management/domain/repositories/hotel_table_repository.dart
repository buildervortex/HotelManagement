import 'package:hotelmangement/features/hotel_management/domain/entities/table.dart';

abstract class HotelTableRepository {
  Future<void> createTable({
    required String hotelId,
    required String tableNumber,
    required String space,
    required String floor,
  });

  Future<void> updateTable({
    required String tableId,
    required String hotelId,
    String? tableNumber,
    String? description,
    String? space,
    String? floor,
  });

  Future<void> deleteTable({
    required String tableId,
    required String hotelId,
  });

  Future<List<Table>> getTables({
    required String hotelId,
  });
}
