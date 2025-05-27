part of 'hotel_management_bloc.dart';

sealed class HotelManagementState extends Equatable {
  const HotelManagementState();

  @override
  List<Object> get props => [];
}

final class Empty extends HotelManagementState {}

final class Loading extends HotelManagementState {}

final class HotelListLoaded extends HotelManagementState {
  final List<Hotel> hotels;

  const HotelListLoaded(this.hotels);

  @override
  List<Object> get props => [hotels];
}

final class HotelLoaded extends HotelManagementState {
  final Hotel hotel;

  const HotelLoaded(this.hotel);

  @override
  List<Object> get props => [hotel];
}

final class HotelAdded extends HotelManagementState {
  final Hotel hotel;

  const HotelAdded(this.hotel);

  @override
  List<Object> get props => [hotel];
}

final class HotelUpdated extends HotelManagementState {
  final Hotel hotel;

  const HotelUpdated(this.hotel);

  @override
  List<Object> get props => [hotel];
}

final class HotelDeleted extends HotelManagementState {
  final String hotelId;

  const HotelDeleted(this.hotelId);

  @override
  List<Object> get props => [hotelId];
}

final class Error extends HotelManagementState {
  final String message;

  const Error(this.message);

  @override
  List<Object> get props => [message];
}
