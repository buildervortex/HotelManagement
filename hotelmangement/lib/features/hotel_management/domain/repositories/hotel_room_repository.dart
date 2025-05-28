import 'package:dartz/dartz.dart';
import 'package:hotelmangement/core/error/failure.dart';
import 'package:hotelmangement/features/hotel_management/domain/entities/room.dart';
import 'package:hotelmangement/features/hotel_management/domain/entities/room_image.dart';

abstract class HotelRoomRepository {
  Future<Either<Failure, Room>> createRoom({
    required String hotelId,
    required String roomNumber,
    required String description,
    required int space,
    required String floor,
    required double price,
    required bool available,
  });

  Future<Either<Failure, Room>> updateRoom({
    required String roomId,
    required String hotelId,
    String? roomNumber,
    String? description,
    int? space,
    String? floor,
    double? price,
    bool? available,
  });

  Future<Either<Failure, void>> deleteRoom({
    required String roomId,
    required String hotelId,
  });

  Future<Either<Failure, List<Room>>> getRooms({
    required String hotelId,
  });

  Future<Either<Failure, RoomImage>> addRoomImage(
    String roomId,
    String localImagePath,
  );

  Future<bool> isImageExists(String imageId, String roomId);

  Future<Either<Failure, List<RoomImage>>> getRoomImages(String roomId);

  Future<Either<Failure, void>> deleteRoomImage(
    String imageId,
  );
}
