part of 'get_active_takeaway_bookings_cubit.dart';

sealed class GetActiveTakeawayBookingsState extends Equatable {
  const GetActiveTakeawayBookingsState();

  @override
  List<Object> get props => [];
}

final class GetActiveTakeawayBookingsInitial extends GetActiveTakeawayBookingsState {}

final class Empty extends GetActiveTakeawayBookingsState {}

final class Loading extends GetActiveTakeawayBookingsState {}

final class Loaded extends GetActiveTakeawayBookingsState {
  final List<ActiveBooking> bookings;

  const Loaded({required this.bookings});

  @override
  List<Object> get props => [bookings];
}

final class Error extends GetActiveTakeawayBookingsState {
  final String message;

  const Error(this.message);

  @override
  List<Object> get props => [message];
}
