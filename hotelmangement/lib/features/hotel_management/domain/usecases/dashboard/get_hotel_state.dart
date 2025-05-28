import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:hotelmangement/core/error/failure.dart';
import 'package:hotelmangement/core/usecase.dart';
import 'package:hotelmangement/features/hotel_management/domain/entities/hotel_state.dart';
import 'package:hotelmangement/features/hotel_management/domain/repositories/dashboard_repository.dart';

class GetHotelState extends Usecase<HotelState, Params> {
  final DashboardRepository repository;
  GetHotelState({required this.repository});
  @override
  Future<Either<Failure, HotelState>> call(Params params) {
    return repository.getHotelState(managerId: params.managerId);
  }
}

class Params extends Equatable {
  final String managerId;

  const Params({required this.managerId});

  @override
  List<Object?> get props => [managerId];
}
