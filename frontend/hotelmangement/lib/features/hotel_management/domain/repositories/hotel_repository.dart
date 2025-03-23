import 'package:dartz/dartz.dart';
import 'package:hotelmangement/core/error/failure.dart';
import 'package:hotelmangement/features/hotel_management/domain/entities/hotel.dart';

abstract class HotelRepository {
  Future<Either<Failure, Hotel>> createHotel(
    String name,
    String address,
    double longitude,
    double latitude,
    String managerId,
  );
  Future<Either<Failure, Hotel>> updateHotel(
    String hotelId,
    String managerId,
    String? name,
    String? address,
    double? longitude,
    double? latitude,
  );
  Future<Either<Failure, Hotel>> getHotel(
    String hotelId,
  );
  Future<Either<Failure, int>> deleteHotel(
    String hotelId,
    String managerId,
  );
}
