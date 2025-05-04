import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:hotelmangement/core/authorized_usecase.dart';
import 'package:hotelmangement/core/error/failure.dart';
import 'package:hotelmangement/features/hotel_management/domain/entities/food_image.dart';
import 'package:hotelmangement/features/hotel_management/domain/repositories/hotel_food_repository.dart';

class AddFoodImage extends AuthorizedUsecase<FoodImage, Params> {
  final HotelFoodRepository repository;

  AddFoodImage({required this.repository, required super.hotelAuthorize});

  @override
  Future<Either<Failure, FoodImage>> call(Params params) async {
    return super.executeAuthorized(params.managerId, params.hotelId, () async {
      return repository.addFoodImage(
        params.foodId,
        params.localImagePath,
        params.remoteImageSaveName,
      );
    });
  }
}

class Params extends Equatable {
  final String hotelId;
  final String managerId;
  final String foodId;
  final String localImagePath;
  final String remoteImageSaveName;

  const Params({
    required this.hotelId,
    required this.managerId,
    required this.foodId,
    required this.localImagePath,
    required this.remoteImageSaveName,
  });

  @override
  List<Object?> get props =>
      [hotelId, managerId, foodId, localImagePath, remoteImageSaveName];
}
