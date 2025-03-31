import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:hotelmangement/core/error/failure.dart';
import 'package:hotelmangement/core/usecase.dart';
import 'package:hotelmangement/features/hotel_management/domain/entities/hotel.dart';
import 'package:hotelmangement/features/hotel_management/domain/repositories/hotel_repository.dart';

class GetHotelDetails extends Usecase<Hotel, Params> {
  final HotelRepository repository;

  GetHotelDetails({required this.repository});

  @override
  Future<Either<Failure, Hotel>> call(Params params) async {
    return repository.getHotel(params.hotelId);
  }
}

class Params extends Equatable {
  final String hotelId;

  const Params({required this.hotelId});

  @override
  List<Object?> get props => [hotelId];
}
