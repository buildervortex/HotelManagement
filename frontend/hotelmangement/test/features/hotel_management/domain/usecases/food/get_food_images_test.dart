import 'package:flutter_test/flutter_test.dart';
import 'package:hotelmangement/features/hotel_management/domain/repositories/hotel_food_repository.dart';
import 'package:hotelmangement/features/hotel_management/domain/usecases/food/get_food_images.dart';
import 'package:mockito/annotations.dart';

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

  });
}
