import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hotelmangement/core/error/failure.dart';
import 'package:hotelmangement/features/hotel_management/domain/entities/hotel.dart';
import 'package:hotelmangement/features/hotel_management/domain/repositories/hotel_repository.dart';
import 'package:hotelmangement/features/hotel_management/domain/usecases/hotel/delete_hotel_image.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'delete_hotel_image_test.mocks.dart';

@GenerateMocks([HotelRepository])
void main() {
  late HotelRepository repository;
  late DeleteHotelImage usecase;

  setUp(() {
    repository = MockHotelRepository();
    usecase = DeleteHotelImage(repository: repository);
  });

  test(
      "should delete the image when the manager id and the hotel id is maching",
      () async {
    // arrange
    final hotelId = "1";
    final managerId = "1";
    final imageId = "imageId";
    final params = Params(
      hotelId: hotelId,
      managerId: managerId,
      imageId: imageId,
    );

    final hotel = Hotel(
        id: "1",
        managerId: "1",
        name: "testName",
        address: "new address",
        latitude: 10.2774,
        longitude: 5.4465);

    when(repository.getHotel(hotelId)).thenAnswer((_) async => Right(hotel));
    when(repository.isImageExists(imageId, hotelId))
        .thenAnswer((_) async => true);
    when(repository.deleteHotelImage(imageId))
        .thenAnswer((_) async => Right(1));

    // action
    final result = await usecase(params);

    // assert
    expect(result, Right(1));
    verify(repository.getHotel(hotelId)).called(1);
    verify(repository.isImageExists(imageId, hotelId)).called(1);
    verify(repository.deleteHotelImage(imageId)).called(1);
    verifyNoMoreInteractions(repository);
  });

  test(
      "should not delete the image when the manager id and the hotel id is not maching",
      () async {
    // arrange
    final hotelId = "1";
    final managerId = "2";
    final imageId = "imageId";
    final params = Params(
      hotelId: hotelId,
      managerId: managerId,
      imageId: imageId,
    );

    final hotel = Hotel(
        id: "1",
        managerId: "1",
        name: "testName",
        address: "new address",
        latitude: 10.2774,
        longitude: 5.4465);

    when(repository.getHotel(hotelId)).thenAnswer((_) async => Right(hotel));

    // action
    final result = await usecase(params);

    // assert
    expect(result, Left(UnAuthorizedFailure()));
    verify(repository.getHotel(hotelId)).called(1);
    verifyNever(repository.deleteHotelImage(imageId));
    verifyNoMoreInteractions(repository);
  });
  test("should return not found failure if the image is not found in the hotel",
      () async {
    // arrange
    final hotelId = "1";
    final managerId = "1";
    final imageId = "imageId";
    final params = Params(
      hotelId: hotelId,
      managerId: managerId,
      imageId: imageId,
    );

    final hotel = Hotel(
        id: "1",
        managerId: "1",
        name: "testName",
        address: "new address",
        latitude: 10.2774,
        longitude: 5.4465);

    when(repository.getHotel(hotelId)).thenAnswer((_) async => Right(hotel));
    when(repository.isImageExists(imageId, hotelId))
        .thenAnswer((_) async => false);

    // action
    final result = await usecase(params);

    // assert
    expect(result, Left(NotFound()));
    verify(repository.getHotel(hotelId)).called(1);
    verify(repository.isImageExists(imageId, hotelId)).called(1);
    verifyNever(repository.deleteHotelImage(imageId));
    verifyNoMoreInteractions(repository);
  });
}
