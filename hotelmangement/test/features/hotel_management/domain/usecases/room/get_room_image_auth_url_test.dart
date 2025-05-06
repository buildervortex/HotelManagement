import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hotelmangement/core/error/failure.dart';
import 'package:hotelmangement/features/hotel_management/domain/repositories/file_repository.dart';
import 'package:hotelmangement/features/hotel_management/domain/usecases/room/get_room_image_auth_url.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_room_image_auth_url_test.mocks.dart';

@GenerateMocks([FileRepository])
void main() {
  late FileRepository repository;
  late GetRoomImageAuthUrl usecase;

  setUp(() {
    repository = MockFileRepository();
    usecase = GetRoomImageAuthUrl(repository: repository);
  });

  group("hotelRoomImage", () {
    test("should return a valid auth URL when the repository call is successful", () async {
      // arrange
      const tImagePath = "test/path/to/image.jpg";
      const tAuthUrl = "https://example.com/auth-url";
      when(repository.getFileAuthUrl(tImagePath, "roomImage"))
        .thenAnswer((_) async => Right(tAuthUrl));
      // act
      final result = await usecase(const Params(imagePath: tImagePath));
      // assert
      expect(result, Right(tAuthUrl));
      verify(repository.getFileAuthUrl(tImagePath, "roomImage"));
      verifyNoMoreInteractions(repository);
    });

    test("should return a Failure when the repository call fails", () async {
      // arrange
      const tImagePath = "test/path/to/image.jpg";
      final tFailure = ServerFailure();
      when(repository.getFileAuthUrl(tImagePath, "roomImage"))
        .thenAnswer((_) async => Left(tFailure));
      // act
      final result = await usecase(const Params(imagePath: tImagePath));
      // assert
      expect(result, Left(tFailure));
      verify(repository.getFileAuthUrl(tImagePath, "roomImage"));
      verifyNoMoreInteractions(repository);
    });

    test("should pass the correct parameters to the repository", () async {
      // arrange
      const tImagePath = "test/path/to/image.jpg";
      const tAuthUrl = "https://example.com/auth-url";
      when(repository.getFileAuthUrl(tImagePath,"roomImage"))
        .thenAnswer((_) async => Right(tAuthUrl));
      // act
      await usecase(const Params(imagePath: tImagePath));
      // assert
      verify(repository.getFileAuthUrl(tImagePath, "roomImage"));
    });
  });
}
