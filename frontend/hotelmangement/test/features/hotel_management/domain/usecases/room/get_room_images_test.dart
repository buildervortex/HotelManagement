import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hotelmangement/core/error/failure.dart';
import 'package:hotelmangement/features/hotel_management/domain/entities/room_image.dart';
import 'package:hotelmangement/features/hotel_management/domain/repositories/hotel_room_repository.dart';
import 'package:hotelmangement/features/hotel_management/domain/usecases/room/get_room_images.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'add_room_image_test.mocks.dart';

@GenerateMocks([HotelRoomRepository])
void main() {
  late HotelRoomRepository repository;
  late GetRoomImages usecase;

  setUp(() {
    repository = MockHotelRoomRepository();
    usecase = GetRoomImages(repository: repository);
  });

  group("hotelRoomImage", () {
    test("should return a list of room images when the call is successful",
        () async {
      // arrange
      final roomId = "1";
      final roomImages = [
        RoomImage(id: "1", roomId: "1", imagePath: "path1.jpg"),
        RoomImage(id: "2", roomId: "1", imagePath: "path2.jpg"),
      ];
      when(repository.getRoomImages(roomId))
          .thenAnswer((_) async => Right(roomImages));

      // action
      final result = await usecase(Params(roomId: roomId));

      // assert
      expect(result, Right(roomImages));
      verify(repository.getRoomImages(roomId)).called(1);
      verifyNoMoreInteractions(repository);
    });

    test("should return a failure when the call is unsuccessful", () async {
      // arrange
      final roomId = "1";
      when(repository.getRoomImages(roomId))
          .thenAnswer((_) async => Left(ServerFailure()));

      // action
      final result = await usecase(Params(roomId: roomId));

      // assert
      expect(result, Left(ServerFailure()));
      verify(repository.getRoomImages(roomId)).called(1);
      verifyNoMoreInteractions(repository);
    });
  });
}
