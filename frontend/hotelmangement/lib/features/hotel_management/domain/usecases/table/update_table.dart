import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:hotelmangement/core/authorized_usecase.dart';
import 'package:hotelmangement/core/error/failure.dart';
import 'package:hotelmangement/features/hotel_management/domain/entities/table.dart';
import 'package:hotelmangement/features/hotel_management/domain/repositories/hotel_table_repository.dart';

class UpdateTable extends AuthorizedUsecase<Table, Params> {
  final HotelTableRepository repository;

  UpdateTable({
    required this.repository,
    required super.hotelAuthorize,
  });
  @override
  Future<Either<Failure, Table>> call(Params params) async {
    return super.executeAuthorized(params.managerId, params.hotelId, () async {
      return repository.updateTable(
        tableId: params.tableId,
        hotelId: params.hotelId,
        tableNumber: params.tableNumber,
        space: params.space,
        floor: params.floor,
      );
    });
  }
}

class Params extends Equatable {
  final String managerId;
  final String hotelId;
  final String tableId;
  final String? tableNumber;
  final int? space;
  final String? floor;

  const Params({
    required this.managerId,
    required this.hotelId,
    required this.tableId,
    required this.tableNumber,
    required this.space,
    required this.floor,
  });

  @override
  List<Object?> get props => [
        managerId,
        hotelId,
        tableId,
        tableNumber,
        space,
        floor,
      ];
}
