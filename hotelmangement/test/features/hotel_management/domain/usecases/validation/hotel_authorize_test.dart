import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hotelmangement/core/error/failure.dart';
import 'package:hotelmangement/features/hotel_management/domain/entities/hotel.dart';
import 'package:hotelmangement/features/hotel_management/domain/repositories/hotel_repository.dart';
import 'package:hotelmangement/features/hotel_management/domain/usecases/validation/hotel_authorize.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../hotel/get_hotel_details_test.mocks.dart';

@GenerateMocks([HotelRepository])
void main() {
  late HotelAuthorize usecase;
  late HotelRepository repository;

  setUp(() {
    repository = MockHotelRepository();
    usecase = HotelAuthorize(repository);
  });

  group("hotelAuthorize", () {
    const hotelId = 'hotelId';
    const managerId = 'managerId';

    test(
      'should call the repository to get the hotel and return the hotel object',
      () async {
        // arrange
        final params = Params(hotelId: hotelId, managerId: managerId);
        final hotel = Hotel(
          id: hotelId,
          name: 'Hotel Name',
          address: 'Hotel Address',
          longitude: 0.0,
          latitude: 0.0,
          mainImage: 'image_url',
          managerId: managerId,
        );
        when(repository.getHotel(hotelId))
            .thenAnswer((_) async => Right(hotel));

        // act
        final result = await usecase(params);

        // assert
        expect(result, Right(hotel));
        verify(repository.getHotel(hotelId));
        verifyNoMoreInteractions(repository);
      },
    );

    test(
      'should return UnAuthorizedFailure when the user is not authorized',
      () async {
        // arrange
        final params = Params(hotelId: hotelId, managerId: 'wrongManagerId');
        final hotel = Hotel(
          id: hotelId,
          name: 'Hotel Name',
          address: 'Hotel Address',
          longitude: 0.0,
          latitude: 0.0,
          mainImage: 'image_url',
          managerId: managerId,
        );
        when(repository.getHotel(hotelId))
            .thenAnswer((_) async => Right(hotel));

        // act
        final result = await usecase(params);

        // assert
        expect(result, Left(UnAuthorizedFailure()));
        verify(repository.getHotel(hotelId));
        verifyNoMoreInteractions(repository);
      },
    );
  });
}
