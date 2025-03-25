// Mocks generated by Mockito 5.4.5 from annotations
// in hotelmangement/test/features/hotel_management/domain/usecases/create_hotel_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:dartz/dartz.dart' as _i2;
import 'package:hotelmangement/core/error/failure.dart' as _i5;
import 'package:hotelmangement/features/hotel_management/domain/entities/hotel.dart'
    as _i6;
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
}
