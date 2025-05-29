part of 'hotel_images_cubit.dart';

sealed class HotelImagesState extends Equatable {
  const HotelImagesState();

  @override
  List<Object> get props => [];
}

final class HotelImagesInitial extends HotelImagesState {}

final class HotelImagesLoaded extends HotelImagesState {
  final String hotelId;
  final List<HotelImage> hotelImages;

  const HotelImagesLoaded({required this.hotelId, required this.hotelImages});

  @override
  List<Object> get props => [hotelId, hotelImages];
}

final class HotelImagesLoading extends HotelImagesState {}

final class HotelImagesError extends HotelImagesState {}
