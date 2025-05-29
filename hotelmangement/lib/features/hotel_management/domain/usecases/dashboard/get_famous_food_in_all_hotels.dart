import 'package:dartz/dartz.dart';
import 'package:hotelmangement/core/error/failure.dart';
import 'package:hotelmangement/core/usecase.dart';
import 'package:hotelmangement/features/hotel_management/domain/entities/famous_food.dart';
import 'package:hotelmangement/features/hotel_management/domain/repositories/dashboard_repository.dart';

class GetFamousFoodInAllHotels extends Usecase<List<FamousFood>, NoParams> {
  final DashboardRepository repository;

  GetFamousFoodInAllHotels({required this.repository});

  @override
  Future<Either<Failure, List<FamousFood>>> call(NoParams params) {
    return repository.getFamousFoodInAll();
  }
}
