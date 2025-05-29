import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hotelmangement/features/hotel_management/domain/entities/hotel_state.dart';
import 'package:hotelmangement/features/hotel_management/domain/usecases/dashboard/get_hotel_state.dart';

part 'get_hotel_state_state.dart';

class GetHotelStateCubit extends Cubit<GetHotelStateState> {
  final GetHotelState usecase;
  GetHotelStateCubit({required this.usecase}) : super(GetHotelStateInitial());

  Future<void> getHotelState(String managerId) async {
    emit(GetHotelStateLoading());

    final states = await usecase(Params(managerId: managerId));

    states.fold((failure) {
      emit(GetHotelStateError("Failed to fetch hotel states"));
    }, (states) {
      emit(GetHotelStateLoaded(states: states));
    });
  }
}
