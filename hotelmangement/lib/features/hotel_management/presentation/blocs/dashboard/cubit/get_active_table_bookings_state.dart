part of 'get_active_table_bookings_cubit.dart';

sealed class GetActiveTableBookingsState extends Equatable {
  const GetActiveTableBookingsState();

  @override
  List<Object> get props => [];
}

final class GetActiveTableBookingsInitial extends GetActiveTableBookingsState {}

final class Empty extends GetActiveTableBookingsState {}

final class Loading extends GetActiveTableBookingsState {}

final class Loaded extends GetActiveTableBookingsState {
  final List<ActiveBooking> bookings;

  const Loaded({required this.bookings});

  @override
  List<Object> get props => [bookings];
}

final class Error extends GetActiveTableBookingsState {
  final String message;

  const Error(this.message);

  @override
  List<Object> get props => [message];
}
