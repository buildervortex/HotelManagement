part of 'rooms_bloc.dart';

sealed class RoomsState extends Equatable {
  const RoomsState();

  @override
  List<Object> get props => [];
}

final class RoomsInitial extends RoomsState {}

final class RoomLoading extends RoomsState {}

final class RoomLoaded extends RoomsState {
  final List<Room> rooms;

  const RoomLoaded({required this.rooms});

  @override
  List<Object> get props => [rooms];
}

final class RoomError extends RoomsState {}

final class RoomImageLoading extends RoomsState {
  final String roomId;

  const RoomImageLoading({required this.roomId});

  @override
  List<Object> get props => [roomId];
}

final class RoomImageLoaded extends RoomsState {
  final List<RoomImage> images;
  final String roomId;

  const RoomImageLoaded({required this.roomId, required this.images});

  @override
  List<Object> get props => [images, roomId];
}
