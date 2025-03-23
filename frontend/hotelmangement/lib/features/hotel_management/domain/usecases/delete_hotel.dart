import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:hotelmangement/core/error/failure.dart';
import 'package:hotelmangement/core/usecase.dart';
import 'package:hotelmangement/features/hotel_management/domain/repositories/hotel_repository.dart';

class DeleteHotel extends Usecase<void, Params> {
  final HotelRepository repository;

  DeleteHotel({required this.repository});

  @override
  Future<Either<Failure, void>> call(Params params) {
    return repository.deleteHotel(params.hotelId, params.managerId);
  }
}

class Params extends Equatable {
  final String hotelId;
  final String managerId;

  const Params({required this.hotelId, required this.managerId});

  @override
  List<Object?> get props => throw UnimplementedError();
}
