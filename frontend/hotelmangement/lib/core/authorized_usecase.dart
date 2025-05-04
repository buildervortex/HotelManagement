import 'package:dartz/dartz.dart';
import 'package:hotelmangement/core/error/failure.dart';
import 'package:hotelmangement/core/usecase.dart';
import 'package:hotelmangement/features/hotel_management/domain/usecases/validation/hotel_authorize.dart';

abstract class AuthorizedUsecase<T, P> extends Usecase<T, P> {
  final HotelAuthorize hotelAuthorize;
  AuthorizedUsecase({
    required this.hotelAuthorize,
  });

  Future<Either<Failure, T>> executeAuthorized(
    String managerId,
    String hotelId,
    Future<Either<Failure, T>> Function() onAuthorized,
  ) async {
    final failureOrHotel =
        await hotelAuthorize(Params(hotelId: hotelId, managerId: managerId));

    if (failureOrHotel.isLeft()) {
      return Left(failureOrHotel.fold((l) => l, (r) => UnKnownFailure()));
    }
    return await onAuthorized();
  }
}
