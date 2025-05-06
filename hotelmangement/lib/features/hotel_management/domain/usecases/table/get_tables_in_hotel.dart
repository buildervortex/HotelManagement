import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:hotelmangement/core/error/failure.dart';
import 'package:hotelmangement/core/usecase.dart';
import 'package:hotelmangement/features/hotel_management/domain/entities/table.dart';
import 'package:hotelmangement/features/hotel_management/domain/repositories/hotel_table_repository.dart';

class GetTablesInHotel extends Usecase<List<Table>, Params> {
  final HotelTableRepository repository;

  GetTablesInHotel({
    required this.repository,
  });

  @override
  Future<Either<Failure, List<Table>>> call(Params params) {
    return repository.getTables(hotelId: params.hotelId);
  }
}

class Params extends Equatable {
  final String hotelId;

  const Params({required this.hotelId});

  @override
  List<Object?> get props => [hotelId];
}
