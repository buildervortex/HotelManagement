import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:hotelmangement/core/error/failure.dart';
import 'package:hotelmangement/core/usecase.dart';
import 'package:hotelmangement/features/hotel_management/domain/entities/hotel.dart';
import 'package:hotelmangement/features/hotel_management/domain/repositories/hotel_repository.dart';

class DeleteHotel extends Usecase<void, Params> {
  final HotelRepository repository;

  DeleteHotel({required this.repository});

  @override
  Future<Either<Failure, void>> call(Params params) async {
    final failureOrHotel = await repository.getHotel(params.hotelId);

    return failureOrHotel.fold(
      (failure) => Left(failure),
      (hotel) => _deleteHotelIfAuthorized(hotel, params),
    );
  }

  Future<Either<Failure, void>> _deleteHotelIfAuthorized(
      Hotel hotel, Params params) {
    if (hotel.managerId != params.managerId) {
      return Future.value(Left(UnAuthorizedFailure()));
    }

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
