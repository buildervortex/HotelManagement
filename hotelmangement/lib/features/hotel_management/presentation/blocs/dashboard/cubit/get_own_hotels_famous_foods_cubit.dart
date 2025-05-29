import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hotelmangement/features/hotel_management/domain/entities/famous_food.dart';
import 'package:hotelmangement/features/hotel_management/domain/usecases/dashboard/get_famous_foods_in_own_hotels.dart';

part 'get_own_hotels_famous_foods_state.dart';

class GetOwnHotelsFamousFoodsCubit extends Cubit<GetOwnHotelsFamousFoodsState> {
  final GetFamousFoodsInOwnHotels usecase;
  GetOwnHotelsFamousFoodsCubit({required this.usecase})
      : super(GetOwnHotelsFamousFoodsInitial());

  Future<void> getFamousFoods(String managerId) async {
    emit(Loading());

    final foods = await usecase(Params(managerId: managerId));

    foods.fold((failure) {
      emit(Error("Failed to fetch famous foods"));
    }, (foods) {
      emit(Loaded(foods: foods));
    });
  }
}
