import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hotelmangement/core/error/failure.dart';
import 'package:hotelmangement/features/hotel_management/domain/entities/hotel.dart';
import 'package:hotelmangement/features/hotel_management/domain/repositories/hotel_repository.dart';
import 'package:hotelmangement/features/hotel_management/domain/usecases/delete_hotel.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'delete_hotel_test.mocks.dart';

@GenerateMocks([HotelRepository])
void main() {
  late HotelRepository repository;
  late DeleteHotel usecase;

  setUp(() {
    repository = MockHotelRepository();
    usecase = DeleteHotel(repository: repository);
  });

  test("should delete the hotel if the managerid and the hotel id are maching",
      () async {
    // arrange
    final managerId = "1";
    final hotelId = "2";

    Hotel oldHotel = Hotel(
        id: "2",
        managerId: "1",
        name: "testName",
        address: "new address",
        latitude: 10.2774,
        longitude: 5.4465);

    when(repository.getHotel(hotelId)).thenAnswer((_) async => Right(oldHotel));
    when(repository.deleteHotel(hotelId))
        .thenAnswer((_) async => Right(1));

    // action
    final result =
        await usecase(Params(hotelId: hotelId, managerId: managerId));

    // assert
    expect(Right(1), result);
    verify(repository.getHotel(hotelId)).called(1);
    verify(repository.deleteHotel(hotelId)).called(1);
    verifyNoMoreInteractions(repository);
  });

  test(
      "should not delete the hotel if the managerid and the hotel id are not maching",
      () async {
    // arrange
    final managerId = "11";
    final hotelId = "2";

    Hotel oldHotel = Hotel(
        id: "2",
        managerId: "1",
        name: "testName",
        address: "new address",
        latitude: 10.2774,
        longitude: 5.4465);

    when(repository.getHotel(hotelId)).thenAnswer((_) async => Right(oldHotel));

    // action
    final result =
        await usecase(Params(hotelId: hotelId, managerId: managerId));

    // assert
    expect(result, Left(UnAuthorizedFailure()));
    verify(repository.getHotel(hotelId)).called(1);
    verifyNever(repository.deleteHotel(hotelId));
    verifyNoMoreInteractions(repository);
  });
}
