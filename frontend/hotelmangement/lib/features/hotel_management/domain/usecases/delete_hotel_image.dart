import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:hotelmangement/core/error/failure.dart';
import 'package:hotelmangement/core/usecase.dart';
import 'package:hotelmangement/features/hotel_management/domain/entities/hotel.dart';
import 'package:hotelmangement/features/hotel_management/domain/repositories/hotel_repository.dart';

class DeleteHotelImage extends Usecase<int, Params> {
  final HotelRepository repository;

  DeleteHotelImage({required this.repository});

  @override
  Future<Either<Failure, int>> call(Params params) async {
    final failureOrHotel = await repository.getHotel(params.hotelId);

    return failureOrHotel.fold(
      (failure) => Left(failure),
      (hotel) => _deleteHotelImageIfAuthorized(hotel, params),
    );
  }

  Future<Either<Failure, int>> _deleteHotelImageIfAuthorized(
      Hotel hotel, Params params) async {
    if (hotel.managerId != params.managerId) {
      return Future.value(Left(UnAuthorizedFailure()));
    }

    if (!await repository.isImageExists(params.imageId, params.hotelId)) {
      return Future.value(Left(NotFound()));
    }

    return repository.deleteHotelImage(
      params.imageId,
    );
  }
}

class Params extends Equatable {
  final String hotelId;
  final String managerId;
  final String imageId;

  const Params(
      {required this.hotelId, required this.managerId, required this.imageId});

  @override
  List<Object?> get props => [hotelId, managerId, imageId];
}
