part of 'hotel_phone_numbers_cubit.dart';

sealed class HotelPhoneNumbersState extends Equatable {
  const HotelPhoneNumbersState();

  @override
  List<Object> get props => [];
}

final class HotelPhoneNumbersInitial extends HotelPhoneNumbersState {}

final class HotelPhoneNumbersLoaded extends HotelPhoneNumbersState {
  final String hotelId;
  final List<HotelPhoneNumber> hotelNumbers;

  const HotelPhoneNumbersLoaded(
      {required this.hotelId, required this.hotelNumbers});

  @override
  List<Object> get props => [hotelId, hotelNumbers];
}

final class HotelPhoneNumbersLoading extends HotelPhoneNumbersState {}

final class HotelPhoneNumbersError extends HotelPhoneNumbersState {}
