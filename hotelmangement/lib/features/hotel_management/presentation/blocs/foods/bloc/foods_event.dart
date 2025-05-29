part of 'foods_bloc.dart';

sealed class FoodsEvent extends Equatable {
  const FoodsEvent();

  @override
  List<Object> get props => [];
}

class GetFoodsEvent extends FoodsEvent {
  final String hotelId;

  const GetFoodsEvent({required this.hotelId});
}

class FoodImageReceived extends FoodsEvent {
  final String foodId;
  final List<FoodImage> images;

  const FoodImageReceived({required this.foodId, required this.images});

  @override
  List<Object> get props => [foodId, images];
}
