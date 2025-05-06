import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:hotelmangement/core/error/failure.dart';
import 'package:hotelmangement/core/usecase.dart';
import 'package:hotelmangement/features/hotel_management/domain/repositories/hotel_room_repository.dart';
import 'package:hotelmangement/features/hotel_management/domain/usecases/validation/hotel_authorize.dart'
    as ha;

class DeleteRoom extends Usecase<void, Params> {
  final HotelRoomRepository repository;
  final ha.HotelAuthorize hotelAuthorize;

  DeleteRoom({
    required this.repository,
    required this.hotelAuthorize,
  });

  @override
  Future<Either<Failure, void>> call(Params params) async {
    final failureOrHotel = await hotelAuthorize(
        ha.Params(hotelId: params.hotelId, managerId: params.managerId));

    if (failureOrHotel.isLeft()) {
      return Left(failureOrHotel.fold((l) => l, (r) => UnAuthorizedFailure()));
    }

    return repository.deleteRoom(
      roomId: params.roomId,
      hotelId: params.hotelId,
    );
  }
}

class Params extends Equatable {
  final String managerId;
  final String hotelId;
  final String roomId;

  const Params({
    required this.managerId,
    required this.hotelId,
    required this.roomId,
  });

  @override
  List<Object?> get props => [managerId, hotelId, roomId];
}
