import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hotelmangement/features/hotel_management/domain/entities/hotel.dart';
import 'package:hotelmangement/features/hotel_management/domain/repositories/hotel_repository.dart';
import 'package:hotelmangement/features/hotel_management/domain/usecases/delete_hotel_image.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'delete_hotel_image_test.mocks.dart';

@GenerateMocks([HotelRepository])
void main() {
  late MockHotelRepository repository;
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
    final imagePath = "imagePath";
    final params = Params(
      hotelId: hotelId,
      managerId: managerId,
      imagePath: imagePath,
    );

    final hotel = Hotel(
        id: "1",
        managerId: "1",
        name: "testName",
        address: "new address",
        latitude: 10.2774,
        longitude: 5.4465);

    when(repository.getHotel(hotelId)).thenAnswer((_) async => Right(hotel));
    when(repository.deleteHotelImage(hotelId, managerId, imagePath))
        .thenAnswer((_) async => Right(1));

    // action
    final result = await usecase(params);

    // assert
    expect(result, Right(1));
    verify(repository.getHotel(hotelId));
    verify(repository.deleteHotelImage(hotelId, managerId, imagePath));
    verifyNoMoreInteractions(repository);
  });
}
