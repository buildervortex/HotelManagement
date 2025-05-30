import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hotelmangement/features/hotel_management/domain/usecases/hotel/add_hotel_image.dart'
    as ahid;
import 'package:hotelmangement/features/hotel_management/domain/usecases/hotel/add_hotel_phone_number.dart'
    as ahpn;
import 'package:hotelmangement/features/hotel_management/domain/usecases/hotel/create_hotel.dart';

part 'create_hotel_state.dart';

class CreateHotelCubit extends Cubit<CreateHotelState> {
  late String hotelName;
  late String address;
  late String managerId;

  late double longitude;
  late double latitude;
  late List<String> hotelImages;
  late List<Map<String, String>> phoneNumbers;

  final CreateHotel createHotelUsecase;
  final ahpn.AddHotelPhoneNumber addHotelPhoneNumberUsecase;
  final ahid.AddHotelImage addHotelImage;

  CreateHotelCubit(this.createHotelUsecase, this.addHotelPhoneNumberUsecase,
      this.addHotelImage)
      : super(CreateHotelInitial());

  void setHotelDetails(String hotelname, String address, String managerId) {
    this.hotelName = hotelname;
    this.address = address;
    this.managerId = managerId;
  }

  void setLocationDetails(double longitude, double latitude) {
    this.longitude = longitude;
    this.latitude = latitude;
  }

  void addHotelImages(String localImagePath) {
    var copy = [...hotelImages];

    copy.add(localImagePath);
    this.hotelImages = copy;
    emit(CreateHotelImageAdded(images: copy));
  }

  void addHotelPhoneNumber(String role, String phone) {
    var copy = [...phoneNumbers];

    copy.add({role: phone});
    this.phoneNumbers = copy;
    emit(CreateHotelPhoneNumberAdded(phoneNumbers: copy));
  }

  Future<void> createHotel() async {}
}
