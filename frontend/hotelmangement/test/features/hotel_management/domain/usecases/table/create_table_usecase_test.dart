import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hotelmangement/core/error/failure.dart';
import 'package:hotelmangement/features/hotel_management/domain/entities/hotel.dart';
import 'package:hotelmangement/features/hotel_management/domain/entities/table.dart';
import 'package:hotelmangement/features/hotel_management/domain/repositories/hotel_table_repository.dart';
import 'package:hotelmangement/features/hotel_management/domain/usecases/table/create_table.dart';
import 'package:hotelmangement/features/hotel_management/domain/usecases/validation/hotel_authorize.dart'
    as ha;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'create_table_usecase_test.mocks.dart';

@GenerateMocks([HotelTableRepository, ha.HotelAuthorize])
void main() {
  late CreateTable usecase;
  late MockHotelTableRepository repository;
  late MockHotelAuthorize hotelAuthorize;

  setUp(() {
    repository = MockHotelTableRepository();
    hotelAuthorize = MockHotelAuthorize();
    usecase =
        CreateTable(repository: repository, hotelAuthorize: hotelAuthorize);
  });

  group("hotelTable", () {
    test(
      'should call the repository to create the table and return the table object',
      () async {
        // arrange
        final params = Params(
          managerId: 'managerId',
          hotelId: 'hotelId',
          tableNumber: 'T1',
          space: 20,
          floor: '1',
        );
        final table = Table(
          id: 'tableId',
          hotelId: 'hotelId',
          tableNumber: 'T1',
          space: 20,
          floor: '1',
        );
        when(hotelAuthorize.call(ha.Params(
                hotelId: params.hotelId, managerId: params.managerId)))
            .thenAnswer((_) async => Right(Hotel(
                id: "1",
                managerId: "1",
                name: "name",
                address: "address",
                latitude: 25.4,
                longitude: 52.5)));
        when(repository.createTable(
                hotelId: params.hotelId,
                tableNumber: params.tableNumber,
                space: params.space,
                floor: params.floor))
            .thenAnswer((_) async => Right(table));
        

        // act
        final result = await usecase(params);

        // assert
        expect(result, Right(table));
        verify(hotelAuthorize.call(ha.Params(
                hotelId: params.hotelId, managerId: params.managerId)))
            .called(1);
        verify(repository.createTable(
          hotelId: params.hotelId,
          tableNumber: params.tableNumber,
          space: params.space,
          floor: params.floor,
        )).called(1);
        verifyNoMoreInteractions(repository);
      },
    );

    test(
      'should return a Failure when hotel authorization fails',
      () async {
      // arrange
      final params = Params(
        managerId: 'managerId',
        hotelId: 'hotelId',
        tableNumber: 'T1',
        space: 20,
        floor: '1',
      );
      when(hotelAuthorize.call(ha.Params(
          hotelId: params.hotelId, managerId: params.managerId)))
        .thenAnswer((_) async => Left(UnAuthorizedFailure()));

      // act
      final result = await usecase(params);

      // assert
      expect(result, Left(UnAuthorizedFailure()));
      verify(hotelAuthorize.call(ha.Params(
          hotelId: params.hotelId, managerId: params.managerId)))
        .called(1);
      verifyNoMoreInteractions(repository);
      },
    );

    test(
      'should return a Failure when repository fails to create the table',
      () async {
      // arrange
      final params = Params(
        managerId: 'managerId',
        hotelId: 'hotelId',
        tableNumber: 'T1',
        space: 20,
        floor: '1',
      );
      when(hotelAuthorize.call(ha.Params(
          hotelId: params.hotelId, managerId: params.managerId)))
        .thenAnswer((_) async => Right(Hotel(
          id: "1",
          managerId: "1",
          name: "name",
          address: "address",
          latitude: 25.4,
          longitude: 52.5)));
      when(repository.createTable(
          hotelId: params.hotelId,
          tableNumber: params.tableNumber,
          space: params.space,
          floor: params.floor))
        .thenAnswer((_) async => Left(ServerFailure()));

      // act
      final result = await usecase(params);

      // assert
      expect(result, Left(ServerFailure()));
      verify(hotelAuthorize.call(ha.Params(
          hotelId: params.hotelId, managerId: params.managerId)))
        .called(1);
      verify(repository.createTable(
        hotelId: params.hotelId,
        tableNumber: params.tableNumber,
        space: params.space,
        floor: params.floor,
      )).called(1);
      verifyNoMoreInteractions(repository);
      },
    );
  });
}
