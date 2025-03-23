import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hotelmangement/features/hotel_management/domain/entities/hotel.dart';
import 'package:hotelmangement/features/hotel_management/domain/repositories/hotel_repository.dart';
import 'package:hotelmangement/features/hotel_management/domain/usecases/update_hotel.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'update_hotel_test.mocks.dart';

@GenerateMocks([HotelRepository])
void main() {
  late UpdateHotel usecase;
  late HotelRepository repository;

  setUp(() {
    repository = MockHotelRepository();
    usecase = UpdateHotel(repository: repository);
  });

  test("should update the hotel details and return the updated hotel entity",
      () async {
    // arrange
    final params = Params(
        hotelId: "1",
        managerId: "1",
        address: "new address",
        latitude: 10.2774);
    final hotel = Hotel(
        id: "1",
        managerId: "2",
        name: "testName",
        address: "new address",
        latitude: 10.2774,
        longitude: 5.4465);

    when(repository.updateHotel("1", "1", null, "new address", null, 10.2774))
        .thenAnswer((_) async => Right(hotel));

    // action
    final result = await usecase(params);

    // assert
    expect(Right(hotel), result);
    verify(repository.updateHotel("1", "1", any, any, any, any)).called(1);
    verifyNoMoreInteractions(repository);
  });
}
