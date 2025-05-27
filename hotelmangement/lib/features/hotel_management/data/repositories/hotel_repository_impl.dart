import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:hotelmangement/core/error/failure.dart';
import 'package:hotelmangement/core/fileUtils.dart';
import 'package:hotelmangement/features/hotel_management/data/dataSources/file_data_source.dart';
import 'package:hotelmangement/features/hotel_management/data/dataSources/hotel_management_data_source.dart';
import 'package:hotelmangement/features/hotel_management/domain/entities/hotel.dart';
import 'package:hotelmangement/features/hotel_management/domain/entities/hotel_image.dart';
import 'package:hotelmangement/features/hotel_management/domain/entities/hotel_phone_number.dart';
import 'package:hotelmangement/features/hotel_management/domain/repositories/hotel_repository.dart';
import 'package:path/path.dart';

class HotelRepositoryImpl implements HotelRepository {
  final HotelManagementDataSource dataSource;
  final FileDataSource fileDataSource;

  HotelRepositoryImpl({required this.dataSource, required this.fileDataSource});

  @override
  Future<Either<Failure, HotelImage>> addHotelImage(
      String hotelId, String localImagePath) async {
    // create file object
    File file = File(localImagePath);

    // get renamed file name
    String uploadFileName = Fileutils.uuidRenamedFile(basename(localImagePath));

    try {
      await fileDataSource.uploadFile(file, uploadFileName, "hotelimage");
      final hotelImage =
          await dataSource.addHotelImage(uploadFileName, hotelId);
      return Right(hotelImage);
    } catch (e) {
      print("Error adding hotel image: $e");
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, HotelPhoneNumber>> addHotelPhoneNumber(
      String hotelId, String phoneNumber, String role) async {
    try {
      final hotelPhoneNumber =
          await dataSource.addHotelPhoneNumber(hotelId, phoneNumber, role);
      return Right(hotelPhoneNumber);
    } catch (e) {
      print("Error adding hotel phone number: $e");
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Hotel>> createHotel(String name, String address,
      double longitude, double latitude, String managerId) async {
    try {
      final hotel = await dataSource.createHotel(
          name, address, longitude, latitude, managerId);
      return Right(hotel);
    } catch (e) {
      print("Error adding hotel: $e");
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, void>> deleteHotel(String hotelId) async {
    try {
      await dataSource.deleteHotel(hotelId);
      return const Right(null);
    } catch (e) {
      print("Error deleting hotel: $e");
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, int>> deleteHotelImage(String imageId) async {
    try {
      await dataSource.deleteHotelImage(imageId);
      return const Right(1);
    } catch (e) {
      print("Error deleting hotel image: $e");
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, int>> deleteHotelPhoneNumber(String phoneNumberId) {
    // TODO: implement deleteHotelPhoneNumber
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Hotel>> getHotel(String hotelId) {
    // TODO: implement getHotel
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<HotelImage>>> getHotelImages(String hotelId) {
    // TODO: implement getHotelImages
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<HotelPhoneNumber>>> getHotelPhoneNumbers(
      String hotelId) {
    // TODO: implement getHotelPhoneNumbers
    throw UnimplementedError();
  }

  @override
  Future<bool> isImageExists(String imageId, String hotelId) {
    // TODO: implement isImageExists
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Hotel>> updateHotel(String hotelId, String? name,
      String? address, double? longitude, double? latitude, String? mainImage) {
    // TODO: implement updateHotel
    throw UnimplementedError();
  }
}
