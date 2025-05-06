import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:hotelmangement/core/error/failure.dart';
import 'package:hotelmangement/core/usecase.dart';
import 'package:hotelmangement/features/hotel_management/domain/entities/food.dart';
import 'package:hotelmangement/features/hotel_management/domain/repositories/hotel_food_repository.dart';

class GetFoodsInHotel extends Usecase<List<Food>, Params> {
  final HotelFoodRepository repository;

  GetFoodsInHotel({required this.repository});
  @override
  Future<Either<Failure, List<Food>>> call(Params params) async {
    return repository.getFoods(hotelId: params.hotelId);
  }
}

class Params extends Equatable {
  final String hotelId;

  const Params({
    required this.hotelId,
  });

  @override
  List<Object?> get props => [
        hotelId,
      ];
}
