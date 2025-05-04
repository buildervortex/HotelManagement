import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:hotelmangement/core/authorized_usecase.dart';
import 'package:hotelmangement/core/error/failure.dart';
import 'package:hotelmangement/features/hotel_management/domain/entities/food.dart';
import 'package:hotelmangement/features/hotel_management/domain/repositories/hotel_food_repository.dart';

class CreateFood extends AuthorizedUsecase<Food, Params> {
  final HotelFoodRepository repository;

  CreateFood({required this.repository, required super.hotelAuthorize});

  @override
  Future<Either<Failure, Food>> call(Params params) async {
    return super.executeAuthorized(params.managerId, params.hotelId, () async {
      return repository.createFood(
        hotelId: params.hotelId,
        name: params.name,
        price: params.price,
        available: params.available,
        type: params.type,
      );
    });
  }
}

class Params extends Equatable {
  final String managerId;
  final String hotelId;
  final String name;
  final double price;
  final bool available;
  final String type;

  const Params(
      {required this.managerId,
      required this.hotelId,
      required this.name,
      required this.price,
      required this.available,
      required this.type});

  @override
  List<Object?> get props => [managerId, hotelId, name, price, available, type];
}
