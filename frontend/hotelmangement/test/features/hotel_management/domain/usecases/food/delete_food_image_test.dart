import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hotelmangement/core/error/failure.dart';
import 'package:hotelmangement/features/hotel_management/domain/entities/hotel.dart';
import 'package:hotelmangement/features/hotel_management/domain/repositories/hotel_food_repository.dart';
import 'package:hotelmangement/features/hotel_management/domain/usecases/food/delete_food_image.dart';
import 'package:hotelmangement/features/hotel_management/domain/usecases/validation/hotel_authorize.dart'
    as ha;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'delete_food_image_test.mocks.dart';

@GenerateMocks([HotelFoodRepository, ha.HotelAuthorize])
void main() {
  late HotelFoodRepository repository;
  late ha.HotelAuthorize authorize;
  late DeleteFoodImage usecase;
  setUp(() {
    repository = MockHotelFoodRepository();
    authorize = MockHotelAuthorize();
    usecase =
        DeleteFoodImage(repository: repository, hotelAuthorize: authorize);
  });

  group("hotelFoodImage", (){
    final hotel = Hotel(
        id: "hotel123",
        managerId: "manager123",
        name: "name",
        address: "address",
        latitude: 25.45,
        longitude: 45.7);
    
    test('should delete food image successfully when authorized', () async {
      // arrange
      const params = Params(
      hotelId: 'hotel123',
      managerId: 'manager123',
      foodId: 'food123',
      imageId: 'image123',
      );
      when(authorize.call(
          ha.Params(hotelId: params.hotelId, managerId: params.managerId)))
        .thenAnswer((_) async => Right(hotel));
      when(repository.deleteFoodImage(
      params.imageId,
      params.foodId,
      )).thenAnswer((_) async => const Right(null));

      // act
      final result = await usecase(params);

      // assert
      expect(result, const Right(null));
      verify(authorize.call(
          ha.Params(hotelId: params.hotelId, managerId: params.managerId)))
        .called(1);
      verify(repository.deleteFoodImage(
      params.imageId,
      params.foodId,
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
      imageId: 'image123',
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
      verifyNever(repository.deleteFoodImage(
      params.foodId,
      params.imageId,
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
      imageId: 'image123',
      );
      when(authorize.call(
          ha.Params(hotelId: params.hotelId, managerId: params.managerId)))
        .thenAnswer((_) async => Right(hotel));
      when(repository.deleteFoodImage(
      params.imageId,
      params.foodId,
      )).thenAnswer((_) async => Left(ServerFailure()));

      // act
      final result = await usecase(params);

      // assert
      expect(result, Left(ServerFailure()));
      verify(authorize.call(
          ha.Params(hotelId: params.hotelId, managerId: params.managerId)))
        .called(1);
      verify(repository.deleteFoodImage(
      params.imageId,
      params.foodId,
      )).called(1);
      verifyNoMoreInteractions(repository);
      verifyNoMoreInteractions(authorize);
    });
  });
}
