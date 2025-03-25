import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hotelmangement/features/hotel_management/domain/repositories/hotel_repository.dart';
import 'package:hotelmangement/features/hotel_management/domain/usecases/get_hotel_images.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_hotel_images_test.mocks.dart';

@GenerateMocks([HotelRepository])
void main() {
  late MockHotelRepository repository;
  late GetHotelImages usecase;

  setUp(() {
    repository = MockHotelRepository();
    usecase = GetHotelImages(repository: repository);
  });

  test(
    'should call the hotel repository to get hotel images',
    () async {
      // arrange
      final imageNames = ["imageUrl1", "imageUrl2"];
      final params = Params(imageNames: ["image1", "image2"]);

      when(repository.getHotelImages(params.imageNames))
          .thenAnswer((_) async => Right(imageNames));

      // act
      final result = await usecase(params);

      // assert
      expect(result, Right(imageNames));
      verify(repository.getHotelImages(params.imageNames)).called(1);
      verifyNoMoreInteractions(repository);
    },
  );
}
