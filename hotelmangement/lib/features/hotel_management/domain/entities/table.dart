import 'package:equatable/equatable.dart';

class Table extends Equatable {
  final String id;
  final String hotelId;
  final int space;
  final String floor;
  final String tableNumber;

  const Table({
    required this.id,
    required this.hotelId,
    required this.space,
    required this.floor,
    required this.tableNumber,
  });

  @override
  List<Object?> get props => [
        id,
        hotelId,
        space,
        floor,
        tableNumber,
      ];
}
