part of 'get_famous_foods_in_all_cubit.dart';

sealed class GetFamousFoodsInAllState extends Equatable {
  const GetFamousFoodsInAllState();

  @override
  List<Object> get props => [];
}

final class Empty extends GetFamousFoodsInAllState {}

final class Loading extends GetFamousFoodsInAllState {}

final class Loaded extends GetFamousFoodsInAllState {
  final List<FamousFood> famousFoods;

  const Loaded({required this.famousFoods});

  @override
  List<Object> get props => [famousFoods];
}

final class Error extends GetFamousFoodsInAllState {
  final String message;

  const Error(this.message);

  @override
  List<Object> get props => [message];
}