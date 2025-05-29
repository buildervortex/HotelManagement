part of 'hotels_bloc.dart';

sealed class HotelsState extends Equatable {
  const HotelsState();

  @override
  List<Object> get props => [];
}

final class HotelsInitial extends HotelsState {}

final class HotelLoading extends HotelsState {}

final class HotelLoaded extends HotelsState {
  final List<Hotel> hotels;

  const HotelLoaded({required this.hotels});

  @override
  List<Object> get props => [hotels];
}

final class HotelError extends HotelsState {}

final class HotelImageLoading extends HotelsState {
  final String hotelId;

  const HotelImageLoading({required this.hotelId});

  @override
  List<Object> get props => [hotelId];
}

final class HotelImageError extends HotelsState {
  final String hotelId;

  const HotelImageError({required this.hotelId});

  @override
  List<Object> get props => [hotelId];
}

final class HotelImageLoaded extends HotelsState {
  final List<HotelImage> images;
  final String hotelId;

  const HotelImageLoaded({required this.hotelId, required this.images});

  @override
  List<Object> get props => [images, hotelId];
}

final class HotelPhoneNumberLoaded extends HotelsState {
  final List<HotelPhoneNumber> phoneNumbers;
  final String hotelId;

  const HotelPhoneNumberLoaded(
      {required this.phoneNumbers, required this.hotelId});

  @override
  List<Object> get props => [phoneNumbers, hotelId];
}
