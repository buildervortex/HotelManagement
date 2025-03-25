import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hotelmangement/core/error/failure.dart';
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
    final oldHotel = Hotel(
        id: "1",
        managerId: "1",
        name: "old name",
        address: "old address",
        latitude: 20.2774,
        longitude: 5.4465);
    final newHotel = Hotel(
        id: "1",
        managerId: "1",
        name: "old name",
        address: "new address",
        latitude: 10.2774,
        longitude: 5.4465);

    when(repository.getHotel(params.hotelId))
        .thenAnswer((_) async => Right(oldHotel));
    when(repository.updateHotel(params.hotelId, params.managerId, null,
            "new address", null, params.latitude, null))
        .thenAnswer((_) async => Right(newHotel));

    // action
    final result = await usecase(params);

    // assert
    expect(result, Right(newHotel));
    verify(repository.updateHotel(
            params.hotelId, params.managerId, any, any, any, any, any))
        .called(1);
    verify(repository.getHotel(params.hotelId)).called(1);
    verifyNoMoreInteractions(repository);
  });

  test(
      "should update the hotel details if the hotel id and manager id is maching",
      () async {
    // arrange
    final params = Params(
        hotelId: "14",
        managerId: "20",
        address: "new address",
        latitude: 10.2774);
    final oldHotel = Hotel(
        id: "14",
        managerId: "20",
        name: "old name",
        address: "old address",
        latitude: 20.2774,
        longitude: 5.4465);
    final newHotel = Hotel(
        id: "14",
        managerId: "20",
        name: "old name",
        address: "new address",
        latitude: 10.2774,
        longitude: 5.4465);

    when(repository.getHotel(params.hotelId))
        .thenAnswer((_) async => Right(oldHotel));
    when(repository.updateHotel(params.hotelId, params.managerId, null,
            "new address", null, params.latitude, null))
        .thenAnswer((_) async => Right(newHotel));

    // action
    final result = await usecase(params);

    // assert
    expect(result, Right(newHotel));
    verify(repository.updateHotel(
            params.hotelId, params.managerId, any, any, any, any, any))
        .called(1);
    verify(repository.getHotel(params.hotelId)).called(1);
    verifyNoMoreInteractions(repository);
  });

  test(
      "should return UnAuthorized failure if the hotelId and the managerId is not maching",
      () async {
    // arrange
    final params = Params(
        hotelId: "1",
        managerId: "11",
        address: "new address",
        latitude: 10.2774);
    final oldHotel = Hotel(
        id: "1",
        managerId: "10",
        name: "old name",
        address: "old address",
        latitude: 20.2774,
        longitude: 5.4465);

    when(repository.getHotel(params.hotelId))
        .thenAnswer((_) async => Right(oldHotel));

    // action
    final result = await usecase(params);

    // assert
    expect(result, Left(UnAuthorizedFailure()));
    verifyNever(repository.updateHotel(
        params.hotelId, params.managerId, any, any, any, any, any));
    verify(repository.getHotel(params.hotelId)).called(1);
    verifyNoMoreInteractions(repository);
  });
}
