import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/rendering.dart';
import 'package:hotelmangement/features/hotel_management/domain/entities/hotel_image.dart';
import 'package:hotelmangement/features/hotel_management/domain/usecases/hotel/get_hotel_image_auth_url.dart'
    as ghiau;
import 'package:hotelmangement/features/hotel_management/domain/usecases/hotel/get_hotel_images.dart';

part 'hotel_images_state.dart';

class HotelImagesCubit extends Cubit<HotelImagesState> {
  final GetHotelImages getHotelImages;
  final ghiau.GetHotelImageAuthUrl getHotelImageAuthUrl;
  HotelImagesCubit(
      {required this.getHotelImages, required this.getHotelImageAuthUrl})
      : super(HotelImagesInitial());

  Future<void> loadImages(String hotelId) async {
    emit(HotelImagesLoading());
    final result = await getHotelImages(Params(hotelId: hotelId));

    result.fold((error) => emit(HotelImagesError()), (images) async {
      List<HotelImage> image_list = [];

      for (var image in images) {
        final urlOrFailure = await getHotelImageAuthUrl(
            ghiau.Params(imagePath: image.imagePath));

        urlOrFailure.fold((error) {},
            (url) => {image_list.add(image.copyWith(imageUrl: url))});
      }

      emit(HotelImagesLoaded(hotelId: hotelId, hotelImages: image_list));
    });
  }
}
