import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hotelmangement/core/error/failure.dart';
import 'package:hotelmangement/features/hotel_management/domain/entities/food.dart';
import 'package:hotelmangement/features/hotel_management/domain/entities/hotel.dart';
import 'package:hotelmangement/features/hotel_management/domain/repositories/hotel_food_repository.dart';
import 'package:hotelmangement/features/hotel_management/domain/usecases/food/create_food.dart';
import 'package:hotelmangement/features/hotel_management/domain/usecases/validation/hotel_authorize.dart'
    as ha;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'create_food_test.mocks.dart';

@GenerateMocks([HotelFoodRepository, ha.HotelAuthorize])
void main() {
  late HotelFoodRepository repository;
  late ha.HotelAuthorize authorize;
  late CreateFood usecase;
  setUp(() {
    repository = MockHotelFoodRepository();
    authorize = MockHotelAuthorize();
    usecase = CreateFood(repository: repository, hotelAuthorize: authorize);
  });

  group("hotelFood", () {
    final hotel = Hotel(
        id: "hotel456",
        managerId: "manager123",
        name: "name",
        address: "address",
        latitude: 25.45,
        longitude: 45.7);
    test('should call repository to create food when authorized', () async {
      // arrange
      const params = Params(
        managerId: 'manager123',
        hotelId: 'hotel456',
        name: 'Pizza',
        price: 12.99,
        available: true,
        type: 'Main Course',
      );
      Food food = Food(
        hotelId: params.hotelId,
        id: 'food789',
        name: params.name,
        price: params.price,
        availability: params.available,
        type: params.type,
      );
      when(authorize.call(
              ha.Params(hotelId: params.hotelId, managerId: params.managerId)))
          .thenAnswer((_) async => Right(hotel));
      when(repository.createFood(
        hotelId: params.hotelId,
        name: params.name,
        price: params.price,
        available: params.available,
        type: params.type,
      )).thenAnswer((_) async => Right(Food(
            hotelId: params.hotelId,
            id: 'food789',
            name: params.name,
            price: params.price,
            availability: params.available,
            type: params.type,
          )));

      // act
      final result = await usecase(params);

      // assert
      expect(result, Right(food));
      verify(authorize.call(
          ha.Params(hotelId: params.hotelId, managerId: params.managerId)));
      verify(repository.createFood(
        hotelId: params.hotelId,
        name: params.name,
        price: params.price,
        available: params.available,
        type: params.type,
      ));
      verifyNoMoreInteractions(repository);
      verifyNoMoreInteractions(authorize);
    });

    test('should return failure when not authorized', () async {
      // arrange
      const params = Params(
        managerId: 'manager123',
        hotelId: 'hotel456',
        name: 'Pizza',
        price: 12.99,
        available: true,
        type: 'Main Course',
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
      verifyNever(repository.createFood(
        hotelId: params.hotelId,
        name: params.name,
        price: params.price,
        available: params.available,
        type: params.type,
      ));
      verifyNoMoreInteractions(repository);
      verifyNoMoreInteractions(authorize);
    });

    test('should return failure when repository throws an error', () async {
      // arrange
      const params = Params(
        managerId: 'manager123',
        hotelId: 'hotel456',
        name: 'Pizza',
        price: 12.99,
        available: true,
        type: 'Main Course',
      );
      when(authorize.call(
              ha.Params(hotelId: params.hotelId, managerId: params.managerId)))
          .thenAnswer((_) async => Right(hotel));
      when(repository.createFood(
        hotelId: params.hotelId,
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
      verify(repository.createFood(
        hotelId: params.hotelId,
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
