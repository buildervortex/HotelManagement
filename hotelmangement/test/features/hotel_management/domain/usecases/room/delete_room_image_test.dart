import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hotelmangement/core/error/failure.dart';
import 'package:hotelmangement/features/hotel_management/domain/entities/hotel.dart';
import 'package:hotelmangement/features/hotel_management/domain/repositories/hotel_room_repository.dart';
import 'package:hotelmangement/features/hotel_management/domain/usecases/room/delete_room_image.dart';
import 'package:hotelmangement/features/hotel_management/domain/usecases/validation/hotel_authorize.dart'
    as ha;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'delete_room_image_test.mocks.dart';

@GenerateMocks([HotelRoomRepository, ha.HotelAuthorize])
void main() {
  late HotelRoomRepository repository;
  late DeleteRoomImage usecase;
  late ha.HotelAuthorize authorize;

  setUp(() {
    repository = MockHotelRoomRepository();
    authorize = MockHotelAuthorize();
    usecase =
        DeleteRoomImage(repository: repository, hotelAuthorize: authorize);
  });

  group("hotelRoomImage", () {
    final hotel = Hotel(
        id: "hotel123",
        managerId: "manager123",
        name: "name",
        address: "address",
        latitude: 25.4,
        longitude: 45.8);
    test('should delete the room image when image exists', () async {
      // arrange
      const params = Params(
        hotelId: 'hotel1',
        managerId: 'manager1',
        roomId: 'room1',
        imageId: 'image1',
      );
      when(authorize.call(
              ha.Params(hotelId: params.hotelId, managerId: params.managerId)))
          .thenAnswer((_) async => Right(hotel));
      when(repository.isImageExists(params.imageId, params.roomId))
          .thenAnswer((_) async => true);
      when(repository.deleteRoomImage(params.imageId))
          .thenAnswer((_) async => const Right(null));

      // act
      final result = await usecase(params);

      // assert
      expect(result, const Right(null));
      verify(authorize.call(ha.Params(hotelId: params.hotelId, managerId: params.managerId))).called(1);
      verify(repository.isImageExists(params.imageId, params.roomId)).called(1);
      verify(repository.deleteRoomImage(params.imageId)).called(1);
      verifyNoMoreInteractions(repository);
      verifyNoMoreInteractions(authorize);
    });

    test('should return NotFound failure when image does not exist', () async {
      // arrange
      const params = Params(
        hotelId: 'hotel1',
        managerId: 'manager1',
        roomId: 'room1',
        imageId: 'image1',
      );
      when(authorize.call(
              ha.Params(hotelId: params.hotelId, managerId: params.managerId)))
          .thenAnswer((_) async => Right(hotel));
      when(repository.isImageExists(params.imageId, params.roomId))
          .thenAnswer((_) async => false);

      // act
      final result = await usecase(params);

      // assert
      expect(result, Left(NotFound()));
      verify(authorize.call(ha.Params(hotelId: params.hotelId, managerId: params.managerId))).called(1);
      verify(repository.isImageExists(params.imageId, params.roomId)).called(1);
      verifyNoMoreInteractions(repository);
      verifyNoMoreInteractions(authorize);
    });

    test('should return Unauthorized failure when authorization fails',
        () async {
      // arrange
      const params = Params(
        hotelId: 'hotel1',
        managerId: 'manager1',
        roomId: 'room1',
        imageId: 'image1',
      );
      when(authorize.call(
              ha.Params(hotelId: params.hotelId, managerId: params.managerId)))
          .thenAnswer((_) async => Left(UnAuthorizedFailure()));

      // act
      final result = await usecase(params);

      // assert
      expect(result, Left(UnAuthorizedFailure()));
      verify(authorize.call(
          ha.Params(hotelId: params.hotelId, managerId: params.managerId))).called(1);
      verifyNoMoreInteractions(repository);
      verifyNoMoreInteractions(authorize);
    });

    test('should return ServerFailure when deleteRoomImage fails', () async {
      // arrange
      const params = Params(
      hotelId: 'hotel1',
      managerId: 'manager1',
      roomId: 'room1',
      imageId: 'image1',
      );
      when(authorize.call(
          ha.Params(hotelId: params.hotelId, managerId: params.managerId)))
        .thenAnswer((_) async => Right(hotel));
      when(repository.isImageExists(params.imageId, params.roomId))
        .thenAnswer((_) async => true);
      when(repository.deleteRoomImage(params.imageId))
        .thenAnswer((_) async => Left(ServerFailure()));

      // act
      final result = await usecase(params);

      // assert
      expect(result, Left(ServerFailure()));
      verify(authorize.call(ha.Params(hotelId: params.hotelId, managerId: params.managerId))).called(1);
      verify(repository.isImageExists(params.imageId, params.roomId)).called(1);
      verify(repository.deleteRoomImage(params.imageId)).called(1);
      verifyNoMoreInteractions(repository);
      verifyNoMoreInteractions(authorize);
    });
  });
}
