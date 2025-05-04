import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:hotelmangement/core/authorized_usecase.dart';
import 'package:hotelmangement/core/error/failure.dart';
import 'package:hotelmangement/features/hotel_management/domain/repositories/hotel_room_repository.dart';

class DeleteRoomImage extends AuthorizedUsecase<void, Params> {
  final HotelRoomRepository repository;

  DeleteRoomImage({required this.repository, required super.hotelAuthorize});
  @override
  Future<Either<Failure, void>> call(Params params) async {
    return super.executeAuthorized(params.managerId, params.hotelId, () async {
      if (!(await repository.isImageExists(params.imageId, params.roomId))) {
        return Left(NotFound());
      }
      return repository.deleteRoomImage(params.imageId);
    });
  }
}

class Params extends Equatable {
  final String hotelId;
  final String managerId;
  final String roomId;
  final String imageId;

  const Params({
    required this.hotelId,
    required this.managerId,
    required this.roomId,
    required this.imageId,
  });

  @override
  List<Object?> get props => [hotelId, managerId, roomId, imageId];
}
