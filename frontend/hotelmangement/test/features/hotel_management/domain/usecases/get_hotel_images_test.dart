import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hotelmangement/features/hotel_management/domain/entities/hotel_image.dart';
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
      final hotelId = "1";
      final List<HotelImage> hotelImages = [
        HotelImage(id: "1", imagePath: 'test image path 1', hotelId: "1"),
        HotelImage(id: "2", imagePath: 'test image path 2', hotelId: "1"),
      ];

      when(repository.getHotelImages(hotelId))
          .thenAnswer((_) async => Right(hotelImages));

      // act
      final result = await usecase(Params(hotelId: hotelId));

      // assert
      expect(result, Right(hotelImages));
      verify(repository.getHotelImages(hotelId)).called(1);
      verifyNoMoreInteractions(repository);
    },
  );
}
