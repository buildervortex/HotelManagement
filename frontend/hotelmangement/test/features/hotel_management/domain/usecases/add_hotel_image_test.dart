import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hotelmangement/core/error/failure.dart';
import 'package:hotelmangement/features/hotel_management/domain/entities/hotel.dart';
import 'package:hotelmangement/features/hotel_management/domain/entities/hotel_image.dart';
import 'package:hotelmangement/features/hotel_management/domain/repositories/hotel_repository.dart';
import 'package:hotelmangement/features/hotel_management/domain/usecases/add_hotel_image.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'add_hotel_image_test.mocks.dart';

@GenerateMocks([HotelRepository])
void main() {
  late HotelRepository repository;
  late AddHotelImage usecase;

  setUp(() {
    repository = MockHotelRepository();
    usecase = AddHotelImage(repository: repository);
  });

  test("should add the image if the managerId and the hotelId match", () async {
    // arrange
    final hotelId = "1";
    final managerId = "2";
    final localImagePath = "testExamplepath";
    final remoteImageSaveName = "testExample1.jpg";

    final hotel = Hotel(
        id: "1",
        managerId: "2",
        name: "testName",
        address: "new address",
        latitude: 10.2774,
        longitude: 5.4465);

    final hotelImage = HotelImage(
      id: "1",
      hotelId: "1",
      imagePath: "testExamplepath",
    );
    when(repository.getHotel(hotelId)).thenAnswer((_) async => Right(hotel));
    when(repository.addHotelImage(hotelId, localImagePath, remoteImageSaveName))
        .thenAnswer((_) async => Right(hotelImage));

    // action
    final result = await usecase(Params(
      hotelId: hotelId,
      managerId: managerId,
      localImagePath: localImagePath,
      remoteImageSaveName: remoteImageSaveName,
    ));

    // assert
    expect(result, Right(hotelImage));
    verify(repository.getHotel(hotelId)).called(1);
    verify(repository.addHotelImage(
            hotelId, localImagePath, remoteImageSaveName))
        .called(1);
    verifyNoMoreInteractions(repository);
  });

  test(
      "should return unAuhtorizedFailure if the managerId and the hotelId are not maching",
      () async {
    // arrange
    final hotelId = "1";
    final managerId = "10";
    final localImagePath = "testExamplepath";
    final remoteImageSaveName = "testExample1.jpg";
    final hotel = Hotel(
        id: "1",
        managerId: "2",
        name: "testName",
        address: "new address",
        latitude: 10.2774,
        longitude: 5.4465);
    when(repository.getHotel(hotelId)).thenAnswer((_) async => Right(hotel));

    // action
    final result = await usecase(Params(
        hotelId: hotelId,
        managerId: managerId,
        localImagePath: localImagePath,
        remoteImageSaveName: remoteImageSaveName));

    // assert
    expect(Left(UnAuthorizedFailure()), result);
    verify(repository.getHotel(hotelId)).called(1);
    verifyNever(
        repository.addHotelImage(hotelId, localImagePath, remoteImageSaveName));
    verifyNoMoreInteractions(repository);
  });
}
