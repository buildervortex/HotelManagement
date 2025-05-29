part of 'foods_bloc.dart';

sealed class FoodsState extends Equatable {
  const FoodsState();

  @override
  List<Object> get props => [];
}

final class FoodsInitial extends FoodsState {}

final class FoodLoading extends FoodsState {}

final class FoodLoaded extends FoodsState {
  final List<Food> foods;

  const FoodLoaded({required this.foods});

  @override
  List<Object> get props => [foods];
}

final class FoodError extends FoodsState {}

final class FoodImageLoading extends FoodsState {
  final String foodId;

  const FoodImageLoading({required this.foodId});

  @override
  List<Object> get props => [foodId];
}

final class FoodImageLoaded extends FoodsState {
  final List<FoodImage> images;
  final String foodId;

  const FoodImageLoaded({required this.foodId, required this.images});

  @override
  List<Object> get props => [images, foodId];
}
