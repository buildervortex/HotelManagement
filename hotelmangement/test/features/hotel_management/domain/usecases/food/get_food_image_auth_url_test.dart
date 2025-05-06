import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hotelmangement/core/error/failure.dart';
import 'package:hotelmangement/features/hotel_management/domain/repositories/file_repository.dart';
import 'package:hotelmangement/features/hotel_management/domain/usecases/food/get_food_image_auth_url.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

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
    const String imagePath = "path/to/image.jpg";
    const String authUrl = "https://example.com/auth-url";

    test('should return auth URL successfully', () async {
      // arrange
      const params = Params(imagePath: imagePath);
      when(repository.getFileAuthUrl(imagePath, "foodImage"))
        .thenAnswer((_) async => const Right(authUrl));

      // act
      final result = await usecase(params);

      // assert
      expect(result, const Right(authUrl));
      verify(repository.getFileAuthUrl(imagePath, "foodImage")).called(1);
      verifyNoMoreInteractions(repository);
    });

    test('should return failure when repository call fails', () async {
      // arrange
      const params = Params(imagePath: imagePath);
      when(repository.getFileAuthUrl(imagePath, "foodImage"))
        .thenAnswer((_) async => Left(ServerFailure()));

      // act
      final result = await usecase(params);

      // assert
      expect(result, Left(ServerFailure()));
      verify(repository.getFileAuthUrl(imagePath, "foodImage")).called(1);
      verifyNoMoreInteractions(repository);
    });
  });
}
