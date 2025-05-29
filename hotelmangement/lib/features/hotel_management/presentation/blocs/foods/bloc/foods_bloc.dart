import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hotelmangement/features/hotel_management/domain/entities/food.dart';
import 'package:hotelmangement/features/hotel_management/domain/entities/food_image.dart';
import 'package:hotelmangement/features/hotel_management/domain/usecases/food/get_foods_in_hotel.dart';
import 'package:hotelmangement/features/hotel_management/presentation/blocs/helpers/cubit/hotel_foods_images_cubit.dart';

part 'foods_event.dart';
part 'foods_state.dart';

class FoodsBloc extends Bloc<FoodsEvent, FoodsState> {
  final GetFoodsInHotel getFoodsInHotel;
  final HotelFoodsImagesCubit hotelFoodsImagesCubit;

  List<Food> _foods = [];

  FoodsBloc(
      {required this.getFoodsInHotel, required this.hotelFoodsImagesCubit})
      : super(FoodsInitial()) {
    _registerListners();
    _registerCubitListners();
  }

  void _registerListners() {
    on<GetFoodsEvent>(_onFoodLoad);
    on<FoodImageReceived>(_onRoomImageLoaded);
  }

  Future<void> _onFoodLoad(
      GetFoodsEvent event, Emitter<FoodsState> emit) async {
    emit(FoodLoading());

    final foodListOrFailure =
        await getFoodsInHotel(Params(hotelId: event.hotelId));

    foodListOrFailure.fold((error) => emit(FoodError()), (hotelList) {
      _foods = hotelList;
      emit(FoodLoaded(foods: _foods.map((food) => food.copyWith()).toList()));

      for (var food in _foods) {
        hotelFoodsImagesCubit.loadImages(food.id);
      }
    });
  }

  void _registerCubitListners() {
    // listen for food image cubit changes
    hotelFoodsImagesCubit.stream.listen((imagesState) {
      if (imagesState is HotelFoodsImagesLoaded) {
        add(FoodImageReceived(
            foodId: imagesState.foodId, images: imagesState.foodImages));
      }
    });
  }

  void _onRoomImageLoaded(
      FoodImageReceived event, Emitter<FoodsState> emit) async {
    List<Food> roomList = [];

    for (var food in _foods) {
      if (food.id == event.foodId) {
        roomList.add(food.copyWith(images: event.images));
        emit(FoodImageLoaded(foodId: event.foodId, images: event.images));
        continue;
      }
      roomList.add(food.copyWith());
    }
    _foods = roomList;
  }
}
