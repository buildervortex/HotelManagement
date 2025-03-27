import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:hotelmangement/core/error/failure.dart';
import 'package:hotelmangement/core/usecase.dart';
import 'package:hotelmangement/features/hotel_management/domain/repositories/hotel_repository.dart';

class DeleteHotelPhoneNumber extends Usecase<int, Params> {
  final HotelRepository repository;

  DeleteHotelPhoneNumber({required this.repository});

  @override
  Future<Either<Failure, int>> call(Params params) {
    return repository.deleteHotelPhoneNumber(params.phoneNumberId);
  }
}

class Params extends Equatable {
  final String phoneNumberId;

  const Params({required this.phoneNumberId});

  @override
  List<Object?> get props => [phoneNumberId];
}
