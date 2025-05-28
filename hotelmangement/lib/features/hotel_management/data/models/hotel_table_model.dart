import 'package:hotelmangement/features/hotel_management/domain/entities/table.dart';

class HotelTableModel extends Table {
  const HotelTableModel({
    required super.id,
    required super.hotelId,
    required super.space,
    required super.floor,
    required super.tableNumber,
    required super.available,
  });

  factory HotelTableModel.fromJson(Map<String, dynamic> json) {
    return HotelTableModel(
      id: json['id'] as String,
      space: json['space'] as int,
      floor: json['floor'] as String,
      tableNumber: json['tablenumber'] as String,
      available: json['available'] as bool,
      hotelId: json['hotel_id'] as String,
    );
  }
}
