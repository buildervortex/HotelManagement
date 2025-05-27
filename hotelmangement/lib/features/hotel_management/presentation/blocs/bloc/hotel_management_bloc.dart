import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hotelmangement/features/hotel_management/domain/entities/hotel.dart';
import 'package:hotelmangement/features/hotel_management/domain/usecases/hotel/add_hotel_image.dart';
import 'package:hotelmangement/features/hotel_management/domain/usecases/hotel/add_hotel_phone_number.dart';
import 'package:hotelmangement/features/hotel_management/domain/usecases/hotel/create_hotel.dart';
import 'package:hotelmangement/features/hotel_management/domain/usecases/hotel/delete_hotel.dart';
import 'package:hotelmangement/features/hotel_management/domain/usecases/hotel/delete_hotel_image.dart';
import 'package:hotelmangement/features/hotel_management/domain/usecases/hotel/delete_hotel_phone_number.dart';
import 'package:hotelmangement/features/hotel_management/domain/usecases/hotel/get_hotel_details.dart';
import 'package:hotelmangement/features/hotel_management/domain/usecases/hotel/get_hotel_image_auth_url.dart';
import 'package:hotelmangement/features/hotel_management/domain/usecases/hotel/get_hotel_images.dart';
import 'package:hotelmangement/features/hotel_management/domain/usecases/hotel/get_hotel_phone_numbers.dart';
import 'package:hotelmangement/features/hotel_management/domain/usecases/hotel/update_hotel.dart';

part 'hotel_management_event.dart';
part 'hotel_management_state.dart';

class HotelManagementBloc
    extends Bloc<HotelManagementEvent, HotelManagementState> {
  final AddHotelImage addHotelImage;
  final AddHotelPhoneNumber addHotelPhoneNumber;
  final CreateHotel createHotel;
  final DeleteHotel deleteHotel;
  final DeleteHotelImage deleteHotelImage;
  final DeleteHotelPhoneNumber deleteHotelPhoneNumber;
  final GetHotelDetails getHotelDetails;
  final GetHotelImageAuthUrl getHotelImageAuthUrl;
  final GetHotelImages getHotelImages;
  final GetHotelPhoneNumbers getHotelPhoneNumbers;
  final UpdateHotel updateHotel;

  HotelManagementBloc({
    required this.addHotelImage,
    required this.addHotelPhoneNumber,
    required this.createHotel,
    required this.deleteHotel,
    required this.deleteHotelImage,
    required this.deleteHotelPhoneNumber,
    required this.getHotelDetails,
    required this.getHotelImageAuthUrl,
    required this.getHotelImages,
    required this.getHotelPhoneNumbers,
    required this.updateHotel,
  }) : super(Empty()) {
    on<HotelManagementEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
