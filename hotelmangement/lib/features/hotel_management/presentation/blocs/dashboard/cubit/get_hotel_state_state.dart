part of 'get_hotel_state_cubit.dart';

sealed class GetHotelStateState extends Equatable {
  const GetHotelStateState();

  @override
  List<Object> get props => [];
}

final class GetHotelStateInitial extends GetHotelStateState {}

final class Empty extends GetHotelStateState {}

final class Loading extends GetHotelStateState {}

final class Loaded extends GetHotelStateState {
  final List<HotelState> states;

  const Loaded({required this.states});

  @override
  List<Object> get props => [states];
}

final class Error extends GetHotelStateState {
  final String message;

  const Error(this.message);

  @override
  List<Object> get props => [message];
}
