import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:hotelmangement/core/error/failure.dart';
import 'package:hotelmangement/core/usecase.dart';
import 'package:hotelmangement/features/hotel_management/domain/entities/active_booking.dart';
import 'package:hotelmangement/features/hotel_management/domain/repositories/dashboard_repository.dart';

class GetActiveTableBookings extends Usecase<List<ActiveBooking>, Params> {
  final DashboardRepository repository;
  GetActiveTableBookings({required this.repository});
  @override
  Future<Either<Failure, List<ActiveBooking>>> call(Params params) {
    return repository.activeTableBookings(
      datetime: params.datetime,
      managerId: params.managerId,
    );
  }
}

class Params extends Equatable {
  final DateTime datetime;
  final String managerId;

  const Params({
    required this.datetime,
    required this.managerId,
  });

  @override
  List<Object?> get props => [datetime, managerId];
}
