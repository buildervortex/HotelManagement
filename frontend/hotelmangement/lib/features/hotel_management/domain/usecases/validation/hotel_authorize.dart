import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:hotelmangement/core/error/failure.dart';
import 'package:hotelmangement/core/usecase.dart';
import 'package:hotelmangement/features/hotel_management/domain/entities/hotel.dart';
import 'package:hotelmangement/features/hotel_management/domain/repositories/hotel_repository.dart';

class HotelAuthorize extends Usecase<Hotel, Params> {
  final HotelRepository repository;

  HotelAuthorize(this.repository);

  @override
  Future<Either<Failure, Hotel>> call(Params params) async {
    final failureOrHotel = await repository.getHotel(params.hotelId);

    return failureOrHotel.fold(
      (failure) => Left(failure),
      (hotel) {
        if (hotel.managerId != params.managerId) {
          return Future.value(Left(UnAuthorizedFailure()));
        }
        return Future.value(Right(hotel));
      },
    );
  }
}

class Params extends Equatable {
  final String hotelId;
  final String managerId;

  const Params({
    required this.hotelId,
    required this.managerId,
  });

  @override
  List<Object?> get props => [
        hotelId,
        managerId,
      ];
}
