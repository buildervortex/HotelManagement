import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:hotelmangement/core/authorized_usecase.dart';
import 'package:hotelmangement/core/error/failure.dart';
import 'package:hotelmangement/features/hotel_management/domain/repositories/hotel_table_repository.dart';

class DeleteTable extends AuthorizedUsecase<void, Params> {
  final HotelTableRepository repository;

  DeleteTable({required this.repository, required super.hotelAuthorize});

  @override
  Future<Either<Failure, void>> call(Params params) async {
    return super.executeAuthorized(params.managerId, params.hotelId, () async {
      return repository.deleteTable(
        tableId: params.tableId,
        hotelId: params.hotelId,
      );
    });
  }
}

class Params extends Equatable {
  final String managerId;
  final String hotelId;
  final String tableId;

  const Params(
      {required this.managerId, required this.hotelId, required this.tableId});

  @override
  List<Object?> get props => [
        managerId,
        hotelId,
        tableId,
      ];
}
