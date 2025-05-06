import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hotelmangement/core/error/failure.dart';
import 'package:hotelmangement/features/hotel_management/domain/entities/food_image.dart';
import 'package:hotelmangement/features/hotel_management/domain/repositories/hotel_food_repository.dart';
import 'package:hotelmangement/features/hotel_management/domain/usecases/food/get_food_images.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_food_images_test.mocks.dart';

@GenerateMocks([HotelFoodRepository])
void main() {
  late HotelFoodRepository repository;
  late GetFoodImages usecase;
  setUp(() {
    repository = MockHotelFoodRepository();
    usecase = GetFoodImages(repository: repository);
  });


  group("hotelFoodImage", (){
    final foodImages = [
      FoodImage(id: 'image1', foodId: "food1", imagePath: 'url1'),
      FoodImage(id: 'image2', foodId: "food2", imagePath: 'url2'),
    ];

    test('should get food images successfully', () async {
      // arrange
      const params = Params(foodId: 'food123');
      when(repository.getFoodImages(params.foodId))
        .thenAnswer((_) async => Right(foodImages));

      // act
      final result = await usecase(params);

      // assert
      expect(result, Right(foodImages));
      verify(repository.getFoodImages(params.foodId)).called(1);
      verifyNoMoreInteractions(repository);
    });

    test('should return failure when repository call fails', () async {
      // arrange
      const params = Params(foodId: 'food123');
      when(repository.getFoodImages(params.foodId))
        .thenAnswer((_) async => Left(ServerFailure()));

      // act
      final result = await usecase(params);

      // assert
      expect(result, Left(ServerFailure()));
      verify(repository.getFoodImages(params.foodId)).called(1);
      verifyNoMoreInteractions(repository);
    });
  });
}
