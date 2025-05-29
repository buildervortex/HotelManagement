import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hotelmangement/features/hotel_management/domain/entities/hotel.dart';
import 'package:hotelmangement/features/hotel_management/domain/usecases/hotel/get_hotels.dart';

part 'hotels_event.dart';
part 'hotels_state.dart';

class HotelsBloc extends Bloc<HotelsEvent, HotelsState> {
  final GetHotels getHotelsUsecase;

  List<Hotel> _hotels = [];

  HotelsBloc({required this.getHotelsUsecase}) : super(HotelsInitial()) {
    registerListners();
  }

  void registerListners() {
    on<GetHotelsEvent>(_onHotelLoad);
  }

  Future<void> _onHotelLoad(
      GetHotelsEvent event, Emitter<HotelsState> emit) async {
    emit(HotelLoading());

    final hotelListOrFailure =
        await getHotelsUsecase(Params(managerId: event.managerId));

    hotelListOrFailure.fold((error) => emit(HotelError()), (hotelList) {
      _hotels = hotelList;
    });
  }

}
