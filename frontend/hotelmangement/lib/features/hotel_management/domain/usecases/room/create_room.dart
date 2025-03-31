import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:hotelmangement/core/error/failure.dart';
import 'package:hotelmangement/core/usecase.dart';
import 'package:hotelmangement/features/hotel_management/domain/entities/room.dart';
import 'package:hotelmangement/features/hotel_management/domain/repositories/hotel_room_repository.dart';

class CreateRoom extends Usecase<Room, Params> {
  final HotelRoomRepository repository;

  CreateRoom(this.repository);

  @override
  Future<Either<Failure, Room>> call(Params params) {
    return repository.createRoom(
      hotelId: params.hotelId,
      roomNumber: params.roomNumber,
      description: params.description,
      space: params.space,
      floor: params.floor,
      price: params.price,
    );
  }
}

class Params extends Equatable {
  final String hotelId;
  final String roomNumber;
  final String description;
  final String space;
  final String floor;
  final double price;

  const Params({
    required this.hotelId,
    required this.roomNumber,
    required this.description,
    required this.space,
    required this.floor,
    required this.price,
  });

  @override
  List<Object?> get props => [
        hotelId,
        roomNumber,
        description,
        space,
        floor,
        price,
      ];
}
