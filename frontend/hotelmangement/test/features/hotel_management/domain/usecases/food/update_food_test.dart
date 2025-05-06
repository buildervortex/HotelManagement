import 'package:flutter_test/flutter_test.dart';
import 'package:hotelmangement/features/hotel_management/domain/entities/hotel.dart';
import 'package:hotelmangement/features/hotel_management/domain/repositories/hotel_food_repository.dart';
import 'package:hotelmangement/features/hotel_management/domain/usecases/food/update_food.dart';
import 'package:hotelmangement/features/hotel_management/domain/usecases/validation/hotel_authorize.dart'
    as ha;
import 'package:mockito/annotations.dart';

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

  group("hotelFood", (){
    final hotel = Hotel(
        id: "hotel123",
        managerId: "manager123",
        name: "name",
        address: "address",
        latitude: 25.45,
        longitude: 45.7);

  });
}
