import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:hotelmangement/core/error/failure.dart';
import 'package:hotelmangement/core/usecase.dart';
import 'package:hotelmangement/features/hotel_management/domain/entities/hotel.dart';
import 'package:hotelmangement/features/hotel_management/domain/repositories/hotel_repository.dart';

class CreateHotel extends Usecase<Hotel, Params> {
  final HotelRepository repository;

  CreateHotel({required this.repository});
  @override
  Future<Either<Failure, Hotel>> call(Params params) {
    return repository.createHotel(params.name, params.address, params.longitude,
        params.latitude, params.managerId);
  }
}

class Params extends Equatable {
  final String name;
  final String address;
  final double longitude;
  final double latitude;
  final String managerId;

  const Params(
      {required this.name,
      required this.address,
      required this.longitude,
      required this.latitude,
      required this.managerId});

  @override
  List<Object?> get props => [name, address, longitude, latitude, managerId];
}
