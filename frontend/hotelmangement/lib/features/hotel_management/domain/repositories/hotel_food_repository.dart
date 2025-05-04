import 'package:dartz/dartz.dart';
import 'package:hotelmangement/core/error/failure.dart';
import 'package:hotelmangement/features/hotel_management/domain/entities/food_image.dart';

abstract class FoodRepository {
  Future<Either<Failure, FoodImage>> addFoodImage(
    String foodId,
    String localImagePath,
    String remoteImageSaveName,
  );

  Future<bool> isImageExists(String imageId, String foodId);

  Future<Either<Failure, List<FoodImage>>> getFoodImages(String foodId);

  Future<Either<Failure, int>> deleteFoodImage(
    String imageId,
  );
}
