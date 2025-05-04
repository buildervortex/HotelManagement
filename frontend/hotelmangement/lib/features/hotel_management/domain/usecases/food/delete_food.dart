import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:hotelmangement/core/authorized_usecase.dart';
import 'package:hotelmangement/core/error/failure.dart';
import 'package:hotelmangement/features/hotel_management/domain/repositories/hotel_food_repository.dart';

class DeleteFood extends AuthorizedUsecase<void, Params> {
  final HotelFoodRepository repository;

  DeleteFood({required this.repository, required super.hotelAuthorize});

  @override
  Future<Either<Failure, void>> call(Params params) async {
    return super.executeAuthorized(params.managerId, params.hotelId, () async {
      return repository.deleteFood(foodId: params.foodId);
    });
  }
}

class Params extends Equatable {
  final String managerId;
  final String hotelId;
  final String foodId;

  const Params({
    required this.managerId,
    required this.hotelId,
    required this.foodId,
  });

  @override
  List<Object?> get props => [managerId, hotelId, foodId];
}
