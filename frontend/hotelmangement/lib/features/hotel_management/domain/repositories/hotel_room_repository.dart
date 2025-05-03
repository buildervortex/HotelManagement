import 'package:dartz/dartz.dart';
import 'package:hotelmangement/core/error/failure.dart';
import 'package:hotelmangement/features/hotel_management/domain/entities/room.dart';

abstract class HotelRoomRepository {
  Future<Either<Failure, Room>> createRoom({
    required String hotelId,
    required String roomNumber,
    required String description,
    required String space,
    required String floor,
    required double price,
  });

  Future<Either<Failure, Room>> updateRoom({
    required String roomId,
    required String hotelId,
    String? roomNumber,
    String? description,
    String? space,
    String? floor,
    double? price,
  });

  Future<Either<Failure, void>> deleteRoom({
    required String roomId,
    required String hotelId,
  });

  Future<Either<Failure, List<Room>>> getRooms({
    required String hotelId,
  });
}
