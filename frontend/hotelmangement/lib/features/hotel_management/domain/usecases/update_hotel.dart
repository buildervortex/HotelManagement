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
  Future<Either<Failure, Hotel>> call(Params params) {
    return repository.updateHotel(
      params.hotelId,
      params.managerId,
      params.name,
      params.address,
      params.longitude,
      params.latitude,
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

  const Params({
    required this.hotelId,
    required this.managerId,
    this.name,
    this.address,
    this.longitude,
    this.latitude,
  });

  @override
  List<Object?> get props => [hotelId, name, address, longitude, latitude];
}
