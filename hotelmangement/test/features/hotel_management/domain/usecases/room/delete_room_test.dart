import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hotelmangement/core/error/failure.dart';
import 'package:hotelmangement/features/hotel_management/domain/entities/hotel.dart';
import 'package:hotelmangement/features/hotel_management/domain/repositories/hotel_room_repository.dart';
import 'package:hotelmangement/features/hotel_management/domain/usecases/room/delete_room.dart';
import 'package:hotelmangement/features/hotel_management/domain/usecases/validation/hotel_authorize.dart'
    as ha;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'update_room_test.mocks.dart';

@GenerateMocks([HotelRoomRepository, ha.HotelAuthorize])
void main() {
  late DeleteRoom usecase;
  late MockHotelRoomRepository repository;
  late MockHotelAuthorize hotelAuthorize;

  setUp(() {
    repository = MockHotelRoomRepository();
    hotelAuthorize = MockHotelAuthorize();
    usecase =
        DeleteRoom(repository: repository, hotelAuthorize: hotelAuthorize);
  });

  group("hotelRoom", () {
    test(
      'should call the repository to delete the room and return void',
      () async {
        // arrange
        final params = Params(
          managerId: 'managerId',
          roomId: 'roomId',
          hotelId: 'hotelId',
        );
        when(hotelAuthorize.call(any)).thenAnswer((_) async => Right(Hotel(
            id: "1",
            managerId: "1",
            name: "name",
            address: "address",
            latitude: 25.4,
            longitude: 52.5)));
        when(repository.deleteRoom(
          roomId: params.roomId,
          hotelId: params.hotelId,
        )).thenAnswer((_) async => const Right(null));

        // act
        final result = await usecase(params);

        // assert
        expect(result, const Right(null));
        verify(hotelAuthorize.call(any)).called(1);
        verify(repository.deleteRoom(
          roomId: params.roomId,
          hotelId: params.hotelId,
        )).called(1);
        verifyNoMoreInteractions(repository);
        verifyNoMoreInteractions(hotelAuthorize);
      },
    );

    test(
      'should return UnAuthorizedFailure when authorization fails',
      () async {
        // arrange
        final params = Params(
          managerId: 'managerId',
          roomId: 'roomId',
          hotelId: 'hotelId',
        );
        when(hotelAuthorize.call(any))
            .thenAnswer((_) async => Left(UnAuthorizedFailure()));

        // act
        final result = await usecase(params);

        // assert
        expect(result, Left(UnAuthorizedFailure()));
        verify(hotelAuthorize.call(any)).called(1);
        verifyNoMoreInteractions(repository);
      },
    );

    test(
      'should return Failure when repository fails to delete the room',
      () async {
        // arrange
        final params = Params(
          managerId: 'managerId',
          roomId: 'roomId',
          hotelId: 'hotelId',
        );
        when(hotelAuthorize.call(any)).thenAnswer((_) async => Right(Hotel(
            id: "1",
            managerId: "1",
            name: "name",
            address: "address",
            latitude: 25.4,
            longitude: 52.5)));
        when(repository.deleteRoom(
          roomId: params.roomId,
          hotelId: params.hotelId,
        )).thenAnswer((_) async => Left(ServerFailure()));

        // act
        final result = await usecase(params);

        // assert
        expect(result, Left(ServerFailure()));
        verify(hotelAuthorize.call(any)).called(1);
        verify(repository.deleteRoom(
          roomId: params.roomId,
          hotelId: params.hotelId,
        )).called(1);
        verifyNoMoreInteractions(repository);
      },
    );
  });
}
