import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:hotelmangement/core/error/failure.dart';
import 'package:hotelmangement/core/usecase.dart';
import 'package:hotelmangement/features/hotel_management/domain/entities/hote_phone_number.dart';
import 'package:hotelmangement/features/hotel_management/domain/repositories/hotel_repository.dart';

class GetHotelPhoneNumbers extends Usecase<List<HotelPhoneNumber>, Params> {
  final HotelRepository repository;

  GetHotelPhoneNumbers({required this.repository});
  @override
  Future<Either<Failure, List<HotelPhoneNumber>>> call(Params params) {
    return repository.getHotelPhoneNumbers(params.hotelId);
  }
}

class Params extends Equatable {
  final String hotelId;

  const Params({required this.hotelId});

  @override
  List<Object?> get props => [];
}
