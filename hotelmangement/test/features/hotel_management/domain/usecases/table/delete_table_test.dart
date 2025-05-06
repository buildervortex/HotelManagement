import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hotelmangement/core/error/failure.dart';
import 'package:hotelmangement/features/hotel_management/domain/entities/hotel.dart';
import 'package:hotelmangement/features/hotel_management/domain/repositories/hotel_table_repository.dart';
import 'package:hotelmangement/features/hotel_management/domain/usecases/table/delete_table.dart';
import 'package:hotelmangement/features/hotel_management/domain/usecases/validation/hotel_authorize.dart'
    as ha;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'delete_table_test.mocks.dart';

@GenerateMocks([HotelTableRepository, ha.HotelAuthorize])
void main() {
  late DeleteTable usecase;
  late HotelTableRepository repository;
  late ha.HotelAuthorize hotelAuthorize;

  setUp(() {
    repository = MockHotelTableRepository();
    hotelAuthorize = MockHotelAuthorize();
    usecase =
        DeleteTable(repository: repository, hotelAuthorize: hotelAuthorize);
  });

  group("hotelTable", () {
    test('should delete table successfully when authorized', () async {
      // arrange
      const params = Params(
        managerId: 'manager123',
        hotelId: 'hotel456',
        tableId: 'table789',
      );
      when(hotelAuthorize.call(
              ha.Params(hotelId: params.hotelId, managerId: params.managerId)))
          .thenAnswer((_) async => Right(Hotel(
                id: "hotel456",
                managerId: "manager123",
                name: "name",
                address: "address",
                latitude: 24.4,
                longitude: 45.5,
              )));
      when(repository.deleteTable(
        tableId: params.tableId,
        hotelId: params.hotelId,
      )).thenAnswer((_) async => Right(null));

      // act
      final result = await usecase(params);

      // assert
      expect(result, Right(null));
      verify(hotelAuthorize.call(
              ha.Params(hotelId: params.hotelId, managerId: params.managerId)))
          .called(1);
      verify(repository.deleteTable(
        tableId: params.tableId,
        hotelId: params.hotelId,
      )).called(1);
      verifyNoMoreInteractions(repository);
      verifyNoMoreInteractions(hotelAuthorize);
    });

    test('should return failure when not authorized', () async {
      // arrange
      const params = Params(
        managerId: 'manager123',
        hotelId: 'hotel456',
        tableId: 'table789',
      );
      when(hotelAuthorize.call(
              ha.Params(hotelId: params.hotelId, managerId: params.managerId)))
          .thenAnswer((_) async => Left(UnAuthorizedFailure()));

      // act
      final result = await usecase(params);

      // assert
      expect(result, Left(UnAuthorizedFailure()));
      verify(hotelAuthorize.call(
              ha.Params(hotelId: params.hotelId, managerId: params.managerId)))
          .called(1);
      verifyNoMoreInteractions(repository);
      verifyNoMoreInteractions(hotelAuthorize);
    });

    test('should return failure when repository throws an error', () async {
      // arrange
      const params = Params(
        managerId: 'manager123',
        hotelId: 'hotel456',
        tableId: 'table789',
      );
      when(hotelAuthorize.call(
              ha.Params(hotelId: params.hotelId, managerId: params.managerId)))
          .thenAnswer((_) async => Right(Hotel(
                id: "hotel456",
                managerId: "manager123",
                name: "name",
                address: "address",
                latitude: 24.4,
                longitude: 45.5,
              )));
      when(repository.deleteTable(
        tableId: params.tableId,
        hotelId: params.hotelId,
      )).thenAnswer((_) async => Left(ServerFailure()));

      // act
      final result = await usecase(params);

      // assert
      expect(result, Left(ServerFailure()));
      verify(hotelAuthorize.call(
              ha.Params(hotelId: params.hotelId, managerId: params.managerId)))
          .called(1);
      verify(repository.deleteTable(
        tableId: params.tableId,
        hotelId: params.hotelId,
      )).called(1);
      verifyNoMoreInteractions(repository);
      verifyNoMoreInteractions(hotelAuthorize);
    });
  });
}
