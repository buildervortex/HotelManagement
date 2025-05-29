part of 'hotels_bloc.dart';

sealed class HotelsEvent extends Equatable {
  const HotelsEvent();

  @override
  List<Object> get props => [];
}

class GetHotelsEvent extends HotelsEvent {
  final String managerId;

  const GetHotelsEvent({required this.managerId});
}

class HotelImageReceived extends HotelsEvent {
  final String hotelId;
  final List<HotelImage> images;

  const HotelImageReceived({required this.hotelId, required this.images});

  @override
  List<Object> get props => [hotelId, images];
}
