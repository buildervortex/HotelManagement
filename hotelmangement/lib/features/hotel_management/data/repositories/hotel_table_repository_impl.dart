import 'package:dartz/dartz.dart';
import 'package:hotelmangement/core/error/failure.dart';
import 'package:hotelmangement/features/hotel_management/domain/entities/table.dart';
import 'package:hotelmangement/features/hotel_management/domain/repositories/hotel_table_repository.dart';

class HotelTableRepositoryImpl implements HotelTableRepository {
  @override
  Future<Either<Failure, Table>> createTable(
      {required String hotelId,
      required String tableNumber,
      required int space,
      required String floor,
      required bool available}) {
    // TODO: implement createTable
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, void>> deleteTable(
      {required String tableId, required String hotelId}) {
    // TODO: implement deleteTable
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<Table>>> getTables({required String hotelId}) {
    // TODO: implement getTables
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Table>> updateTable(
      {required String tableId,
      required String hotelId,
      String? tableNumber,
      int? space,
      String? floor,
      bool? available}) {
    // TODO: implement updateTable
    throw UnimplementedError();
  }
}
