part of 'hotel_foods_images_cubit.dart';

sealed class HotelFoodsImagesState extends Equatable {
  const HotelFoodsImagesState();

  @override
  List<Object> get props => [];
}

final class HotelFoodsImagesInitial extends HotelFoodsImagesState {}

final class HotelFoodsImagesLoaded extends HotelFoodsImagesState {
  final String foodId;
  final List<FoodImage> foodImages;

  const HotelFoodsImagesLoaded(
      {required this.foodId, required this.foodImages});

  @override
  List<Object> get props => [foodId, foodImages];
}

final class HotelFoodsImagesLoading extends HotelFoodsImagesState {}

final class HotelFoodsImagesError extends HotelFoodsImagesState {}
