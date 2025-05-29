import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hotelmangement/core/usecase.dart';
import 'package:hotelmangement/features/hotel_management/domain/entities/famous_food.dart';
import 'package:hotelmangement/features/hotel_management/domain/usecases/dashboard/get_famous_food_in_all_hotels.dart';

part 'get_famous_foods_in_all_state.dart';

class GetFamousFoodsInAllCubit extends Cubit<GetFamousFoodsInAllState> {
  final GetFamousFoodInAllHotels usecase;
  GetFamousFoodsInAllCubit({required this.usecase}) : super(Empty());

  Future<void> getFamousFoods() async {
    emit(Loading());

    final foods = await usecase(NoParams());

    foods.fold((failure) {
      emit(Error("Failed to fetch famous foods"));
    }, (foods) {
      emit(Loaded(famousFoods: foods));
    });
  }
}
