import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:hotelmangement/core/error/failure.dart';
import 'package:hotelmangement/core/usecase.dart';
import 'package:hotelmangement/features/hotel_management/domain/repositories/hotel_repository.dart';

class DeleteHotelPhoneNumber extends Usecase<int, Params> {
  final HotelRepository repository;

  DeleteHotelPhoneNumber({required this.repository});

  @override
  Future<Either<Failure, int>> call(Params params) async {
    final validateResult = await DeleteHotelPhoneNumberValidate(
        params: params, repository: repository)();

    return validateResult.fold(
      (failure) => Left(failure),
      (_) {
        return repository.deleteHotelPhoneNumber(params.phoneNumberId);
      },
    );
  }
}

class Params extends Equatable {
  final String phoneNumberId;
  final String hotelId;
  final String managerId;

  const Params(
      {required this.phoneNumberId,
      required this.hotelId,
      required this.managerId});

  @override
  List<Object?> get props => [phoneNumberId];
}

class DeleteHotelPhoneNumberValidate {
  final HotelRepository repository;
  final Params params;

  DeleteHotelPhoneNumberValidate(
      {required this.repository, required this.params});

  Future<Either<Failure, int>> call() async {
    final validators = [_validateManagerId, _validatePhoneNumberExistance];
    for (final validator in validators) {
      final result = await validator();
      if (result.isLeft()) {
        return result;
      }
    }
    return Right(1);
  }

  Future<Either<Failure, int>> _validateManagerId() async {
    final hotelOrFailure = await repository.getHotel(params.hotelId);
    return hotelOrFailure.fold(
      (failure) => Left(failure),
      (hotel) {
        if (hotel.managerId != params.managerId) {
          return Left(UnAuthorizedFailure());
        }
        return Right(1);
      },
    );
  }

  Future<Either<Failure, int>> _validatePhoneNumberExistance() async {
    final hotelPhoneNumbersOrFailure =
        await repository.getHotelPhoneNumbers(params.hotelId);
    return hotelPhoneNumbersOrFailure.fold(
      (failure) => Left(failure),
      (phoneNumbers) {
        if (phoneNumbers
            .any((phoneNumber) => phoneNumber.id == params.phoneNumberId)) {
          return Right(1);
        }
        return Left(NotFound());
      },
    );
  }
}
