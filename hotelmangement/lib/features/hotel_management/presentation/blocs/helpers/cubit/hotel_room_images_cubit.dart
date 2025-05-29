import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hotelmangement/features/hotel_management/domain/entities/room_image.dart';
import 'package:hotelmangement/features/hotel_management/domain/usecases/room/get_room_image_auth_url.dart'
    as griau;
import 'package:hotelmangement/features/hotel_management/domain/usecases/room/get_room_images.dart';

part 'hotel_room_images_state.dart';

class HotelRoomImagesCubit extends Cubit<HotelRoomImagesState> {
  final GetRoomImages getRoomImages;
  final griau.GetRoomImageAuthUrl getRoomImageAuthUrl;

  HotelRoomImagesCubit(
      {required this.getRoomImages, required this.getRoomImageAuthUrl})
      : super(HotelRoomImagesInitial());

  Future<void> loadImages(String roomId) async {
    emit(HotelRoomImagesLoading());
    final result = await getRoomImages(Params(roomId: roomId));

    result.fold((error) => emit(HotelRoomImagesError()), (images) async {
      List<RoomImage> image_list = [];

      for (var image in images) {
        final urlOrFailure =
            await getRoomImageAuthUrl(griau.Params(imagePath: image.imagePath));

        urlOrFailure.fold((error) {
          print(error);
        }, (url) {
          image_list.add(image.copyWith(imageUrl: url));
          print(url);
        });
      }

      emit(HotelRoomImagesLoaded(roomId: roomId, roomImages: image_list));
    });
  }
}
