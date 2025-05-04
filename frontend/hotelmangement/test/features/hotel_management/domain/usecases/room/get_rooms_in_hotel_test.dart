import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hotelmangement/core/error/failure.dart';
import 'package:hotelmangement/features/hotel_management/domain/entities/room.dart';
import 'package:hotelmangement/features/hotel_management/domain/repositories/hotel_room_repository.dart';
import 'package:hotelmangement/features/hotel_management/domain/usecases/room/get_rooms_in_hotel.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'update_room_test.mocks.dart';

@GenerateMocks([HotelRoomRepository])
void main() {
  late GetRoomsInHotel usecase;
  late HotelRoomRepository repository;

  setUp(() {
    repository = MockHotelRoomRepository();
    usecase = GetRoomsInHotel(repository: repository);
  });

  group("hotelRoom", () {
    test(
      'should call the repository to delete the room and return void',
      () async {
        // arrange
        final params = Params(
          hotelId: 'hotelId',
        );
        const rooms = [
          Room(
              id: "1",
              hotelId: "hotelId",
              roomNumber: "roomNumber",
              description: "description",
              floor: "f1",
              price: 24.5,
              space: "4"),
          Room(
              id: "2",
              hotelId: "hotelId",
              roomNumber: "roomNumber",
              description: "description",
              floor: "f1",
              price: 24.5,
              space: "4"),
        ];
        when(repository.getRooms(
          hotelId: params.hotelId,
        )).thenAnswer((_) async => const Right(rooms));

        // act
        final result = await usecase(params);

        // assert
        expect(result, const Right(rooms));
        verify(repository.getRooms(
          hotelId: params.hotelId,
        )).called(1);
        verifyNoMoreInteractions(repository);
      },
    );

    test(
      'should return ServerFailure when repository fails to delete the room',
      () async {
        // arrange
        final params = Params(
          hotelId: 'hotelId',
        );
        when(repository.getRooms(
          hotelId: params.hotelId,
        )).thenAnswer((_) async => Left(ServerFailure()));

        // act
        final result = await usecase(params);

        // assert
        expect(result, Left(ServerFailure()));
        verify(repository.getRooms(
          hotelId: params.hotelId,
        )).called(1);
        verifyNoMoreInteractions(repository);
      },
    );
  });
}
