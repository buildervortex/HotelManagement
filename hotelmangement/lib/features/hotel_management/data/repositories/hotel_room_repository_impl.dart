import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:hotelmangement/core/error/failure.dart';
import 'package:hotelmangement/core/fileUtils.dart';
import 'package:hotelmangement/features/hotel_management/data/dataSources/file_data_source.dart';
import 'package:hotelmangement/features/hotel_management/data/dataSources/hotel_room_data_source.dart';
import 'package:hotelmangement/features/hotel_management/domain/entities/room.dart';
import 'package:hotelmangement/features/hotel_management/domain/entities/room_image.dart';
import 'package:hotelmangement/features/hotel_management/domain/repositories/hotel_room_repository.dart';
import 'package:path/path.dart';

class HotelRoomRepositoryImpl extends HotelRoomRepository {
  final HotelRoomDataSource dataSource;
  final FileDataSource fileDataSource;

  HotelRoomRepositoryImpl(
      {required this.dataSource, required this.fileDataSource});

  @override
  Future<Either<Failure, RoomImage>> addRoomImage(
      String roomId, String localImagePath) async {
    // create file object
    File file = File(localImagePath);

    // get renamed file name
    String uploadFileName = Fileutils.uuidRenamedFile(basename(localImagePath));

    try {
      await fileDataSource.uploadFile(file, uploadFileName, "roomimages");
      final roomImage = await dataSource.addRoomImage(uploadFileName, roomId);
      return Right(roomImage);
    } catch (e) {
      print("Error adding room image: $e");
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Room>> createRoom({
    required String hotelId,
    required String roomNumber,
    required String description,
    required int space,
    required String floor,
    required double price,
    required bool available,
  }) async {
    try {
      final room = await dataSource.createRoom(
          hotelId, roomNumber, description, space, floor, price, available);
      return Right(room);
    } catch (e) {
      print("Error adding room: $e");
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, void>> deleteRoom(
      {required String roomId, required String hotelId}) async {
    try {
      await dataSource.deleteRoom(roomId: roomId, hotelId: hotelId);
      return const Right(null);
    } catch (e) {
      print("Error deleting hotel room: $e");
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, void>> deleteRoomImage(String imageId) async {
    try {
      final deletedHotelImage = await dataSource.deleteRoomImage(imageId);
      await fileDataSource.deleteFile(
          "roomimages", deletedHotelImage.imagePath);
      return const Right(1);
    } catch (e) {
      print("Error deleting room image: $e");
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<RoomImage>>> getRoomImages(String roomId) async {
    try {
      final hotelImages = await dataSource.getRoomImages(roomId);
      return Right(hotelImages);
    } catch (e) {
      print("Error getting room images: $e");
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<Room>>> getRooms({required String hotelId}) {
    // TODO: implement getRooms
    throw UnimplementedError();
  }

  @override
  Future<bool> isImageExists(String imageId, String roomId) {
    // TODO: implement isImageExists
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Room>> updateRoom({
    required String roomId,
    required String hotelId,
    String? roomNumber,
    String? description,
    int? space,
    String? floor,
    double? price,
    bool? available,
  }) {
    // TODO: implement updateRoom
    throw UnimplementedError();
  }
}
