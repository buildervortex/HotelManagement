import 'package:dartz/dartz.dart';
import 'package:hotelmangement/core/error/failure.dart';
import 'package:hotelmangement/features/hotel_management/domain/entities/food.dart';
import 'package:hotelmangement/features/hotel_management/domain/entities/food_image.dart';

abstract class HotelFoodRepository {
  Future<Either<Failure, Food>> createFood(
      {required String hotelId,
      required String name,
      required double price,
      required bool available,
      required String type});

  Future<Either<Failure, Food>> updateFood(
      {required String foodId,
      String? name,
      double? price,
      bool? available,
      String? type});

  Future<Either<Failure, void>> deleteFood({required String foodId});

  Future<Either<Failure, List<Food>>> getFoods({required String hotelId});

  Future<Either<Failure, FoodImage>> addFoodImage(
    String foodId,
    String localImagePath,
    String remoteImageSaveName,
  );

  Future<bool> isImageExists(String imageId, String foodId);

  Future<Either<Failure, List<FoodImage>>> getFoodImages(String foodId);

  Future<Either<Failure, void>> deleteFoodImage(String imageId, String foodId);
}
