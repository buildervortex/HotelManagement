import 'package:dartz/dartz.dart';
import 'package:hotelmangement/core/error/failure.dart';
import 'package:hotelmangement/core/usecase.dart';
import 'package:hotelmangement/features/hotel_management/domain/entities/famous_food.dart';
import 'package:hotelmangement/features/hotel_management/domain/repositories/dashboard_repository.dart';

class GetFamousFoodInAllHotels extends Usecase<FamousFood, void> {
  final DashboardRepository repository;

  GetFamousFoodInAllHotels({required this.repository});

  @override
  Future<Either<Failure, FamousFood>> call(void params) {
    return repository.getFamousFoodInAll();
  }
}
