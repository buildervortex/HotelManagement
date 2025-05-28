import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:hotelmangement/core/error/failure.dart';
import 'package:hotelmangement/core/fileUtils.dart';
import 'package:hotelmangement/features/hotel_management/data/dataSources/file_data_source.dart';
import 'package:hotelmangement/features/hotel_management/data/dataSources/hotel_food_data_source.dart';
import 'package:hotelmangement/features/hotel_management/domain/entities/food.dart';
import 'package:hotelmangement/features/hotel_management/domain/entities/food_image.dart';
import 'package:hotelmangement/features/hotel_management/domain/repositories/hotel_food_repository.dart';
import 'package:path/path.dart';

class HotelFoodRepositoryImpl implements HotelFoodRepository {
  final HotelFoodDataSource dataSource;
  final FileDataSource fileDataSource;

  HotelFoodRepositoryImpl(
      {required this.dataSource, required this.fileDataSource});

  @override
  Future<Either<Failure, FoodImage>> addFoodImage(
      String foodId, String localImagePath) async {
    // create file object
    File file = File(localImagePath);

    // get renamed file name
    String uploadFileName = Fileutils.uuidRenamedFile(basename(localImagePath));

    try {
      await fileDataSource.uploadFile(file, uploadFileName, "foodimages");
      final foodImage = await dataSource.addFoodImage(foodId, uploadFileName);
      return Right(foodImage);
    } catch (e) {
      print("Error adding food image: $e");
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Food>> createFood(
      {required String hotelId,
      required String name,
      required double price,
      required bool available,
      required String type}) async {
    try {
      final room =
          await dataSource.createFood(hotelId, name, price, available, type);
      return Right(room);
    } catch (e) {
      print("Error adding food: $e");
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, void>> deleteFood({required String foodId}) async {
    try {
      await dataSource.deleteFood(foodId);
      return const Right(null);
    } catch (e) {
      print("Error deleting hotel food: $e");
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, void>> deleteFoodImage(
      String imageId, String foodId) async {
    try {
      final deletedHotelImage =
          await dataSource.deleteFoodImage(imageId, foodId);
      await fileDataSource.deleteFile(
          "foodimages", deletedHotelImage.imagePath);
      return const Right(1);
    } catch (e) {
      print("Error deleting food image: $e");
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<FoodImage>>> getFoodImages(String foodId) async {
    try {
      final hotelImages = await dataSource.getFoodImages(foodId);
      return Right(hotelImages);
    } catch (e) {
      print("Error getting food images: $e");
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<Food>>> getFoods(
      {required String hotelId}) async {
    try {
      final hotelImages = await dataSource.getFoods(hotelId);
      return Right(hotelImages);
    } catch (e) {
      print("Error getting foods: $e");
      return Left(ServerFailure());
    }
  }

  @override
  Future<bool> isImageExists(String imageId, String foodId) {
    // TODO: implement isImageExists
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Food>> updateFood(
      {required String foodId,
      String? name,
      double? price,
      bool? available,
      String? type}) {
    // TODO: implement updateFood
    throw UnimplementedError();
  }
}
