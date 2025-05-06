import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hotelmangement/features/hotel_management/domain/entities/hotel.dart';
import 'package:hotelmangement/features/hotel_management/domain/entities/room.dart';
import 'package:hotelmangement/features/hotel_management/domain/repositories/hotel_room_repository.dart';
import 'package:hotelmangement/features/hotel_management/domain/usecases/room/update_room.dart';
import 'package:hotelmangement/features/hotel_management/domain/usecases/validation/hotel_authorize.dart'
    as ha;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'update_room_test.mocks.dart';

@GenerateMocks([HotelRoomRepository, ha.HotelAuthorize])
void main() {
  late UpdateRoom usecase;
  late MockHotelRoomRepository repository;
  late MockHotelAuthorize hotelAuthorize;

  setUp(() {
    repository = MockHotelRoomRepository();
    hotelAuthorize = MockHotelAuthorize();
    usecase = UpdateRoom(repository, hotelAuthorize);
  });

  group("hotelRoom", () {
    test(
      'should call the repository to update the room and return the room object',
      () async {
        // arrange
        final params = Params(
          managerId: 'managerId',
          hotelId: 'hotelId',
          roomId: 'roomId',
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
        when(hotelAuthorize.call(any)).thenAnswer((_) async => Right(Hotel(
            id: "1",
            managerId: "1",
            name: "name",
            address: "address",
            latitude: 25.4,
            longitude: 52.5)));
        when(repository.updateRoom(
                roomId: params.roomId,
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
        verify(hotelAuthorize.call(any)).called(1);
        verify(repository.updateRoom(
          roomId: params.roomId,
          hotelId: params.hotelId,
          roomNumber: params.roomNumber,
          description: params.description,
          space: params.space,
          floor: params.floor,
          price: params.price,
        ));
        verifyNoMoreInteractions(repository);
        verifyNoMoreInteractions(hotelAuthorize);
      },
    );
  });
}
