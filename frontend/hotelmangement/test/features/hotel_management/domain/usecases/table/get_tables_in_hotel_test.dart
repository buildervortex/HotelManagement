import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hotelmangement/core/error/failure.dart';
import 'package:hotelmangement/features/hotel_management/domain/entities/table.dart';
import 'package:hotelmangement/features/hotel_management/domain/repositories/hotel_table_repository.dart';
import 'package:hotelmangement/features/hotel_management/domain/usecases/table/get_tables_in_hotel.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_tables_in_hotel_test.mocks.dart';

@GenerateMocks([HotelTableRepository])
void main() {
  late HotelTableRepository repository;
  late GetTablesInHotel usecase;

  setUp(() {
    repository = MockHotelTableRepository();
    usecase = GetTablesInHotel(repository: repository);
  });

  group("hotelTable", () {
    test('should delete table successfully when authorized', () async {
      // arrange
      const params = Params(
        hotelId: 'hotelId',
      );
      const tables = [
        Table(
            id: "1",
            hotelId: "hotelId",
            space: 2,
            floor: "floor",
            tableNumber: "tableNumber"),
        Table(
            id: "1",
            hotelId: "hotelId",
            space: 2,
            floor: "floor",
            tableNumber: "tableNumber"),
      ];
      when(repository.getTables(
        hotelId: params.hotelId,
      )).thenAnswer((_) async => Right(tables));

      // act
      final result = await usecase(params);

      // assert
      expect(result, Right(tables));
      verify(repository.getTables(
        hotelId: params.hotelId,
      )).called(1);
      verifyNoMoreInteractions(repository);
    });

    test('should return failure when repository throws an error', () async {
      // arrange
      const params = Params(
        hotelId: 'hotel456',
      );
      when(repository.getTables(
        hotelId: params.hotelId,
      )).thenAnswer((_) async => Left(ServerFailure()));

      // act
      final result = await usecase(params);

      // assert
      expect(result, Left(ServerFailure()));
      verify(repository.getTables(
        hotelId: params.hotelId,
      )).called(1);
      verifyNoMoreInteractions(repository);
    });
  });
}
