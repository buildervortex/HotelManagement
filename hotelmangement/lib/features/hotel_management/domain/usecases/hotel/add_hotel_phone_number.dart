import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:hotelmangement/core/error/failure.dart';
import 'package:hotelmangement/core/usecase.dart';
import 'package:hotelmangement/features/hotel_management/domain/entities/hotel_phone_number.dart';
import 'package:hotelmangement/features/hotel_management/domain/entities/hotel.dart';
import 'package:hotelmangement/features/hotel_management/domain/repositories/hotel_repository.dart';

class AddHotelPhoneNumber extends Usecase<HotelPhoneNumber, Params> {
  final HotelRepository repository;

  AddHotelPhoneNumber({required this.repository});
  @override
  Future<Either<Failure, HotelPhoneNumber>> call(Params params) async {
    final hotelOrFailure = await repository.getHotel(params.hotelId);

    return hotelOrFailure.fold(
      (failure) => Left(failure),
      (hotel) => _ifValidAddPhoneNumber(hotel, params),
    );
  }

  Future<Either<Failure, HotelPhoneNumber>> _ifValidAddPhoneNumber(
      Hotel hotel, Params params) async {
    if (hotel.managerId == params.managerId) {
      return repository.addHotelPhoneNumber(
          params.hotelId, params.phoneNumber, params.role);
    }
    return Left(UnAuthorizedFailure());
  }
}

class Params extends Equatable {
  final String hotelId;
  final String managerId;
  final String phoneNumber;
  final String role;

  const Params(
      {required this.hotelId,
      required this.managerId,
      required this.phoneNumber,
      required this.role});

  @override
  List<Object?> get props => [hotelId, managerId, phoneNumber, role];
}
