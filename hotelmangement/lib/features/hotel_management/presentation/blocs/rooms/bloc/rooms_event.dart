part of 'rooms_bloc.dart';

sealed class RoomsEvent extends Equatable {
  const RoomsEvent();

  @override
  List<Object> get props => [];
}

class GetRoomsEvent extends RoomsEvent {
  final String hotelId;

  const GetRoomsEvent({required this.hotelId});
}

class RoomImageReceived extends RoomsEvent {
  final String roomId;
  final List<RoomImage> images;

  const RoomImageReceived({required this.roomId, required this.images});

  @override
  List<Object> get props => [roomId, images];
}
