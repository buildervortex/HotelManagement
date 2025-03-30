import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hotelmangement/core/error/failure.dart';
import 'package:hotelmangement/features/hotel_management/domain/entities/hote_phone_number.dart';
import 'package:hotelmangement/features/hotel_management/domain/entities/hotel.dart';
import 'package:hotelmangement/features/hotel_management/domain/repositories/hotel_repository.dart';
import 'package:hotelmangement/features/hotel_management/domain/usecases/delete_hotel_phone_number.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'delete_hotel_phone_number_test.mocks.dart';

@GenerateMocks([HotelRepository])
void main() {
  late HotelRepository repository;
  late DeleteHotelPhoneNumber usecase;

  setUp(() {
    repository = MockHotelRepository();
    usecase = DeleteHotelPhoneNumber(repository: repository);
  });

  test(
    'should delete hotel phone number from the repository',
    () async {
      // arrange
      final phoneNumberId = "1";
      final hotelId = "1";
      final managerId = "1";
      final hotel = Hotel(
          id: "1",
          managerId: "1",
          name: "testName",
          address: "testAddress",
          latitude: 10.0,
          longitude: 20.0);
      final hotelPhoneNumbers = [
        HotelPhoneNumber(
            id: "1", role: "testRole", phoneNumber: "0", hotelId: hotelId),
        HotelPhoneNumber(
            id: "2", role: "testRole", phoneNumber: "1", hotelId: hotelId),
        HotelPhoneNumber(
            id: "3", role: "testRole", phoneNumber: "2", hotelId: hotelId),
        HotelPhoneNumber(
            id: "4", role: "testRole", phoneNumber: "4", hotelId: hotelId),
      ];
      when(repository.deleteHotelPhoneNumber(phoneNumberId))
          .thenAnswer((_) async => Right(1));
      when(repository.getHotel(hotelId)).thenAnswer((_) async => Right(hotel));
      when(repository.getHotelPhoneNumbers(hotelId))
          .thenAnswer((_) async => Right(hotelPhoneNumbers));

      // act
      final result = await usecase(Params(
        phoneNumberId: phoneNumberId,
        hotelId: hotelId,
        managerId: managerId,
      ));

      // assert
      expect(result, Right(1));
      verify(repository.getHotel(hotelId)).called(1);
      verify(repository.getHotelPhoneNumbers(hotelId)).called(1);
      verify(repository.deleteHotelPhoneNumber(phoneNumberId)).called(1);
      verifyNoMoreInteractions(repository);
    },
  );

  test(
    'should return UnAuthorized Failure when the managerId are not maching',
    () async {
      // arrange
      final phoneNumberId = "1";
      final hotelId = "1";
      final managerId = "1";
      final hotel = Hotel(
          id: "1",
          managerId: "2",
          name: "testName",
          address: "testAddress",
          latitude: 10.0,
          longitude: 20.0);
      when(repository.getHotel(hotelId)).thenAnswer((_) async => Right(hotel));

      // act
      final result = await usecase(Params(
        phoneNumberId: phoneNumberId,
        hotelId: hotelId,
        managerId: managerId,
      ));

      // assert
      expect(result, Left(UnAuthorizedFailure()));
      verify(repository.getHotel(hotelId)).called(1);
      verifyNoMoreInteractions(repository);
    },
  );

  test(
    'should return NotFound Failure when the phoneNumberId not exists',
    () async {
      // arrange
      final phoneNumberId = "1";
      final hotelId = "1";
      final managerId = "1";
      final hotel = Hotel(
          id: "1",
          managerId: "1",
          name: "testName",
          address: "testAddress",
          latitude: 10.0,
          longitude: 20.0);
      final hotelPhoneNumbers = [
        HotelPhoneNumber(
            id: "2", role: "testRole", phoneNumber: "1", hotelId: hotelId),
        HotelPhoneNumber(
            id: "3", role: "testRole", phoneNumber: "2", hotelId: hotelId),
        HotelPhoneNumber(
            id: "4", role: "testRole", phoneNumber: "4", hotelId: hotelId),
      ];
      when(repository.getHotel(hotelId)).thenAnswer((_) async => Right(hotel));
      when(repository.getHotelPhoneNumbers(hotelId))
          .thenAnswer((_) async => Right(hotelPhoneNumbers));

      // act
      final result = await usecase(Params(
        phoneNumberId: phoneNumberId,
        hotelId: hotelId,
        managerId: managerId,
      ));

      // assert
      expect(result, Left(NotFound()));
      verify(repository.getHotel(hotelId)).called(1);
      verify(repository.getHotelPhoneNumbers(hotelId)).called(1);
      verifyNoMoreInteractions(repository);
    },
  );
}
