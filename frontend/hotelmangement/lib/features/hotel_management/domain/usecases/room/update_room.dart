import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:hotelmangement/core/error/failure.dart';
import 'package:hotelmangement/core/usecase.dart';
import 'package:hotelmangement/features/hotel_management/domain/entities/room.dart';

// class UpdateRoom extends Usecase<Room, Params> {
//   @override
//   Future<Either<Failure, Room>> call(Params params) {
//   }
// }

class Params extends Equatable {
  final String managerId;
  final String hotelId;
  final String roomId;
  final String? roomNumber;
  final String? description;
  final String? space;
  final String? floor;
  final double? price;

  const Params(
      {required this.managerId,
      required this.hotelId,
      required this.roomId,
      required this.roomNumber,
      required this.description,
      required this.space,
      required this.floor,
      required this.price});
  @override
  List<Object?> get props => [
        managerId,
        hotelId,
        roomId,
        roomNumber,
        description,
        space,
        floor,
        price
      ];
}
