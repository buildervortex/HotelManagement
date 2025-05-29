part of 'get_active_table_bookings_cubit.dart';

sealed class GetActiveTableBookingsState extends Equatable {
  const GetActiveTableBookingsState();

  @override
  List<Object> get props => [];
}

final class GetActiveTableBookingEmpty extends GetActiveTableBookingsState {}

final class GetActiveTableBookingLoading extends GetActiveTableBookingsState {}

final class GetActiveTableBookingLoaded extends GetActiveTableBookingsState {
  final List<ActiveBooking> bookings;

  const GetActiveTableBookingLoaded({required this.bookings});

  @override
  List<Object> get props => [bookings];
}

final class GetActiveTableBookingError extends GetActiveTableBookingsState {
  final String message;

  const GetActiveTableBookingError(this.message);

  @override
  List<Object> get props => [message];
}
