import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hotelmangement/features/hotel_management/domain/entities/active_booking.dart';
import 'package:hotelmangement/features/hotel_management/domain/usecases/dashboard/get_active_takeaway_bookings.dart';

part 'get_active_takeaway_bookings_state.dart';

class GetActiveTakeawayBookingsCubit
    extends Cubit<GetActiveTakeawayBookingsState> {
  final GetActiveTakeawayBookings usecase;
  GetActiveTakeawayBookingsCubit({required this.usecase})
      : super(GetActiveTakeawayBookingsInitial());

  Future<void> getActiveTakeawayBookings(
      DateTime datetime, String managerId) async {
    emit(GetActiveTakeawayBookingsLoading());

    final bookings =
        await usecase(Params(datetime: datetime, managerId: managerId));

    bookings.fold((failure) {
      emit(GetActiveTakeawayBookingsError(
          "Failed to fetch active takeaway bookings"));
    }, (bookings) {
      if (bookings.isEmpty) {
        emit(GetActiveTakeawayBookingsEmpty());
      } else {
        emit(GetActiveTakeawayBookingsLoaded(bookings: bookings));
      }
    });
  }
}
