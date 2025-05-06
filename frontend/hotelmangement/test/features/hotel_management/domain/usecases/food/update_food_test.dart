import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hotelmangement/core/error/failure.dart';
import 'package:hotelmangement/features/hotel_management/domain/entities/food.dart';
import 'package:hotelmangement/features/hotel_management/domain/entities/hotel.dart';
import 'package:hotelmangement/features/hotel_management/domain/repositories/hotel_food_repository.dart';
import 'package:hotelmangement/features/hotel_management/domain/usecases/food/update_food.dart';
import 'package:hotelmangement/features/hotel_management/domain/usecases/validation/hotel_authorize.dart'
    as ha;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'update_food_test.mocks.dart';

@GenerateMocks([HotelFoodRepository, ha.HotelAuthorize])
void main() {
  late HotelFoodRepository repository;
  late ha.HotelAuthorize authorize;
  late UpdateFood usecase;
  setUp(() {
    repository = MockHotelFoodRepository();
    authorize = MockHotelAuthorize();
    usecase = UpdateFood(repository: repository, hotelAuthorize: authorize);
  });

  group("hotelFood", () {
    final hotel = Hotel(
        id: "hotel123",
        managerId: "manager123",
        name: "name",
        address: "address",
        latitude: 25.45,
        longitude: 45.7);

    test('should call repository to update food when authorized', () async {
      // arrange
      const params = Params(
        managerId: 'manager123',
        hotelId: 'hotel456',
        foodId: 'food789',
        name: 'Burger',
        price: 8.99,
        available: true,
        type: 'Fast Food',
      );
      Food updatedFood = Food(
        hotelId: params.hotelId,
        id: params.foodId,
        name: params.name!,
        price: params.price!,
        availability: params.available!,
        type: params.type!,
      );
      when(authorize.call(
              ha.Params(hotelId: params.hotelId, managerId: params.managerId)))
          .thenAnswer((_) async => Right(hotel));
      when(repository.updateFood(
        foodId: params.foodId,
        name: params.name,
        price: params.price,
        available: params.available,
        type: params.type,
      )).thenAnswer((_) async => Right(updatedFood));

      // act
      final result = await usecase(params);

      // assert
      expect(result, Right(updatedFood));
      verify(authorize.call(
          ha.Params(hotelId: params.hotelId, managerId: params.managerId)));
      verify(repository.updateFood(
        foodId: params.foodId,
        name: params.name,
        price: params.price,
        available: params.available,
        type: params.type,
      ));
      verifyNoMoreInteractions(repository);
      verifyNoMoreInteractions(authorize);
    });

    test('should return failure when not authorized to update food', () async {
      // arrange
      const params = Params(
        managerId: 'manager123',
        hotelId: 'hotel456',
        foodId: 'food789',
        name: 'Burger',
        price: 8.99,
        available: true,
        type: 'Fast Food',
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
      verifyNever(repository.updateFood(
        foodId: params.foodId,
        name: params.name,
        price: params.price,
        available: params.available,
        type: params.type,
      ));
      verifyNoMoreInteractions(repository);
      verifyNoMoreInteractions(authorize);
    });

    test('should return failure when repository throws an error during update',
        () async {
      // arrange
      const params = Params(
        managerId: 'manager123',
        hotelId: 'hotel456',
        foodId: 'food789',
        name: 'Burger',
        price: 8.99,
        available: true,
        type: 'Fast Food',
      );
      when(authorize.call(
              ha.Params(hotelId: params.hotelId, managerId: params.managerId)))
          .thenAnswer((_) async => Right(hotel));
      when(repository.updateFood(
        foodId: params.foodId,
        name: params.name,
        price: params.price,
        available: params.available,
        type: params.type,
      )).thenAnswer((_) async => Left(ServerFailure()));

      // act
      final result = await usecase(params);

      // assert
      expect(result, Left(ServerFailure()));
      verify(authorize.call(
              ha.Params(hotelId: params.hotelId, managerId: params.managerId)))
          .called(1);
      verify(repository.updateFood(
        foodId: params.foodId,
        name: params.name,
        price: params.price,
        available: params.available,
        type: params.type,
      )).called(1);
      verifyNoMoreInteractions(repository);
      verifyNoMoreInteractions(authorize);
    });
  });
}
