import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hotelmangement/features/hotel_management/domain/entities/rating_count.dart';
import 'package:hotelmangement/features/hotel_management/domain/usecases/dashboard/get_hotel_ratings.dart';

part 'get_hotel_ratings_state.dart';

class GetHotelRatingsCubit extends Cubit<GetHotelRatingsState> {
  final GetHotelRatings usecase;
  GetHotelRatingsCubit({required this.usecase})
      : super(GetHotelRatingsInitial());

  Future<void> getHotelRatings(String managerId) async {
    emit(GetHotelRatingsLoading());

    final ratings = await usecase(Params(managerId: managerId));

    ratings.fold((failure) {
      emit(GetHotelRatingsError("Failed to fetch hotel ratings"));
    }, (ratings) {
      emit(GetHotelRatingsLoaded(ratings: ratings));
    });
  }
}
