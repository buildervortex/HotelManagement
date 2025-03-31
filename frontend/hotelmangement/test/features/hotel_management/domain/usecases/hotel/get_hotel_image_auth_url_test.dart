import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hotelmangement/features/hotel_management/domain/repositories/file_repository.dart';
import 'package:hotelmangement/features/hotel_management/domain/usecases/hotel/get_hotel_image_auth_url.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_hotel_image_auth_url_test.mocks.dart';

@GenerateMocks([FileRepository])
void main() {
  late FileRepository repository;
  late GetHotelImageAuthUrl usecase;

  setUp(() {
    repository = MockFileRepository();
    usecase = GetHotelImageAuthUrl(repository);
  });

  test(
    'should return the auth url of the hotel image from the repository',
    () async {
      // arrange
      final remoteFilePath = "hotelimage.png";
      final bucketName = "hotelimage";
      final authUrl = "https://hotelimage.com/hotelimage.png";

      when(repository.getFileAuthUrl(remoteFilePath, bucketName)).thenAnswer(
          (_) async => Right("https://hotelimage.com/hotelimage.png"));

      // act
      final result = await usecase(Params(imagePath: remoteFilePath));

      // assert
      expect(result, Right(authUrl));
      verify(repository.getFileAuthUrl(remoteFilePath, bucketName)).called(1);
      verifyNoMoreInteractions(repository);
    },
  );
}
