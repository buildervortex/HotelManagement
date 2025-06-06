import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hotelmangement/features/hotel_management/domain/entities/active_booking.dart';
import 'package:hotelmangement/features/hotel_management/domain/usecases/dashboard/get_active_table_bookings.dart';

part 'get_active_table_bookings_state.dart';

class GetActiveTableBookingsCubit extends Cubit<GetActiveTableBookingsState> {
  final GetActiveTableBookings usecase;
  GetActiveTableBookingsCubit({required this.usecase})
      : super(GetActiveTableBookingEmpty());

  Future<void> getActiveTableBookings(
      DateTime datetime, String managerId) async {
    emit(GetActiveTableBookingLoading());

    final bookings =
        await usecase(Params(datetime: datetime, managerId: managerId));

    bookings.fold((failure) {
      emit(GetActiveTableBookingError("Failed to fetch active table bookings"));
    }, (bookings) {
      emit(GetActiveTableBookingLoaded(bookings: bookings));
    });
  }
}
