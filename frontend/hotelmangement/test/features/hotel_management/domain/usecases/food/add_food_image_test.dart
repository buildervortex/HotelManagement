import 'package:flutter_test/flutter_test.dart';
import 'package:hotelmangement/features/hotel_management/domain/repositories/hotel_food_repository.dart';
import 'package:hotelmangement/features/hotel_management/domain/usecases/food/add_food_image.dart';
import 'package:hotelmangement/features/hotel_management/domain/usecases/validation/hotel_authorize.dart'
    as ha;
import 'package:mockito/annotations.dart';

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

  group("hotelFoodImage", (){

  });
}
