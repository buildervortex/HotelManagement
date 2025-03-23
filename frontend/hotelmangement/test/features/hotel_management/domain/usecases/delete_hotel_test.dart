import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hotelmangement/features/hotel_management/domain/entities/hotel.dart';
import 'package:hotelmangement/features/hotel_management/domain/repositories/hotel_repository.dart';
import 'package:hotelmangement/features/hotel_management/domain/usecases/delete_hotel.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'delete_hotel_test.mocks.dart';

@GenerateMocks([HotelRepository])
void main() {
  late MockHotelRepository repository;
  late DeleteHotel usecase;

  setUp(() {
    repository = MockHotelRepository();
    usecase = DeleteHotel(repository: repository);
  });

  test("should delete the hotel using hotel repository", () async {
    // arrange
    final hotel = Hotel(
        id: "1",
        managerId: "2",
        name: "testName",
        address: "new address",
        latitude: 10.2774,
        longitude: 5.4465);
    final managerId = "1";
    final hotelId = "2";

    when(repository.deleteHotel(hotelId, managerId))
        .thenAnswer((_) async => Right(1));

    // action

    final result =
        await usecase(Params(hotelId: hotelId, managerId: managerId));

    // assert
    expect(Right(1), result);
    verify(repository.deleteHotel(any, any)).called(1);
    verifyNoMoreInteractions(repository);
  });
}
