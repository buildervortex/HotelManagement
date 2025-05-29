import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hotelmangement/features/hotel_management/domain/entities/hotel.dart';
import 'package:hotelmangement/features/hotel_management/domain/entities/hotel_image.dart';
import 'package:hotelmangement/features/hotel_management/domain/entities/hotel_phone_number.dart';
import 'package:hotelmangement/features/hotel_management/domain/usecases/hotel/get_hotels.dart';
import 'package:hotelmangement/features/hotel_management/presentation/blocs/helpers/cubit/hotel_images_cubit.dart';
import 'package:hotelmangement/features/hotel_management/presentation/blocs/helpers/cubit/hotel_phone_numbers_cubit.dart';

part 'hotels_event.dart';
part 'hotels_state.dart';

class HotelsBloc extends Bloc<HotelsEvent, HotelsState> {
  final GetHotels getHotelsUsecase;
  final HotelImagesCubit hotelImagesCubit;
  final HotelPhoneNumbersCubit hotelPhoneNumbersCubit;

  List<Hotel> _hotels = [];

  HotelsBloc(
      {required this.getHotelsUsecase,
      required this.hotelImagesCubit,
      required this.hotelPhoneNumbersCubit})
      : super(HotelsInitial()) {
    _registerListners();
    _registerCubitListners();
  }

  void _registerListners() {
    on<GetHotelsEvent>(_onHotelLoad);
    on<HotelImageReceived>(_onHotelImageLoaded);
    on<HotelPhoneNumbersReceived>(_onHotelPhoneNumbersLoaded);
  }

  Future<void> _onHotelLoad(
      GetHotelsEvent event, Emitter<HotelsState> emit) async {
    emit(HotelLoading());

    final hotelListOrFailure =
        await getHotelsUsecase(Params(managerId: event.managerId));

    hotelListOrFailure.fold((error) => emit(HotelError()), (hotelList) {
      _hotels = hotelList;
      emit(HotelLoaded(
          hotels: _hotels.map((hotel) => hotel.copyWith()).toList()));

      for (var hotel in _hotels) {
        hotelImagesCubit.loadImages(hotel.id);
      }
    });
  }

  void _registerCubitListners() {
    // listen for hotel image cubit changes
    hotelImagesCubit.stream.listen((imagesState) {
      if (imagesState is HotelImagesLoaded) {
        add(HotelImageReceived(
            hotelId: imagesState.hotelId, images: imagesState.hotelImages));
      }
    });
    hotelPhoneNumbersCubit.stream.listen((numberState) {
      if (numberState is HotelPhoneNumbersLoaded) {
        add(HotelPhoneNumbersReceived(
            hotelId: numberState.hotelId, numbers: numberState.hotelNumbers));
      }
    });
  }

  void _onHotelImageLoaded(
      HotelImageReceived event, Emitter<HotelsState> emit) async {
    List<Hotel> hotelList = [];

    for (var hotel in _hotels) {
      if (hotel.id == event.hotelId) {
        hotelList.add(hotel.copyWith(images: event.images));
        emit(HotelImageLoaded(hotelId: event.hotelId, images: event.images));
        continue;
      }
      hotelList.add(hotel.copyWith());
    }
    _hotels = hotelList;
  }

  void _onHotelPhoneNumbersLoaded(
      HotelPhoneNumbersReceived event, Emitter<HotelsState> emit) async {
    List<Hotel> hotelList = [];

    for (var hotel in _hotels) {
      if (hotel.id == event.hotelId) {
        hotelList.add(hotel.copyWith(phoneNumbers: event.numbers));
        continue;
      }
      hotelList.add(hotel.copyWith());
    }
    _hotels = hotelList;
  }
}
