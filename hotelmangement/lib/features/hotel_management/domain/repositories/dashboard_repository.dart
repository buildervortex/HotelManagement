import 'package:dartz/dartz.dart';
import 'package:hotelmangement/core/error/failure.dart';
import 'package:hotelmangement/features/hotel_management/domain/entities/active_booking.dart';
import 'package:hotelmangement/features/hotel_management/domain/entities/famous_food.dart';
import 'package:hotelmangement/features/hotel_management/domain/entities/hotel_state.dart';
import 'package:hotelmangement/features/hotel_management/domain/entities/rating_count.dart';

abstract class DashboardRepository {
  Future<Either<Failure, List<FamousFood>>> getFamousFoodInAll();

  Future<Either<Failure, List<FamousFood>>>
      getFamousFoodsInCurrentManagerHotels({
    required String managerId,
  });

  Future<Either<Failure, List<RatingCount>>> getHotelRatings(
      {required String managerId});

  Future<Either<Failure, List<ActiveBooking>>> activeTakeAwayBookings(
      {required DateTime datetime, required String managerId});

  Future<Either<Failure, List<ActiveBooking>>> activeTableBookings(
      {required DateTime datetime, required String managerId});

  Future<Either<Failure, List<HotelState>>> getHotelState({
    required String managerId,
  });
}
