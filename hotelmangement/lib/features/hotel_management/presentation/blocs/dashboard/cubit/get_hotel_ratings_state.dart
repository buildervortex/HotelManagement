part of 'get_hotel_ratings_cubit.dart';

sealed class GetHotelRatingsState extends Equatable {
  const GetHotelRatingsState();

  @override
  List<Object> get props => [];
}

final class GetHotelRatingsInitial extends GetHotelRatingsState {}

final class Empty extends GetHotelRatingsState {}

final class Loading extends GetHotelRatingsState {}

final class Loaded extends GetHotelRatingsState {
  final List<RatingCount> ratings;

  const Loaded({required this.ratings});

  @override
  List<Object> get props => [ratings];
}

final class Error extends GetHotelRatingsState {
  final String message;

  const Error(this.message);

  @override
  List<Object> get props => [message];
}
