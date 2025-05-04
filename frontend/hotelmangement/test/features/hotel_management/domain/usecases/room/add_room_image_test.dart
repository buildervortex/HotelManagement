import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hotelmangement/core/error/failure.dart';
import 'package:hotelmangement/features/hotel_management/domain/entities/hotel.dart';
import 'package:hotelmangement/features/hotel_management/domain/entities/room_image.dart';
import 'package:hotelmangement/features/hotel_management/domain/repositories/hotel_room_repository.dart';
import 'package:hotelmangement/features/hotel_management/domain/usecases/room/add_room_image.dart';
import 'package:hotelmangement/features/hotel_management/domain/usecases/validation/hotel_authorize.dart'
    as ha;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'add_room_image_test.mocks.dart';

@GenerateMocks([HotelRoomRepository, ha.HotelAuthorize])
void main() {
  late HotelRoomRepository repository;
  late AddRoomImage usecase;
  late ha.HotelAuthorize authorize;

  setUp(() {
    repository = MockHotelRoomRepository();
    authorize = MockHotelAuthorize();
    usecase = AddRoomImage(repository: repository, hotelAuthorize: authorize);
  });

  group("hotelRoomImage", () {
    final hotel = Hotel(
        id: "hotel123",
        managerId: "manager123",
        name: "name",
        address: "address",
        latitude: 25.4,
        longitude: 45.8);
    test('should add room image successfully when authorized', () async {
      // arrange
      const params = Params(
        hotelId: 'hotel123',
        managerId: 'manager123',
        roomId: 'room123',
        localImagePath: '/path/to/image.jpg',
        remoteImageSaveName: 'image123.jpg',
      );
      when(authorize.call(
              ha.Params(hotelId: params.hotelId, managerId: params.managerId)))
          .thenAnswer((_) async => Right(hotel));
      when(repository.addRoomImage(
        params.roomId,
        params.localImagePath,
        params.remoteImageSaveName,
      )).thenAnswer((_) async => Right(RoomImage(
          id: 'image123',
          roomId: 'room123',
          imagePath: 'https://example.com/image123.jpg')));

      // act
      final result = await usecase(params);

      // assert
      expect(
          result,
          Right(RoomImage(
              id: 'image123',
              roomId: 'room123',
              imagePath: 'https://example.com/image123.jpg')));

      verify(authorize.call(
              ha.Params(managerId: params.managerId, hotelId: params.hotelId)))
          .called(1);
      verify(repository.addRoomImage(
        params.roomId,
        params.localImagePath,
        params.remoteImageSaveName,
      )).called(1);
      verifyNoMoreInteractions(repository);
      verifyNoMoreInteractions(authorize);
    });

    test('should return failure when authorization fails', () async {
      // arrange
      const params = Params(
        hotelId: 'hotel123',
        managerId: 'manager123',
        roomId: 'room123',
        localImagePath: '/path/to/image.jpg',
        remoteImageSaveName: 'image123.jpg',
      );
      when(authorize.call(
              ha.Params(hotelId: params.hotelId, managerId: params.managerId)))
          .thenAnswer((_) async => Left(UnAuthorizedFailure()));

      // act
      final result = await usecase(params);

      // assert
      expect(result, Left(UnAuthorizedFailure()));
      verify(authorize.call(
              ha.Params(managerId: params.managerId, hotelId: params.hotelId)))
          .called(1);
      verifyNever(repository.addRoomImage(
        params.roomId,
        params.localImagePath,
        params.remoteImageSaveName,
      ));
      verifyNoMoreInteractions(authorize);
    });

    test('should return failure when repository throws an error', () async {
      // arrange
      const params = Params(
        hotelId: 'hotel123',
        managerId: 'manager123',
        roomId: 'room123',
        localImagePath: '/path/to/image.jpg',
        remoteImageSaveName: 'image123.jpg',
      );
      when(authorize.call(
              ha.Params(hotelId: params.hotelId, managerId: params.managerId)))
          .thenAnswer((_) async => Right(hotel));
      when(repository.addRoomImage(
        params.roomId,
        params.localImagePath,
        params.remoteImageSaveName,
      )).thenAnswer((_) async => Left(ServerFailure()));

      // act
      final result = await usecase(params);

      // assert
      expect(result, Left(ServerFailure()));
      verify(authorize.call(
              ha.Params(hotelId: params.hotelId, managerId: params.managerId)))
          .called(1);
      verify(repository.addRoomImage(
        params.roomId,
        params.localImagePath,
        params.remoteImageSaveName,
      )).called(1);
      verifyNoMoreInteractions(repository);
      verifyNoMoreInteractions(authorize);
    });
  });
}
