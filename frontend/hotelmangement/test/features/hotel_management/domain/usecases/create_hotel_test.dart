import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hotelmangement/features/hotel_management/domain/entities/hotel.dart';
import 'package:hotelmangement/features/hotel_management/domain/repositories/hotel_repository.dart';
import 'package:hotelmangement/features/hotel_management/domain/usecases/create_hotel.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'create_hotel_test.mocks.dart';

@GenerateMocks([HotelRepository])
void main() {
  late CreateHotel usecase;
  late MockHotelRepository mockHotelRepository;

  setUp(() {
    mockHotelRepository = MockHotelRepository();
    usecase = CreateHotel(repository: mockHotelRepository);
  });

  test("", () async {
    // arrange
    final Hotel hotel = Hotel(
      address: "testAddress",
      id: "testid",
      latitude: 2.5685,
      longitude: 5.6887,
      managerId: "testid1",
      name: "test name",
    );

    final Params params = Params(
      address: "testAddress",
      latitude: 2.5685,
      longitude: 2.5685,
      name: "test name",
      managerId: "testid1",
    );

    when(mockHotelRepository.createHotel(params.name, params.address,
            params.longitude, params.latitude, params.managerId))
        .thenAnswer((_) async => Right(hotel));

    // action
    final result = await usecase(params);

    // assert
    expect(Right(hotel), result);
    verify(mockHotelRepository.createHotel(any, any, any, any, any)).called(1);
    verifyNoMoreInteractions(mockHotelRepository);
  });
}
