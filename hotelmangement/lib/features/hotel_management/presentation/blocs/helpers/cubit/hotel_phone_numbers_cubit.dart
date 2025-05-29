import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hotelmangement/features/hotel_management/domain/entities/hotel_phone_number.dart';
import 'package:hotelmangement/features/hotel_management/domain/usecases/hotel/get_hotel_phone_numbers.dart';

part 'hotel_phone_numbers_state.dart';

class HotelPhoneNumbersCubit extends Cubit<HotelPhoneNumbersState> {
  final GetHotelPhoneNumbers getHotelPhoneNumbers;
  HotelPhoneNumbersCubit({required this.getHotelPhoneNumbers})
      : super(HotelPhoneNumbersInitial());

  Future<void> loadPhoneNUmbers(String hotelId) async {
    emit(HotelPhoneNumbersLoading());
    final result = await getHotelPhoneNumbers(Params(hotelId: hotelId));

    result.fold(
        (error) => emit(HotelPhoneNumbersError()),
        (numbers) => emit(
            HotelPhoneNumbersLoaded(hotelId: hotelId, hotelNumbers: numbers)));
  }
}
