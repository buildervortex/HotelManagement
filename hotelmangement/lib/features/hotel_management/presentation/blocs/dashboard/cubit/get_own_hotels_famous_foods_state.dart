part of 'get_own_hotels_famous_foods_cubit.dart';

sealed class GetOwnHotelsFamousFoodsState extends Equatable {
  const GetOwnHotelsFamousFoodsState();

  @override
  List<Object> get props => [];
}

final class GetOwnHotelsFamousFoodsInitial
    extends GetOwnHotelsFamousFoodsState {}

final class Empty extends GetOwnHotelsFamousFoodsState {}

final class Loading extends GetOwnHotelsFamousFoodsState {}

final class Loaded extends GetOwnHotelsFamousFoodsState {
  final List<FamousFood> foods;

  const Loaded({required this.foods});

  @override
  List<Object> get props => [foods];
}

final class Error extends GetOwnHotelsFamousFoodsState {
  final String message;

  const Error(this.message);

  @override
  List<Object> get props => [message];
}
