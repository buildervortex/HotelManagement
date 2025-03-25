import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hotelmangement/core/error/failure.dart';
import 'package:hotelmangement/features/hotel_management/domain/entities/hotel.dart';
import 'package:hotelmangement/features/hotel_management/domain/repositories/hotel_repository.dart';
import 'package:hotelmangement/features/hotel_management/domain/usecases/add_hotel_image.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'add_hotel_image_test.mocks.dart';

@GenerateMocks([HotelRepository])
void main() {
  late MockHotelRepository repository;
  late AddHotelImage usecase;

  setUp(() {
    repository = MockHotelRepository();
    usecase = AddHotelImage(repository: repository);
  });

  test("should add the image if the managerId and the hotelId match", () async {
    // arrange
    final hotelId = "1";
    final managerId = "2";
    final imagePath = "testExamplepath";
    final hotel = Hotel(
        id: "1",
        managerId: "2",
        name: "testName",
        address: "new address",
        latitude: 10.2774,
        longitude: 5.4465);
    when(repository.getHotel(hotelId)).thenAnswer((_) async => Right(hotel));
    when(repository.addHotelImage(hotelId, managerId, imagePath))
        .thenAnswer((_) async => Right(1));

    // action
    final result = await usecase(
        Params(hotelId: hotelId, managerId: managerId, imagePath: imagePath));

    // assert
    expect(Right(1), result);
    verify(repository.getHotel(hotelId)).called(1);
    verify(repository.addHotelImage(hotelId, managerId, imagePath)).called(1);
    verifyNoMoreInteractions(repository);
  });

  test(
      "should return unAuhtorizedFailure if the managerId and the hotelId are not maching",
      () async {
    // arrange
    final hotelId = "1";
    final managerId = "10";
    final imagePath = "testExamplepath";
    final hotel = Hotel(
        id: "1",
        managerId: "2",
        name: "testName",
        address: "new address",
        latitude: 10.2774,
        longitude: 5.4465);
    when(repository.getHotel(hotelId)).thenAnswer((_) async => Right(hotel));

    // action
    final result = await usecase(
        Params(hotelId: hotelId, managerId: managerId, imagePath: imagePath));

    // assert
    expect(Left(UnAuthorizedFailure()), result);
    verify(repository.getHotel(hotelId)).called(1);
    verifyNever(repository.addHotelImage(hotelId, managerId, imagePath));
    verifyNoMoreInteractions(repository);
  });
}
