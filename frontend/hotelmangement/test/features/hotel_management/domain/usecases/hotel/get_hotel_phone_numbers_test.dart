import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hotelmangement/features/hotel_management/domain/entities/hote_phone_number.dart';
import 'package:hotelmangement/features/hotel_management/domain/repositories/hotel_repository.dart';
import 'package:hotelmangement/features/hotel_management/domain/usecases/hotel/get_hotel_phone_numbers.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_hotel_phone_numbers_test.mocks.dart';

@GenerateMocks([HotelRepository])
void main() {
  late HotelRepository repository;
  late GetHotelPhoneNumbers usecase;

  setUp(() {
    repository = MockHotelRepository();
    usecase = GetHotelPhoneNumbers(repository: repository);
  });

  test(
    'should get hotel phone numbers from the repository',
    () async {
      // arrange
      final hotelId = "1";
      final List<HotelPhoneNumber> phoneNumbers = [];
      when(repository.getHotelPhoneNumbers(hotelId))
          .thenAnswer((_) async => Right(phoneNumbers));

      // act
      final result = await usecase(Params(hotelId: hotelId));

      // assert
      expect(result, Right(phoneNumbers));
      verify(repository.getHotelPhoneNumbers(hotelId)).called(1);
      verifyNoMoreInteractions(repository);
    },
  );
}
