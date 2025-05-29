import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:hotelmangement/core/error/failure.dart';
import 'package:hotelmangement/core/usecase.dart';
import 'package:hotelmangement/features/hotel_management/domain/entities/hotel.dart';
import 'package:hotelmangement/features/hotel_management/domain/repositories/hotel_repository.dart';

class GetHotels extends Usecase<List<Hotel>, Params> {
  final HotelRepository repository;

  GetHotels({required this.repository});

  @override
  Future<Either<Failure, List<Hotel>>> call(Params params) async {
    return repository.getHotels(params.managerId);
  }
}

class Params extends Equatable {
  final String managerId;

  const Params({required this.managerId});

  @override
  List<Object?> get props => [managerId];
}
