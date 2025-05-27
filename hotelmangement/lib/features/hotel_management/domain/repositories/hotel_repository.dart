import 'package:dartz/dartz.dart';
import 'package:hotelmangement/core/error/failure.dart';
import 'package:hotelmangement/features/hotel_management/domain/entities/hotel_phone_number.dart';
import 'package:hotelmangement/features/hotel_management/domain/entities/hotel.dart';
import 'package:hotelmangement/features/hotel_management/domain/entities/hotel_image.dart';

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
    String? name,
    String? address,
    double? longitude,
    double? latitude,
    String? mainImage,
  );
  Future<Either<Failure, Hotel>> getHotel(
    String hotelId,
  );
  Future<Either<Failure, void>> deleteHotel(
    String hotelId,
  );

  Future<Either<Failure, HotelImage>> addHotelImage(
    String hotelId,
    String localImagePath,
  );

  Future<bool> isImageExists(String imageId, String hotelId);

  Future<Either<Failure, List<HotelImage>>> getHotelImages(String hotelId);

  Future<Either<Failure, int>> deleteHotelImage(
    String imageId,
  );

  Future<Either<Failure, List<HotelPhoneNumber>>> getHotelPhoneNumbers(
    String hotelId,
  );

  Future<Either<Failure, int>> deleteHotelPhoneNumber(
    String phoneNumberId,
  );

  Future<Either<Failure, HotelPhoneNumber>> addHotelPhoneNumber(
    String hotelId,
    String phoneNumber,
    String role,
  );
}
