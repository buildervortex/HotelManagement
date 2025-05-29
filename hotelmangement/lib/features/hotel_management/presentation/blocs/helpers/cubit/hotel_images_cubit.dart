import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hotelmangement/features/hotel_management/domain/entities/hotel_image.dart';
import 'package:hotelmangement/features/hotel_management/domain/usecases/hotel/get_hotel_images.dart';

part 'hotel_images_state.dart';

class HotelImagesCubit extends Cubit<HotelImagesState> {
  final GetHotelImages getHotelImages;
  HotelImagesCubit({required this.getHotelImages})
      : super(HotelImagesInitial());

  Future<void> loadImages(String hotelId) async {
    emit(HotelImagesLoading());
    final result = await getHotelImages(Params(hotelId: hotelId));

    result.fold((error) => emit(HotelImagesError()), (images) {
      emit(HotelImagesLoaded(hotelId: hotelId, hotelImages: images));
    });
  }
}
