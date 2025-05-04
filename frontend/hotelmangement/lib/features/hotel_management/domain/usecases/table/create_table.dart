import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:hotelmangement/core/authorized_usecase.dart';
import 'package:hotelmangement/core/error/failure.dart';
import 'package:hotelmangement/core/usecase.dart';
import 'package:hotelmangement/features/hotel_management/domain/entities/table.dart';
import 'package:hotelmangement/features/hotel_management/domain/repositories/hotel_table_repository.dart';
import 'package:hotelmangement/features/hotel_management/domain/usecases/validation/hotel_authorize.dart'
    as ha;

class CreateTable extends AuthorizedUsecase<Table, Params> {
  final HotelTableRepository repository;

  CreateTable({
    required this.repository,
    required super.hotelAuthorize,
  });

  @override
  Future<Either<Failure, Table>> call(Params params) async {
    return super.executeAuthorized(params.managerId, params.hotelId, () async {
      return repository.createTable(
        hotelId: params.hotelId,
        tableNumber: params.tableNumber,
        space: params.space,
        floor: params.floor,
      );
    });
    // final failureOrHotel = await hotelAuthorize(
    //     ha.Params(hotelId: params.hotelId, managerId: params.managerId));

    // if (failureOrHotel.isLeft()) {
    //   return Left(failureOrHotel.fold((l) => l, (r) => UnKnownFailure()));
    // }
    // return repository.createTable(
    //   hotelId: params.hotelId,
    //   tableNumber: params.tableNumber,
    //   space: params.space,
    //   floor: params.floor,
    // );
  }
}

class Params extends Equatable {
  final String managerId;
  final String hotelId;
  final int space;
  final String floor;
  final String tableNumber;

  const Params({
    required this.managerId,
    required this.hotelId,
    required this.space,
    required this.floor,
    required this.tableNumber,
  });

  @override
  List<Object?> get props => [
        managerId,
        hotelId,
        tableNumber,
        space,
        floor,
      ];
}
