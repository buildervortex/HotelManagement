import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:hotelmangement/core/error/failure.dart';
import 'package:hotelmangement/core/usecase.dart';
import 'package:hotelmangement/features/hotel_management/domain/entities/hotel.dart';
import 'package:hotelmangement/features/hotel_management/domain/repositories/hotel_repository.dart';

class UpdateHotel extends Usecase<Hotel, Params> {
  final HotelRepository repository;

  UpdateHotel({required this.repository});

  @override
  Future<Either<Failure, Hotel>> call(Params params) async {
    final failureOrHotel = await repository.getHotel(params.hotelId);

    return failureOrHotel.fold(
      (failure) => Left(failure),
      (hotel) => _updateHotelIfAuthorized(hotel, params),
    );
  }

  Future<Either<Failure, Hotel>> _updateHotelIfAuthorized(
      Hotel hotel, Params params) {
    if (hotel.managerId != params.managerId) {
      return Future.value(Left(UnAuthorizedFailure()));
    }

    return repository.updateHotel(
      params.hotelId,
      params.name,
      params.address,
      params.longitude,
      params.latitude,
      params.mainImage,
    );
  }
}

class Params extends Equatable {
  final String hotelId;
  final String managerId;
  final String? name;
  final String? address;
  final double? longitude;
  final double? latitude;
  final String? mainImage;

  const Params({
    required this.hotelId,
    required this.managerId,
    this.name,
    this.address,
    this.longitude,
    this.latitude,
    this.mainImage,
  });

  @override
  List<Object?> get props =>
      [hotelId, name, address, longitude, latitude, mainImage];
}
