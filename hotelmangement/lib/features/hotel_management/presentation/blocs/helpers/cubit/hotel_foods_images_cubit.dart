import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hotelmangement/features/hotel_management/domain/entities/food_image.dart';
import 'package:hotelmangement/features/hotel_management/domain/usecases/food/get_food_image_auth_url.dart'
    as gfiau;
import 'package:hotelmangement/features/hotel_management/domain/usecases/food/get_food_images.dart';

part 'hotel_foods_images_state.dart';

class HotelFoodsImagesCubit extends Cubit<HotelFoodsImagesState> {
  final GetFoodImages getFoodImages;
  final gfiau.GetFoodImageAuthUrl getFoodImageAuthUrl;

  HotelFoodsImagesCubit(
      {required this.getFoodImages, required this.getFoodImageAuthUrl})
      : super(HotelFoodsImagesInitial());

  Future<void> loadImages(String foodId) async {
    emit(HotelFoodsImagesLoading());
    final result = await getFoodImages(Params(foodId: foodId));

    result.fold((error) => emit(HotelFoodsImagesError()), (images) async {
      List<FoodImage> image_list = [];

      for (var image in images) {
        final urlOrFailure =
            await getFoodImageAuthUrl(gfiau.Params(imagePath: image.imagePath));

        urlOrFailure.fold((error) {
          print(error);
        }, (url) {
          image_list.add(image.copyWith(imageUrl: url));
          print(url);
        });
      }

      emit(HotelFoodsImagesLoaded(foodId: foodId, foodImages: image_list));
    });
  }
}
