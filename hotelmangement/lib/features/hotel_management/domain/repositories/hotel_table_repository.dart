import 'package:dartz/dartz.dart';
import 'package:hotelmangement/core/error/failure.dart';
import 'package:hotelmangement/features/hotel_management/domain/entities/table.dart';

abstract class HotelTableRepository {
  Future<Either<Failure, Table>> createTable({
    required String hotelId,
    required String tableNumber,
    required int space,
    required String floor,
    required bool available,
  });

  Future<Either<Failure, Table>> updateTable({
    required String tableId,
    required String hotelId,
    String? tableNumber,
    int? space,
    String? floor,
    bool? available,
  });

  Future<Either<Failure, void>> deleteTable({
    required String tableId,
    required String hotelId,
  });

  Future<Either<Failure, List<Table>>> getTables({
    required String hotelId,
  });
}
