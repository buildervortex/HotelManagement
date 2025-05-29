part of 'get_hotel_state_cubit.dart';

sealed class GetHotelStateState extends Equatable {
  const GetHotelStateState();

  @override
  List<Object> get props => [];
}

final class GetHotelStateInitial extends GetHotelStateState {}

final class GetHotelStateEmpty extends GetHotelStateState {}

final class GetHotelStateLoading extends GetHotelStateState {}

final class GetHotelStateLoaded extends GetHotelStateState {
  final List<HotelState> states;

  const GetHotelStateLoaded({required this.states});

  @override
  List<Object> get props => [states];
}

final class GetHotelStateError extends GetHotelStateState {
  final String message;

  const GetHotelStateError(this.message);

  @override
  List<Object> get props => [message];
}
