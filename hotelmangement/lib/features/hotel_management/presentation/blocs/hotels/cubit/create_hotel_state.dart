part of 'create_hotel_cubit.dart';

sealed class CreateHotelState extends Equatable {
  const CreateHotelState();

  @override
  List<Object> get props => [];
}

final class CreateHotelInitial extends CreateHotelState {}

final class CreateHotelError extends CreateHotelState {}

final class CreateHotelSuccess extends CreateHotelState {}

final class CreateHotelPhoneNumberAdded extends CreateHotelState {
  final List<List<String>> phoneNumbers;

  const CreateHotelPhoneNumberAdded({required this.phoneNumbers});

  @override
  List<Object> get props => [phoneNumbers];
}

final class CreateHotelImageAdded extends CreateHotelState {
  final List<String> images;

  const CreateHotelImageAdded({required this.images});

  @override
  List<Object> get props => [images];
}
