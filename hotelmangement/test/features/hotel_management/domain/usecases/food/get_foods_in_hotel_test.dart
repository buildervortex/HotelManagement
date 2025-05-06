import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hotelmangement/core/error/failure.dart';
import 'package:hotelmangement/features/hotel_management/domain/entities/food.dart';
import 'package:hotelmangement/features/hotel_management/domain/repositories/hotel_food_repository.dart';
import 'package:hotelmangement/features/hotel_management/domain/usecases/food/get_foods_in_hotel.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_foods_in_hotel_test.mocks.dart';

@GenerateMocks([HotelFoodRepository])
void main() {
  late HotelFoodRepository repository;
  late GetFoodsInHotel usecase;
  setUp(() {
    repository = MockHotelFoodRepository();
    usecase = GetFoodsInHotel(repository: repository);
  });

  group("hotelFood", (){
    final params = Params(hotelId: 'hotel123');
    final foods = [
      Food(id: 'food1', name: 'Pizza', price: 10.0,availability: true,hotelId: "hotelId",type: "type1"),
      Food(id: 'food2', name: 'Pizza1', price: 20.0,availability: true,hotelId: "hotelId",type: "type2"),
    ];

    test('should get list of foods from the repository', () async {
      // arrange
      when(repository.getFoods(hotelId: params.hotelId))
        .thenAnswer((_) async => Right(foods));

      // act
      final result = await usecase(params);

      // assert
      expect(result, Right(foods));
      verify(repository.getFoods(hotelId: params.hotelId)).called(1);
      verifyNoMoreInteractions(repository);
    });

    test('should return failure when repository fails', () async {
      // arrange
      when(repository.getFoods(hotelId: params.hotelId))
        .thenAnswer((_) async => Left(ServerFailure()));

      // act
      final result = await usecase(params);

      // assert
      expect(result, Left(ServerFailure()));
      verify(repository.getFoods(hotelId: params.hotelId)).called(1);
      verifyNoMoreInteractions(repository);
    });
  });
}
