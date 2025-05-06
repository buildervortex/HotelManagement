import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hotelmangement/core/error/failure.dart';
import 'package:hotelmangement/features/hotel_management/domain/entities/food_image.dart';
import 'package:hotelmangement/features/hotel_management/domain/entities/hotel.dart';
import 'package:hotelmangement/features/hotel_management/domain/repositories/hotel_food_repository.dart';
import 'package:hotelmangement/features/hotel_management/domain/usecases/food/add_food_image.dart';
import 'package:hotelmangement/features/hotel_management/domain/usecases/validation/hotel_authorize.dart'
    as ha;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'add_food_image_test.mocks.dart';

@GenerateMocks([HotelFoodRepository, ha.HotelAuthorize])
void main() {
  late HotelFoodRepository repository;
  late ha.HotelAuthorize authorize;
  late AddFoodImage usecase;
  setUp(() {
    repository = MockHotelFoodRepository();
    authorize = MockHotelAuthorize();
    usecase = AddFoodImage(repository: repository, hotelAuthorize: authorize);
  });

  group("hotelFoodImage", () {
    final hotel = Hotel(
        id: "hotel123",
        managerId: "manager123",
        name: "name",
        address: "address",
        latitude: 25.45,
        longitude: 45.7);
    test('should add food image successfully when authorized', () async {
      // arrange
      const params = Params(
        hotelId: 'hotel123',
        managerId: 'manager123',
        foodId: 'food123',
        localImagePath: '/path/to/image.jpg',
        remoteImageSaveName: 'image123.jpg',
      );
      when(authorize.call(
              ha.Params(hotelId: params.hotelId, managerId: params.managerId)))
          .thenAnswer((_) async => Right(hotel));
      when(repository.addFoodImage(
        params.foodId,
        params.localImagePath,
        params.remoteImageSaveName,
      )).thenAnswer((_) async => Right(FoodImage(
          id: 'image123', foodId: "food123", imagePath: "test path")));

      // act
      final result = await usecase(params);

      // assert
      expect(
          result,
          Right(FoodImage(
              id: 'image123', foodId: "food123", imagePath: "test path")));
      verify(authorize.call(
              ha.Params(hotelId: params.hotelId, managerId: params.managerId)))
          .called(1);
      verify(repository.addFoodImage(
        params.foodId,
        params.localImagePath,
        params.remoteImageSaveName,
      )).called(1);
      verifyNoMoreInteractions(repository);
      verifyNoMoreInteractions(authorize);
    });

    test('should return failure when authorization fails', () async {
      // arrange
      const params = Params(
        hotelId: 'hotel123',
        managerId: 'manager123',
        foodId: 'food123',
        localImagePath: '/path/to/image.jpg',
        remoteImageSaveName: 'image123.jpg',
      );
      when(authorize.call(
              ha.Params(hotelId: params.hotelId, managerId: params.managerId)))
          .thenAnswer((_) async => Left(UnAuthorizedFailure()));

      // act
      final result = await usecase(params);

      // assert
      expect(result, Left(UnAuthorizedFailure()));
      verify(authorize.call(
              ha.Params(hotelId: params.hotelId, managerId: params.managerId)))
          .called(1);
      verifyNever(repository.addFoodImage(
        params.foodId,
        params.localImagePath,
        params.remoteImageSaveName,
      ));
      verifyNoMoreInteractions(repository);
      verifyNoMoreInteractions(authorize);
    });

    test('should return failure when repository call fails', () async {
      // arrange
      const params = Params(
        hotelId: 'hotel123',
        managerId: 'manager123',
        foodId: 'food123',
        localImagePath: '/path/to/image.jpg',
        remoteImageSaveName: 'image123.jpg',
      );
      when(authorize.call(
              ha.Params(hotelId: params.hotelId, managerId: params.managerId)))
          .thenAnswer((_) async => Right(hotel));
      when(repository.addFoodImage(
        params.foodId,
        params.localImagePath,
        params.remoteImageSaveName,
      )).thenAnswer((_) async => Left(ServerFailure()));

      // act
      final result = await usecase(params);

      // assert
      expect(result, Left(ServerFailure()));
      verify(authorize.call(
              ha.Params(hotelId: params.hotelId, managerId: params.managerId)))
          .called(1);
      verify(repository.addFoodImage(
        params.foodId,
        params.localImagePath,
        params.remoteImageSaveName,
      )).called(1);
      verifyNoMoreInteractions(repository);
      verifyNoMoreInteractions(authorize);
    });
  });
}
