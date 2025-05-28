import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:hotelmangement/core/error/failure.dart';
import 'package:hotelmangement/core/usecase.dart';
import 'package:hotelmangement/features/hotel_management/domain/entities/famous_food.dart';
import 'package:hotelmangement/features/hotel_management/domain/repositories/dashboard_repository.dart';

class GetFamousFoodsInOwnHotels extends Usecase<List<FamousFood>, Params> {
  final DashboardRepository repository;

  GetFamousFoodsInOwnHotels({required this.repository});

  @override
  Future<Either<Failure, List<FamousFood>>> call(Params params) {
    return repository.getFamousFoodsInCurrentManagerHotels(
        managerId: params.managerId);
  }
}

class Params extends Equatable {
  final String managerId;

  const Params({required this.managerId});

  @override
  List<Object?> get props => [managerId];
}
