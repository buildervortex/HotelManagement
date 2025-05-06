import 'package:flutter_test/flutter_test.dart';
import 'package:hotelmangement/features/hotel_management/domain/repositories/file_repository.dart';
import 'package:hotelmangement/features/hotel_management/domain/usecases/food/get_food_image_auth_url.dart';
import 'package:mockito/annotations.dart';

import 'get_food_image_auth_url_test.mocks.dart';

@GenerateMocks([FileRepository])
void main() {
  late FileRepository repository;
  late GetFoodImageAuthUrl usecase;
  setUp(() {
    repository = MockFileRepository();
    usecase = GetFoodImageAuthUrl(repository: repository);
  });

  group("hotelFoodImage", (){

  });
}
