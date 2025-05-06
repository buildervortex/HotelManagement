import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hotelmangement/features/hotel_management/domain/entities/room.dart';
import 'package:hotelmangement/features/hotel_management/domain/repositories/hotel_room_repository.dart';
import 'package:hotelmangement/features/hotel_management/domain/usecases/room/create_room.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'create_room_test.mocks.dart';

@GenerateMocks([HotelRoomRepository])
void main() {
  late CreateRoom usecase;
  late HotelRoomRepository repository;

    setUp(() {
    repository = MockHotelRoomRepository();
    usecase = CreateRoom(repository);
  });

  group("hotelRoom", () {
    test(
      'should call the repository to create the room and return the room object',
      () async {
        // arrange
        final params = Params(
          hotelId: 'hotelId',
          roomNumber: '101',
          description: 'A cozy room',
          space: '20m2',
          floor: '1',
          price: 100.0,
        );
        final room = Room(
          id: 'roomId',
          hotelId: 'hotelId',
          roomNumber: '101',
          description: 'A cozy room',
          space: '20m2',
          floor: '1',
          price: 100.0,
        );
        when(repository.createRoom(
                hotelId: params.hotelId,
                roomNumber: params.roomNumber,
                description: params.description,
                space: params.space,
                floor: params.floor,
                price: params.price))
            .thenAnswer((_) async => Right(room));

        // act
        final result = await usecase(params);

        // assert
        expect(result, Right(room));
        verify(repository.createRoom(
          hotelId: params.hotelId,
          roomNumber: params.roomNumber,
          description: params.description,
          space: params.space,
          floor: params.floor,
          price: params.price,
        )).called(1);
        verifyNoMoreInteractions(repository);
      },
    );
  });
}
