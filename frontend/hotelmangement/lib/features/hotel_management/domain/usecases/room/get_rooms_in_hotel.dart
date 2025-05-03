import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:hotelmangement/core/error/failure.dart';
import 'package:hotelmangement/core/usecase.dart';
import 'package:hotelmangement/features/hotel_management/domain/entities/room.dart';
import 'package:hotelmangement/features/hotel_management/domain/repositories/hotel_room_repository.dart';
import 'package:hotelmangement/features/hotel_management/domain/usecases/validation/hotel_authorize.dart'
    as ha;

class GetRoomsInHotel extends Usecase<List<Room>, Params> {
  final HotelRoomRepository repository;
  final ha.HotelAuthorize hotelAuthorize;

  GetRoomsInHotel({
    required this.repository,
    required this.hotelAuthorize,
  });

  @override
  Future<Either<Failure, List<Room>>> call(Params params) async {
    final failureOrHotel = await hotelAuthorize(
        ha.Params(hotelId: params.hotelId, managerId: params.managerId));

    if (failureOrHotel.isLeft()) {
      return Left(failureOrHotel.fold((l) => l, (r) => UnAuthorizedFailure()));
    }

    return repository.getRooms(
      hotelId: params.hotelId,
    );
  }
}

class Params extends Equatable {
  final String managerId;
  final String hotelId;

  const Params({
    required this.managerId,
    required this.hotelId,
  });

  @override
  List<Object?> get props => [
        managerId,
        hotelId,
      ];
}
