import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:hotelmangement/core/authorized_usecase.dart';
import 'package:hotelmangement/core/error/failure.dart';
import 'package:hotelmangement/features/hotel_management/domain/entities/room_image.dart';
import 'package:hotelmangement/features/hotel_management/domain/repositories/hotel_room_repository.dart';

class AddRoomImage extends AuthorizedUsecase<RoomImage, Params> {
  final HotelRoomRepository repository;

  AddRoomImage({required this.repository, required super.hotelAuthorize});

  @override
  Future<Either<Failure, RoomImage>> call(Params params) async {
    return super.executeAuthorized(params.managerId, params.hotelId, () async {
      return repository.addRoomImage(
        params.roomId,
        params.localImagePath,
      );
    });
  }
}

class Params extends Equatable {
  final String hotelId;
  final String managerId;
  final String roomId;
  final String localImagePath;
  final String remoteImageSaveName;

  const Params({
    required this.hotelId,
    required this.managerId,
    required this.roomId,
    required this.localImagePath,
    required this.remoteImageSaveName,
  });

  @override
  List<Object?> get props =>
      [hotelId, managerId, roomId, localImagePath, remoteImageSaveName];
}
