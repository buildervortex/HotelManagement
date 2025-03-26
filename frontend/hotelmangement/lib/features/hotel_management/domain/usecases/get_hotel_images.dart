import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:hotelmangement/core/error/failure.dart';
import 'package:hotelmangement/core/usecase.dart';
import 'package:hotelmangement/features/hotel_management/domain/entities/hotel_image.dart';
import 'package:hotelmangement/features/hotel_management/domain/repositories/hotel_repository.dart';

class GetHotelImages extends Usecase<List<HotelImage>, Params> {
  final HotelRepository repository;

  GetHotelImages({required this.repository});

  @override
  Future<Either<Failure, List<HotelImage>>> call(Params params) {
    return repository.getHotelImages(params.hotelId);
  }
}

class Params extends Equatable {
  final String hotelId;

  const Params({required this.hotelId});

  @override
  List<Object?> get props => [hotelId];
}
