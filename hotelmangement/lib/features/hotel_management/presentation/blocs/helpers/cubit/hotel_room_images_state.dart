part of 'hotel_room_images_cubit.dart';

sealed class HotelRoomImagesState extends Equatable {
  const HotelRoomImagesState();

  @override
  List<Object> get props => [];
}

final class HotelRoomImagesInitial extends HotelRoomImagesState {}

final class HotelRoomImagesLoaded extends HotelRoomImagesState {
  final String roomId;
  final List<RoomImage> roomImages;

  const HotelRoomImagesLoaded({required this.roomId, required this.roomImages});

  @override
  List<Object> get props => [roomId, roomImages];
}

final class HotelRoomImagesLoading extends HotelRoomImagesState {}

final class HotelRoomImagesError extends HotelRoomImagesState {}
