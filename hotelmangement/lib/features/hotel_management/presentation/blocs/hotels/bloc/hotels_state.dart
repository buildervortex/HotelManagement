part of 'hotels_bloc.dart';

sealed class HotelsState extends Equatable {
  const HotelsState();

  @override
  List<Object> get props => [];
}

final class HotelsInitial extends HotelsState {}

final class HotelLoading extends HotelsState {}

final class HotelLoaded extends HotelsState {
  final List<Hotel> hotels;

  const HotelLoaded({required this.hotels});

  @override
  List<Object> get props => super.props;
}

final class HotelError extends HotelsState {}
