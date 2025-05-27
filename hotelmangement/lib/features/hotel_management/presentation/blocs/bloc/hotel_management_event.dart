part of 'hotel_management_bloc.dart';

sealed class HotelManagementEvent extends Equatable {
  const HotelManagementEvent();

  @override
  List<Object> get props => [];
}

class AddHotelImageEvent extends HotelManagementEvent {
  final String hotelId;
  final String managerId;
  final String localImagePath;

  const AddHotelImageEvent({
    required this.hotelId,
    required this.managerId,
    required this.localImagePath,
  });

  @override
  List<Object> get props => [hotelId, managerId, localImagePath];
}

class GetHotelDetailsEvent extends HotelManagementEvent {
  final String hotelId;

  const GetHotelDetailsEvent(this.hotelId);

  @override
  List<Object> get props => [hotelId];
}


class CreateHotelEvent extends HotelManagementEvent {
  final String name;
  final String address;
  final double longitude;
  final double latitude;
  final String managerId;

  const CreateHotelEvent(
      {required this.name,
      required this.address,
      required this.longitude,
      required this.latitude,
      required this.managerId});

  @override
  List<Object> get props => [name, address, longitude, latitude, managerId];
}

class UpdateHotelEvent extends HotelManagementEvent {
  final String hotelId;
  final String name;
  final String address;
  final double longitude;
  final double latitude;

  const UpdateHotelEvent({
    required this.hotelId,
    required this.name,
    required this.address,
    required this.longitude,
    required this.latitude,
  });

  @override
  List<Object> get props => [hotelId, name, address, longitude, latitude];
}