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
  Future<Either<Failure, Room>> createRoom(
      {required String hotelId,
      required String roomNumber,
      required String description,
      required String space,
      required String floor,
      required double price}) {
    // TODO: implement createRoom
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, void>> deleteRoom(
      {required String roomId, required String hotelId}) {
    // TODO: implement deleteRoom
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, void>> deleteRoomImage(String imageId) {
    // TODO: implement deleteRoomImage
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<RoomImage>>> getRoomImages(String roomId) {
    // TODO: implement getRoomImages
    throw UnimplementedError();
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
  Future<Either<Failure, Room>> updateRoom(
      {required String roomId,
      required String hotelId,
      String? roomNumber,
      String? description,
      String? space,
      String? floor,
      double? price}) {
    // TODO: implement updateRoom
    throw UnimplementedError();
  }
}
