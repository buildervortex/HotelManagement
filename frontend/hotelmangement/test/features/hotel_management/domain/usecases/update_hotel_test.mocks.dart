// Mocks generated by Mockito 5.4.5 from annotations
// in hotelmangement/test/features/hotel_management/domain/usecases/update_hotel_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:dartz/dartz.dart' as _i2;
import 'package:hotelmangement/core/error/failure.dart' as _i5;
import 'package:hotelmangement/features/hotel_management/domain/entities/hote_phone_number.dart'
    as _i8;
import 'package:hotelmangement/features/hotel_management/domain/entities/hotel.dart'
    as _i6;
import 'package:hotelmangement/features/hotel_management/domain/entities/hotel_image.dart'
    as _i7;
import 'package:hotelmangement/features/hotel_management/domain/repositories/hotel_repository.dart'
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

/// A class which mocks [HotelRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockHotelRepository extends _i1.Mock implements _i3.HotelRepository {
  MockHotelRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.Either<_i5.Failure, _i6.Hotel>> createHotel(
    String? name,
    String? address,
    double? longitude,
    double? latitude,
    String? managerId,
  ) =>
      (super.noSuchMethod(
            Invocation.method(#createHotel, [
              name,
              address,
              longitude,
              latitude,
              managerId,
            ]),
            returnValue: _i4.Future<_i2.Either<_i5.Failure, _i6.Hotel>>.value(
              _FakeEither_0<_i5.Failure, _i6.Hotel>(
                this,
                Invocation.method(#createHotel, [
                  name,
                  address,
                  longitude,
                  latitude,
                  managerId,
                ]),
              ),
            ),
          )
          as _i4.Future<_i2.Either<_i5.Failure, _i6.Hotel>>);

  @override
  _i4.Future<_i2.Either<_i5.Failure, _i6.Hotel>> updateHotel(
    String? hotelId,
    String? managerId,
    String? name,
    String? address,
    double? longitude,
    double? latitude,
    String? mainImage,
  ) =>
      (super.noSuchMethod(
            Invocation.method(#updateHotel, [
              hotelId,
              managerId,
              name,
              address,
              longitude,
              latitude,
              mainImage,
            ]),
            returnValue: _i4.Future<_i2.Either<_i5.Failure, _i6.Hotel>>.value(
              _FakeEither_0<_i5.Failure, _i6.Hotel>(
                this,
                Invocation.method(#updateHotel, [
                  hotelId,
                  managerId,
                  name,
                  address,
                  longitude,
                  latitude,
                  mainImage,
                ]),
              ),
            ),
          )
          as _i4.Future<_i2.Either<_i5.Failure, _i6.Hotel>>);

  @override
  _i4.Future<_i2.Either<_i5.Failure, _i6.Hotel>> getHotel(String? hotelId) =>
      (super.noSuchMethod(
            Invocation.method(#getHotel, [hotelId]),
            returnValue: _i4.Future<_i2.Either<_i5.Failure, _i6.Hotel>>.value(
              _FakeEither_0<_i5.Failure, _i6.Hotel>(
                this,
                Invocation.method(#getHotel, [hotelId]),
              ),
            ),
          )
          as _i4.Future<_i2.Either<_i5.Failure, _i6.Hotel>>);

  @override
  _i4.Future<_i2.Either<_i5.Failure, int>> deleteHotel(
    String? hotelId,
    String? managerId,
  ) =>
      (super.noSuchMethod(
            Invocation.method(#deleteHotel, [hotelId, managerId]),
            returnValue: _i4.Future<_i2.Either<_i5.Failure, int>>.value(
              _FakeEither_0<_i5.Failure, int>(
                this,
                Invocation.method(#deleteHotel, [hotelId, managerId]),
              ),
            ),
          )
          as _i4.Future<_i2.Either<_i5.Failure, int>>);

  @override
  _i4.Future<_i2.Either<_i5.Failure, _i7.HotelImage>> addHotelImage(
    String? hotelId,
    String? managerId,
    String? localImagePath,
    String? remoteImageSaveName,
  ) =>
      (super.noSuchMethod(
            Invocation.method(#addHotelImage, [
              hotelId,
              managerId,
              localImagePath,
              remoteImageSaveName,
            ]),
            returnValue:
                _i4.Future<_i2.Either<_i5.Failure, _i7.HotelImage>>.value(
                  _FakeEither_0<_i5.Failure, _i7.HotelImage>(
                    this,
                    Invocation.method(#addHotelImage, [
                      hotelId,
                      managerId,
                      localImagePath,
                      remoteImageSaveName,
                    ]),
                  ),
                ),
          )
          as _i4.Future<_i2.Either<_i5.Failure, _i7.HotelImage>>);

  @override
  _i4.Future<bool> isImageExists(String? imageId, String? hotelId) =>
      (super.noSuchMethod(
            Invocation.method(#isImageExists, [imageId, hotelId]),
            returnValue: _i4.Future<bool>.value(false),
          )
          as _i4.Future<bool>);

  @override
  _i4.Future<_i2.Either<_i5.Failure, List<_i7.HotelImage>>> getHotelImages(
    String? hotelId,
  ) =>
      (super.noSuchMethod(
            Invocation.method(#getHotelImages, [hotelId]),
            returnValue:
                _i4.Future<_i2.Either<_i5.Failure, List<_i7.HotelImage>>>.value(
                  _FakeEither_0<_i5.Failure, List<_i7.HotelImage>>(
                    this,
                    Invocation.method(#getHotelImages, [hotelId]),
                  ),
                ),
          )
          as _i4.Future<_i2.Either<_i5.Failure, List<_i7.HotelImage>>>);

  @override
  _i4.Future<_i2.Either<_i5.Failure, int>> deleteHotelImage(
    String? hotelId,
    String? managerId,
    String? imageId,
  ) =>
      (super.noSuchMethod(
            Invocation.method(#deleteHotelImage, [hotelId, managerId, imageId]),
            returnValue: _i4.Future<_i2.Either<_i5.Failure, int>>.value(
              _FakeEither_0<_i5.Failure, int>(
                this,
                Invocation.method(#deleteHotelImage, [
                  hotelId,
                  managerId,
                  imageId,
                ]),
              ),
            ),
          )
          as _i4.Future<_i2.Either<_i5.Failure, int>>);

  @override
  _i4.Future<_i2.Either<_i5.Failure, List<_i8.HotelPhoneNumber>>>
  getHotelPhoneNumbers(String? hotelId) =>
      (super.noSuchMethod(
            Invocation.method(#getHotelPhoneNumbers, [hotelId]),
            returnValue: _i4.Future<
              _i2.Either<_i5.Failure, List<_i8.HotelPhoneNumber>>
            >.value(
              _FakeEither_0<_i5.Failure, List<_i8.HotelPhoneNumber>>(
                this,
                Invocation.method(#getHotelPhoneNumbers, [hotelId]),
              ),
            ),
          )
          as _i4.Future<_i2.Either<_i5.Failure, List<_i8.HotelPhoneNumber>>>);

  @override
  _i4.Future<_i2.Either<_i5.Failure, int>> deleteHotelPhoneNumber(
    String? phoneNumberId,
  ) =>
      (super.noSuchMethod(
            Invocation.method(#deleteHotelPhoneNumber, [phoneNumberId]),
            returnValue: _i4.Future<_i2.Either<_i5.Failure, int>>.value(
              _FakeEither_0<_i5.Failure, int>(
                this,
                Invocation.method(#deleteHotelPhoneNumber, [phoneNumberId]),
              ),
            ),
          )
          as _i4.Future<_i2.Either<_i5.Failure, int>>);

  @override
  _i4.Future<_i2.Either<_i5.Failure, _i8.HotelPhoneNumber>> addHotelPhoneNumber(
    String? hotelId,
    String? managerId,
    String? phoneNumber,
    String? role,
  ) =>
      (super.noSuchMethod(
            Invocation.method(#addHotelPhoneNumber, [
              hotelId,
              managerId,
              phoneNumber,
              role,
            ]),
            returnValue:
                _i4.Future<_i2.Either<_i5.Failure, _i8.HotelPhoneNumber>>.value(
                  _FakeEither_0<_i5.Failure, _i8.HotelPhoneNumber>(
                    this,
                    Invocation.method(#addHotelPhoneNumber, [
                      hotelId,
                      managerId,
                      phoneNumber,
                      role,
                    ]),
                  ),
                ),
          )
          as _i4.Future<_i2.Either<_i5.Failure, _i8.HotelPhoneNumber>>);
}
