import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
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
      when(repository.deleteHotelPhoneNumber(phoneNumberId))
          .thenAnswer((_) async => Right(1));

      // act
      final result = await usecase(Params(phoneNumberId: phoneNumberId));

      // assert
      expect(result, Right(1));
      verify(repository.deleteHotelPhoneNumber(phoneNumberId)).called(1);
      verifyNoMoreInteractions(repository);
    },
  );
}
