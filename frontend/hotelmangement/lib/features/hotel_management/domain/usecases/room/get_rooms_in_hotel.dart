import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:hotelmangement/core/error/failure.dart';
import 'package:hotelmangement/core/usecase.dart';
import 'package:hotelmangement/features/hotel_management/domain/entities/room.dart';
import 'package:hotelmangement/features/hotel_management/domain/repositories/hotel_room_repository.dart';

class GetRoomsInHotel extends Usecase<List<Room>, Params> {
  final HotelRoomRepository repository;

  GetRoomsInHotel({
    required this.repository,
  });

  @override
  Future<Either<Failure, List<Room>>> call(Params params) async {
    return repository.getRooms(
      hotelId: params.hotelId,
    );
  }
}

class Params extends Equatable {
  final String hotelId;

  const Params({
    required this.hotelId,
  });

  @override
  List<Object?> get props => [
        hotelId,
      ];
}
