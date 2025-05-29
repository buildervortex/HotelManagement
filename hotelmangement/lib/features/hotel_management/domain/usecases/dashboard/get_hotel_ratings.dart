import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:hotelmangement/core/error/failure.dart';
import 'package:hotelmangement/core/usecase.dart';
import 'package:hotelmangement/features/hotel_management/domain/entities/rating_count.dart';
import 'package:hotelmangement/features/hotel_management/domain/repositories/dashboard_repository.dart';

class GetHotelRatings extends Usecase<List<RatingCount>, Params> {
  final DashboardRepository repository;
  GetHotelRatings({required this.repository});
  @override
  Future<Either<Failure, List<RatingCount>>> call(Params params) {
    return repository.getHotelRatings(managerId: params.managerId);
  }
}

class Params extends Equatable {
  final String managerId;

  const Params({required this.managerId});

  @override
  List<Object?> get props => [managerId];
}
