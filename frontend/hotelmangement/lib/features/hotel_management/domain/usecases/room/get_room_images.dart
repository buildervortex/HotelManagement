import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:hotelmangement/core/error/failure.dart';
import 'package:hotelmangement/core/usecase.dart';
import 'package:hotelmangement/features/hotel_management/domain/entities/room_image.dart';
import 'package:hotelmangement/features/hotel_management/domain/repositories/hotel_room_repository.dart';

class GetRoomImages extends Usecase<List<RoomImage>, Params> {
  final HotelRoomRepository repository;

  GetRoomImages({required this.repository});

  @override
  Future<Either<Failure, List<RoomImage>>> call(Params params) async {
    return await repository.getRoomImages(params.roomId);
  }
}

class Params extends Equatable {
  final String roomId;

  const Params({required this.roomId});

  @override
  List<Object?> get props => [roomId];
}
