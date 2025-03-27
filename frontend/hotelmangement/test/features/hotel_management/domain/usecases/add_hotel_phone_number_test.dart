import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hotelmangement/features/hotel_management/domain/entities/hote_phone_number.dart';
import 'package:hotelmangement/features/hotel_management/domain/repositories/hotel_repository.dart';
import 'package:hotelmangement/features/hotel_management/domain/usecases/add_hotel_phone_number.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'add_hotel_phone_number_test.mocks.dart';

@GenerateMocks([HotelRepository])
void main() {
  late HotelRepository repository;
  late AddHotelPhoneNumber usecase;

  setUp(() {
    repository = MockHotelRepository();
    usecase = AddHotelPhoneNumber(repository: repository);
  });

  group("hotel phone number tests", () {
    test(
      'should add hotel phone number to the repository',
      () async {
        // arrange
        final hotelId = "1";
        final phoneNumber = "1234567890";
        final role = "manager";
        final managerId = "1";

        final hotelPhoneNumber = HotelPhoneNumber(
            id: "2", role: role, phoneNumber: phoneNumber, hotelId: hotelId);

        when(repository.addHotelPhoneNumber(hotelId, phoneNumber, role))
            .thenAnswer((_) async => Right(hotelPhoneNumber));

        // act
        final result = await usecase(Params(
          hotelId: hotelId,
          phoneNumber: phoneNumber,
          role: role,
          managerId: managerId,
        ));

        // assert
        expect(result, Right(hotelPhoneNumber));
        verify(repository.addHotelPhoneNumber(hotelId, phoneNumber, role))
            .called(1);
        verifyNoMoreInteractions(repository);
      },
    );
  });
}
