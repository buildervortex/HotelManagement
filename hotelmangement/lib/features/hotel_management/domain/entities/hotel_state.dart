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
}
