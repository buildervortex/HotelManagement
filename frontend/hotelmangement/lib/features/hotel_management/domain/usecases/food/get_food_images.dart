import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:hotelmangement/core/error/failure.dart';
import 'package:hotelmangement/core/usecase.dart';
import 'package:hotelmangement/features/hotel_management/domain/entities/food_image.dart';
import 'package:hotelmangement/features/hotel_management/domain/repositories/hotel_food_repository.dart';

class GetFoodImages extends Usecase<List<FoodImage>, Params> {
  final HotelFoodRepository repository;

  GetFoodImages({required this.repository});
  @override
  Future<Either<Failure, List<FoodImage>>> call(Params params) async {
    return await repository.getFoodImages(params.foodId);
  }
}

class Params extends Equatable {
  final String foodId;

  const Params({required this.foodId});

  @override
  List<Object?> get props => [foodId];
}
