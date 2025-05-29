part of 'get_active_takeaway_bookings_cubit.dart';

sealed class GetActiveTakeawayBookingsState extends Equatable {
  const GetActiveTakeawayBookingsState();

  @override
  List<Object> get props => [];
}

final class GetActiveTakeawayBookingsInitial
    extends GetActiveTakeawayBookingsState {}

final class GetActiveTakeawayBookingsEmpty
    extends GetActiveTakeawayBookingsState {}

final class GetActiveTakeawayBookingsLoading
    extends GetActiveTakeawayBookingsState {}

final class GetActiveTakeawayBookingsLoaded
    extends GetActiveTakeawayBookingsState {
  final List<ActiveBooking> bookings;

  const GetActiveTakeawayBookingsLoaded({required this.bookings});

  @override
  List<Object> get props => [bookings];
}

final class GetActiveTakeawayBookingsError
    extends GetActiveTakeawayBookingsState {
  final String message;

  const GetActiveTakeawayBookingsError(this.message);

  @override
  List<Object> get props => [message];
}
