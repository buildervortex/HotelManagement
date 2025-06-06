// Mocks generated by Mockito 5.4.5 from annotations
// in hotelmangement/test/features/hotel_management/domain/usecases/room/get_room_images_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:dartz/dartz.dart' as _i2;
import 'package:hotelmangement/core/error/failure.dart' as _i5;
import 'package:hotelmangement/features/hotel_management/domain/entities/room.dart'
    as _i6;
import 'package:hotelmangement/features/hotel_management/domain/entities/room_image.dart'
    as _i7;
import 'package:hotelmangement/features/hotel_management/domain/repositories/hotel_room_repository.dart'
    as _i3;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: must_be_immutable
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeEither_0<L, R> extends _i1.SmartFake implements _i2.Either<L, R> {
  _FakeEither_0(Object parent, Invocation parentInvocation)
    : super(parent, parentInvocation);
}

/// A class which mocks [HotelRoomRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockHotelRoomRepository extends _i1.Mock
    implements _i3.HotelRoomRepository {
  MockHotelRoomRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.Either<_i5.Failure, _i6.Room>> createRoom({
    required String? hotelId,
    required String? roomNumber,
    required String? description,
    required String? space,
    required String? floor,
    required double? price,
  }) =>
      (super.noSuchMethod(
            Invocation.method(#createRoom, [], {
              #hotelId: hotelId,
              #roomNumber: roomNumber,
              #description: description,
              #space: space,
              #floor: floor,
              #price: price,
            }),
            returnValue: _i4.Future<_i2.Either<_i5.Failure, _i6.Room>>.value(
              _FakeEither_0<_i5.Failure, _i6.Room>(
                this,
                Invocation.method(#createRoom, [], {
                  #hotelId: hotelId,
                  #roomNumber: roomNumber,
                  #description: description,
                  #space: space,
                  #floor: floor,
                  #price: price,
                }),
              ),
            ),
          )
          as _i4.Future<_i2.Either<_i5.Failure, _i6.Room>>);

  @override
  _i4.Future<_i2.Either<_i5.Failure, _i6.Room>> updateRoom({
    required String? roomId,
    required String? hotelId,
    String? roomNumber,
    String? description,
    String? space,
    String? floor,
    double? price,
  }) =>
      (super.noSuchMethod(
            Invocation.method(#updateRoom, [], {
              #roomId: roomId,
              #hotelId: hotelId,
              #roomNumber: roomNumber,
              #description: description,
              #space: space,
              #floor: floor,
              #price: price,
            }),
            returnValue: _i4.Future<_i2.Either<_i5.Failure, _i6.Room>>.value(
              _FakeEither_0<_i5.Failure, _i6.Room>(
                this,
                Invocation.method(#updateRoom, [], {
                  #roomId: roomId,
                  #hotelId: hotelId,
                  #roomNumber: roomNumber,
                  #description: description,
                  #space: space,
                  #floor: floor,
                  #price: price,
                }),
              ),
            ),
          )
          as _i4.Future<_i2.Either<_i5.Failure, _i6.Room>>);

  @override
  _i4.Future<_i2.Either<_i5.Failure, void>> deleteRoom({
    required String? roomId,
    required String? hotelId,
  }) =>
      (super.noSuchMethod(
            Invocation.method(#deleteRoom, [], {
              #roomId: roomId,
              #hotelId: hotelId,
            }),
            returnValue: _i4.Future<_i2.Either<_i5.Failure, void>>.value(
              _FakeEither_0<_i5.Failure, void>(
                this,
                Invocation.method(#deleteRoom, [], {
                  #roomId: roomId,
                  #hotelId: hotelId,
                }),
              ),
            ),
          )
          as _i4.Future<_i2.Either<_i5.Failure, void>>);

  @override
  _i4.Future<_i2.Either<_i5.Failure, List<_i6.Room>>> getRooms({
    required String? hotelId,
  }) =>
      (super.noSuchMethod(
            Invocation.method(#getRooms, [], {#hotelId: hotelId}),
            returnValue:
                _i4.Future<_i2.Either<_i5.Failure, List<_i6.Room>>>.value(
                  _FakeEither_0<_i5.Failure, List<_i6.Room>>(
                    this,
                    Invocation.method(#getRooms, [], {#hotelId: hotelId}),
                  ),
                ),
          )
          as _i4.Future<_i2.Either<_i5.Failure, List<_i6.Room>>>);

  @override
  _i4.Future<_i2.Either<_i5.Failure, _i7.RoomImage>> addRoomImage(
    String? roomId,
    String? localImagePath,
    String? remoteImageSaveName,
  ) =>
      (super.noSuchMethod(
            Invocation.method(#addRoomImage, [
              roomId,
              localImagePath,
              remoteImageSaveName,
            ]),
            returnValue:
                _i4.Future<_i2.Either<_i5.Failure, _i7.RoomImage>>.value(
                  _FakeEither_0<_i5.Failure, _i7.RoomImage>(
                    this,
                    Invocation.method(#addRoomImage, [
                      roomId,
                      localImagePath,
                      remoteImageSaveName,
                    ]),
                  ),
                ),
          )
          as _i4.Future<_i2.Either<_i5.Failure, _i7.RoomImage>>);

  @override
  _i4.Future<bool> isImageExists(String? imageId, String? roomId) =>
      (super.noSuchMethod(
            Invocation.method(#isImageExists, [imageId, roomId]),
            returnValue: _i4.Future<bool>.value(false),
          )
          as _i4.Future<bool>);

  @override
  _i4.Future<_i2.Either<_i5.Failure, List<_i7.RoomImage>>> getRoomImages(
    String? roomId,
  ) =>
      (super.noSuchMethod(
            Invocation.method(#getRoomImages, [roomId]),
            returnValue:
                _i4.Future<_i2.Either<_i5.Failure, List<_i7.RoomImage>>>.value(
                  _FakeEither_0<_i5.Failure, List<_i7.RoomImage>>(
                    this,
                    Invocation.method(#getRoomImages, [roomId]),
                  ),
                ),
          )
          as _i4.Future<_i2.Either<_i5.Failure, List<_i7.RoomImage>>>);

  @override
  _i4.Future<_i2.Either<_i5.Failure, void>> deleteRoomImage(String? imageId) =>
      (super.noSuchMethod(
            Invocation.method(#deleteRoomImage, [imageId]),
            returnValue: _i4.Future<_i2.Either<_i5.Failure, void>>.value(
              _FakeEither_0<_i5.Failure, void>(
                this,
                Invocation.method(#deleteRoomImage, [imageId]),
              ),
            ),
          )
          as _i4.Future<_i2.Either<_i5.Failure, void>>);
}
