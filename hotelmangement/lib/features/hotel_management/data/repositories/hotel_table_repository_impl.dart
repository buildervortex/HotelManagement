import 'package:dartz/dartz.dart';
import 'package:hotelmangement/core/error/failure.dart';
import 'package:hotelmangement/features/hotel_management/data/dataSources/hotel_table_data_source.dart';
import 'package:hotelmangement/features/hotel_management/domain/entities/table.dart';
import 'package:hotelmangement/features/hotel_management/domain/repositories/hotel_table_repository.dart';

class HotelTableRepositoryImpl implements HotelTableRepository {
  final HotelTableDataSource dataSource;

  HotelTableRepositoryImpl({required this.dataSource});

  @override
  Future<Either<Failure, Table>> createTable(
      {required String hotelId,
      required String tableNumber,
      required int space,
      required String floor,
      required bool available}) async {
    try {
      final table = await dataSource.createTable(
          hotelId, tableNumber, space, floor, available);
      return Right(table);
    } catch (e) {
      print("Error adding table: $e");
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, void>> deleteTable(
      {required String tableId, required String hotelId}) async {
    try {
      await dataSource.deleteTable(tableId, hotelId);
      return const Right(null);
    } catch (e) {
      print("Error deleting table: $e");
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<Table>>> getTables(
      {required String hotelId}) async {
    try {
      final hotelImages = await dataSource.getTables(hotelId);
      return Right(hotelImages);
    } catch (e) {
      print("Error getting tables: $e");
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Table>> updateTable(
      {required String tableId,
      required String hotelId,
      String? tableNumber,
      int? space,
      String? floor,
      bool? available}) async {
    try {
      final hotel = await dataSource.updateTable(
          tableId, hotelId, tableNumber, space, floor, available);
      return Right(hotel);
    } catch (e) {
      print("Error update table: $e");
      return Left(ServerFailure());
    }
  }
}
