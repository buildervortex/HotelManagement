import 'package:hotelmangement/features/hotel_management/domain/entities/hotel_state.dart';

class HotelStateModel extends HotelState {
  const HotelStateModel(
      {required super.id,
      required super.name,
      required super.foodCount,
      required super.roomCount,
      required super.tableCount});

  factory HotelStateModel.fromJson(Map<String, dynamic> json) {
    return HotelStateModel(
      id: json['id'] as String,
      name: json['name'] as String,
      foodCount: (json['food_count'] as num).toInt(),
      roomCount: (json['room_count'] as num).toInt(),
      tableCount: (json['table_count'] as num).toInt(),
    );
  }
}
