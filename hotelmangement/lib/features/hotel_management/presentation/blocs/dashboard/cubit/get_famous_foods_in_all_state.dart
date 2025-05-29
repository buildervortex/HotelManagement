part of 'get_famous_foods_in_all_cubit.dart';

sealed class GetFamousFoodsInAllState extends Equatable {
  const GetFamousFoodsInAllState();

  @override
  List<Object> get props => [];
}

final class GetFamousFoodsInAllEmpty extends GetFamousFoodsInAllState {}

final class GetFamousFoodsInAllLoading extends GetFamousFoodsInAllState {}

final class GetFamousFoodsInAllLoaded extends GetFamousFoodsInAllState {
  final List<FamousFood> famousFoods;

  const GetFamousFoodsInAllLoaded({required this.famousFoods});

  @override
  List<Object> get props => [famousFoods];
}

final class GetFamousFoodsInAllError extends GetFamousFoodsInAllState {
  final String message;

  const GetFamousFoodsInAllError(this.message);

  @override
  List<Object> get props => [message];
}
