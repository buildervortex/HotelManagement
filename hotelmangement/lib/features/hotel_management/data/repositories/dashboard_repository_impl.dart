import 'package:dartz/dartz.dart';
import 'package:hotelmangement/core/error/failure.dart';
import 'package:hotelmangement/features/hotel_management/data/dataSources/dashboard_data_source.dart';
import 'package:hotelmangement/features/hotel_management/domain/entities/active_booking.dart';
import 'package:hotelmangement/features/hotel_management/domain/entities/famous_food.dart';
import 'package:hotelmangement/features/hotel_management/domain/entities/hotel_state.dart';
import 'package:hotelmangement/features/hotel_management/domain/entities/rating_count.dart';
import 'package:hotelmangement/features/hotel_management/domain/repositories/dashboard_repository.dart';

class DashboardRepositoryImpl implements DashboardRepository {
  final DashboardDataSource dataSource;

  DashboardRepositoryImpl({required this.dataSource});

  @override
  Future<Either<Failure, List<ActiveBooking>>> activeTableBookings(
      {required DateTime datetime, required String managerId}) async {
    try {
      final hotelActiveTableBookings =
          await dataSource.activeTableBookings(datetime, managerId);
      return Right(hotelActiveTableBookings);
    } catch (e) {
      print("Error getting active table bookings: $e");
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<ActiveBooking>>> activeTakeAwayBookings(
      {required DateTime datetime, required String managerId}) async {
    try {
      final hotelTakeAwayBookings =
          await dataSource.activeTakeAwayBookings(datetime, managerId);
      return Right(hotelTakeAwayBookings);
    } catch (e) {
      print("Error getting active take away bookings: $e");
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<FamousFood>>> getFamousFoodInAll() async {
    try {
      final famousFoodsInAll = await dataSource.getFamousFoodInAll();
      return Right(famousFoodsInAll);
    } catch (e) {
      print("Error getting famous foods: $e");
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<FamousFood>>>
      getFamousFoodsInCurrentManagerHotels({required String managerId}) async {
    try {
      final famousFoods =
          await dataSource.getFamousFoodsInCurrentManagerHotels(managerId);
      return Right(famousFoods);
    } catch (e) {
      print("Error getting famous foods: $e");
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<RatingCount>>> getHotelRatings(
      {required String managerId}) async {
    try {
      final hotelRatings = await dataSource.getHotelRatings(managerId);
      return Right(hotelRatings);
    } catch (e) {
      print("Error getting hotel ratings: $e");
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<HotelState>>> getHotelState(
      {required String managerId}) async {
    try {
      final hotelState = await dataSource.getHotelState(managerId);
      return Right(hotelState);
    } catch (e) {
      print("Error getting hotel state: $e");
      return Left(ServerFailure());
    }
  }
}
