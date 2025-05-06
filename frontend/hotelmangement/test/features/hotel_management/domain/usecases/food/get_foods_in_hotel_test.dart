import 'package:flutter_test/flutter_test.dart';
import 'package:hotelmangement/features/hotel_management/domain/repositories/hotel_food_repository.dart';
import 'package:hotelmangement/features/hotel_management/domain/usecases/food/get_foods_in_hotel.dart';
import 'package:mockito/annotations.dart';

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

  });
}
