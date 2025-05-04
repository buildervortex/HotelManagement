import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:hotelmangement/core/authorized_usecase.dart';
import 'package:hotelmangement/core/error/failure.dart';
import 'package:hotelmangement/features/hotel_management/domain/repositories/hotel_food_repository.dart';

class DeleteFoodImage extends AuthorizedUsecase<void, Params> {
  final HotelFoodRepository repository;

  DeleteFoodImage({required this.repository, required super.hotelAuthorize});
  @override
  Future<Either<Failure, void>> call(Params params) async {
    return super.executeAuthorized(params.managerId, params.hotelId, () async {
      return repository.deleteFoodImage(params.imageId, params.foodId);
    });
  }
}

class Params extends Equatable {
  final String hotelId;
  final String managerId;
  final String foodId;
  final String imageId;

  const Params({
    required this.hotelId,
    required this.managerId,
    required this.foodId,
    required this.imageId,
  });

  @override
  List<Object?> get props => [hotelId, managerId, foodId, imageId];
}
