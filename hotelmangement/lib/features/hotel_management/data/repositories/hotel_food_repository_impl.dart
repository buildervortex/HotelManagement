import 'package:dartz/dartz.dart';
import 'package:hotelmangement/core/error/failure.dart';
import 'package:hotelmangement/features/hotel_management/domain/entities/food.dart';
import 'package:hotelmangement/features/hotel_management/domain/entities/food_image.dart';
import 'package:hotelmangement/features/hotel_management/domain/repositories/hotel_food_repository.dart';

class HotelFoodRepositoryImpl implements HotelFoodRepository {
  @override
  Future<Either<Failure, FoodImage>> addFoodImage(
      String foodId, String localImagePath, String remoteImageSaveName) {
    // TODO: implement addFoodImage
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Food>> createFood(
      {required String hotelId,
      required String name,
      required double price,
      required bool available,
      required String type}) {
    // TODO: implement createFood
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, void>> deleteFood({required String foodId}) {
    // TODO: implement deleteFood
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, void>> deleteFoodImage(String imageId, String foodId) {
    // TODO: implement deleteFoodImage
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<FoodImage>>> getFoodImages(String foodId) {
    // TODO: implement getFoodImages
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<Food>>> getFoods({required String hotelId}) {
    // TODO: implement getFoods
    throw UnimplementedError();
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
