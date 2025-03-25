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
    String? mainImage,
  );
  Future<Either<Failure, Hotel>> getHotel(
    String hotelId,
  );
  Future<Either<Failure, int>> deleteHotel(
    String hotelId,
    String managerId,
  );

  Future<Either<Failure, int>> addHotelImage(
    String hotelId,
    String managerId,
    String imagePath,
  );

  Future<Either<Failure, List<String>>> getHotelImages(List<String> imageName);

  Future<Either<Failure, int>> deleteHotelImage(
    String hotelId,
    String managerId,
    String imagePath,
  );

  // Future<Either<Failure, String>> uploadImageToSupabase(
  //   String filePath,
  //   String bucketName,
  // );

  // Future<Either<Failure, List<String>>> getImagesFromSupabase(
  //   String bucketName,
  // );
}
