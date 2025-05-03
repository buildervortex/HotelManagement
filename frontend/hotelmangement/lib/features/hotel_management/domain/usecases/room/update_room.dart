import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:hotelmangement/core/error/failure.dart';
import 'package:hotelmangement/core/usecase.dart';
import 'package:hotelmangement/features/hotel_management/domain/entities/room.dart';
import 'package:hotelmangement/features/hotel_management/domain/repositories/hotel_room_repository.dart';
import 'package:hotelmangement/features/hotel_management/domain/usecases/validation/hotel_authorize.dart'
    as ha;

class UpdateRoom extends Usecase<Room, Params> {
  final HotelRoomRepository repository;
  final ha.HotelAuthorize hotelAuthorize;

  UpdateRoom(this.repository, this.hotelAuthorize);

  @override
  Future<Either<Failure, Room>> call(Params params) async {
    final failureOrHotel = await hotelAuthorize(
        ha.Params(hotelId: params.hotelId, managerId: params.managerId));

    if (failureOrHotel.isLeft()) {
      return Left(failureOrHotel.fold((l) => l, (r) => UnAuthorizedFailure()));
    }

    return repository.updateRoom(
      roomId: params.roomId,
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
