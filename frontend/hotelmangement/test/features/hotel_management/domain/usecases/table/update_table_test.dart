import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hotelmangement/core/error/failure.dart';
import 'package:hotelmangement/features/hotel_management/domain/entities/hotel.dart';
import 'package:hotelmangement/features/hotel_management/domain/entities/table.dart';
import 'package:hotelmangement/features/hotel_management/domain/repositories/hotel_table_repository.dart';
import 'package:hotelmangement/features/hotel_management/domain/usecases/table/update_table.dart';
import 'package:hotelmangement/features/hotel_management/domain/usecases/validation/hotel_authorize.dart'
    as ha;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'update_table_test.mocks.dart';

@GenerateMocks([HotelTableRepository, ha.HotelAuthorize])
void main() {
  late UpdateTable usecase;
  late HotelTableRepository repository;
  late ha.HotelAuthorize hotelAuthorize;

  setUp(() {
    repository = MockHotelTableRepository();
    hotelAuthorize = MockHotelAuthorize();
    usecase =
        UpdateTable(repository: repository, hotelAuthorize: hotelAuthorize);
  });

  group("hotelTable", () {
    test('should update table successfully when authorized', () async {
      // arrange
      const params = Params(
        managerId: 'manager123',
        hotelId: 'hotel456',
        tableId: 'table789',
        tableNumber: 'T1',
        space: 4,
        floor: '1st',
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
      when(repository.updateTable(
        tableId: params.tableId,
        hotelId: params.hotelId,
        tableNumber: params.tableNumber,
        space: params.space,
        floor: params.floor,
      )).thenAnswer((_) async => Right(Table(
            id: params.tableId,
            tableNumber: params.tableNumber!,
            space: params.space!,
            floor: params.floor!,
            hotelId: params.hotelId,
          )));

      // act
      final result = await usecase(params);

      // assert
      expect(result.isRight(), true);
      verify(hotelAuthorize.call(
          ha.Params(hotelId: params.hotelId, managerId: params.managerId)));
      verify(repository.updateTable(
        tableId: params.tableId,
        hotelId: params.hotelId,
        tableNumber: params.tableNumber,
        space: params.space,
        floor: params.floor,
      ));
      verifyNoMoreInteractions(repository);
      verifyNoMoreInteractions(hotelAuthorize);
    });

    test('should return failure when not authorized', () async {
      // arrange
      const params = Params(
        managerId: 'manager123',
        hotelId: 'hotel456',
        tableId: 'table789',
        tableNumber: 'T1',
        space: 4,
        floor: '1st',
      );
      when(hotelAuthorize.call(
              ha.Params(hotelId: params.hotelId, managerId: params.managerId)))
          .thenAnswer((_) async => Left(UnAuthorizedFailure()));

      // act
      final result = await usecase(params);

      // assert
      expect(result, Left(UnAuthorizedFailure()));
      verify(hotelAuthorize.call(
          ha.Params(hotelId: params.hotelId, managerId: params.managerId)));
      verifyNoMoreInteractions(repository);
      verifyNoMoreInteractions(hotelAuthorize);
    });

    test('should return failure when repository throws an error', () async {
      // arrange
      const params = Params(
        managerId: 'manager123',
        hotelId: 'hotel456',
        tableId: 'table789',
        tableNumber: 'T1',
        space: 4,
        floor: '1st',
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
      when(repository.updateTable(
        tableId: params.tableId,
        hotelId: params.hotelId,
        tableNumber: params.tableNumber,
        space: params.space,
        floor: params.floor,
      )).thenAnswer((_) async => Left(ServerFailure()));

      // act
      final result = await usecase(params);

      // assert
      expect(result, Left(ServerFailure()));
      verify(hotelAuthorize.call(
          ha.Params(hotelId: params.hotelId, managerId: params.managerId)));
      verify(repository.updateTable(
        tableId: params.tableId,
        hotelId: params.hotelId,
        tableNumber: params.tableNumber,
        space: params.space,
        floor: params.floor,
      ));
      verifyNoMoreInteractions(repository);
      verifyNoMoreInteractions(hotelAuthorize);
    });
  });
}
