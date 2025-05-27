import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:hotelmangement/core/error/failure.dart';
import 'package:hotelmangement/core/usecase.dart';
import 'package:hotelmangement/features/hotel_management/domain/entities/hotel.dart';
import 'package:hotelmangement/features/hotel_management/domain/entities/hotel_image.dart';
import 'package:hotelmangement/features/hotel_management/domain/repositories/hotel_repository.dart';

class AddHotelImage extends Usecase<HotelImage, Params> {
  final HotelRepository repository;

  AddHotelImage({required this.repository});

  @override
  Future<Either<Failure, HotelImage>> call(Params params) async {
    final failureOrHotel = await repository.getHotel(params.hotelId);

    return failureOrHotel.fold(
      (failure) => Left(failure),
      (hotel) => _addHotelImageIfAuthorized(hotel, params),
    );
  }

  Future<Either<Failure, HotelImage>> _addHotelImageIfAuthorized(
      Hotel hotel, Params params) async {
    if (hotel.managerId != params.managerId) {
      return Future.value(Left(UnAuthorizedFailure()));
    }

    return repository.addHotelImage(
      params.hotelId,
      params.localImagePath,
    );
  }
}

class Params extends Equatable {
  final String hotelId;
  final String managerId;
  final String localImagePath;
  final String remoteImageSaveName;

  const Params({
    required this.hotelId,
    required this.managerId,
    required this.localImagePath,
    required this.remoteImageSaveName,
  });

  @override
  List<Object?> get props =>
      [hotelId, managerId, localImagePath, remoteImageSaveName];
}
