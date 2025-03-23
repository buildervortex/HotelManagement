import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hotelmangement/features/hotel_management/domain/entities/hotel.dart';
import 'package:hotelmangement/features/hotel_management/domain/repositories/hotel_repository.dart';
import 'package:hotelmangement/features/hotel_management/domain/usecases/get_hotel_details.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_hotel_details_test.mocks.dart';

@GenerateMocks([HotelRepository])
void main() {
  late MockHotelRepository repository;
  late GetHotelDetails usecase;

  setUp(() {
    repository = MockHotelRepository();
    usecase = GetHotelDetails(repository: repository);
  });

  test('should get hotel details from the repository', () async {
    // arrange
    final hotelId = "1";
    final hotel = Hotel(
        id: "1",
        managerId: "2",
        name: "testName",
        address: "new address",
        latitude: 10.2774,
        longitude: 5.4465);

    when(repository.getHotel(hotelId)).thenAnswer((_) async => Right(hotel));

    // action

    final result = await usecase(Params(hotelId: hotelId));

    // asserrt
    expect(Right(hotel), result);
    verify(repository.getHotel(any)).called(1);
    verifyNoMoreInteractions(repository);
  });
}
