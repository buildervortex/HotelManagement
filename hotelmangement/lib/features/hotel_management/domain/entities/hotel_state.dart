import 'package:equatable/equatable.dart';

class HotelState extends Equatable {
  final String id;
  final String name;
  final int foodCount;
  final int roomCount;
  final int tableCount;

  const HotelState(
      {required this.id,
      required this.name,
      required this.foodCount,
      required this.roomCount,
      required this.tableCount});
  @override
  List<Object?> get props => [
        id,
        name,
        foodCount,
        roomCount,
        tableCount,
      ];

  HotelState copyWith({
    String? id,
    String? name,
    int? foodCount,
    int? roomCount,
    int? tableCount,
  }) {
    return HotelState(
        id: id ?? this.id,
        name: name ?? this.name,
        foodCount: foodCount ?? this.foodCount,
        roomCount: roomCount ?? this.roomCount,
        tableCount: tableCount ?? this.tableCount);
  }
}
