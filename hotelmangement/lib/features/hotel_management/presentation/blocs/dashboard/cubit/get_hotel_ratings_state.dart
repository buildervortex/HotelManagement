part of 'get_hotel_ratings_cubit.dart';

sealed class GetHotelRatingsState extends Equatable {
  const GetHotelRatingsState();

  @override
  List<Object> get props => [];
}

final class GetHotelRatingsInitial extends GetHotelRatingsState {}

final class GetHotelRatingsEmpty extends GetHotelRatingsState {}

final class GetHotelRatingsLoading extends GetHotelRatingsState {}

final class GetHotelRatingsLoaded extends GetHotelRatingsState {
  final List<RatingCount> ratings;

  const GetHotelRatingsLoaded({required this.ratings});

  @override
  List<Object> get props => [ratings];
}

final class GetHotelRatingsError extends GetHotelRatingsState {
  final String message;

  const GetHotelRatingsError(this.message);

  @override
  List<Object> get props => [message];
}
