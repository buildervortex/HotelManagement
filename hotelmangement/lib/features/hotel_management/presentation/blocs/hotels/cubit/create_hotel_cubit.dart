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
  List<String> hotelImages = [];
  List<List<String>> phoneNumbers = [];

  final CreateHotel createHotelUsecase;
  final ahpn.AddHotelPhoneNumber addHotelPhoneNumberUsecase;
  final ahid.AddHotelImage addHotelImageUsecase;

  CreateHotelCubit(this.createHotelUsecase, this.addHotelPhoneNumberUsecase,
      this.addHotelImageUsecase)
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

    copy.add([role, phone]);
    this.phoneNumbers = copy;
    emit(CreateHotelPhoneNumberAdded(phoneNumbers: copy));
  }

  Future<void> createHotel() async {
    final hotelOrFailure = await createHotelUsecase(Params(
        name: this.hotelName,
        address: address,
        longitude: longitude,
        latitude: latitude,
        managerId: managerId));
    hotelOrFailure.fold((error) => print(error), (hotel) async {
      for (var image in this.hotelImages) {
        await addHotelImageUsecase(ahid.Params(
            hotelId: hotel.id,
            managerId: managerId,
            localImagePath: image[0],
            remoteImageSaveName: ""));
      }
      for (var number in this.phoneNumbers) {
        await addHotelPhoneNumberUsecase(ahpn.Params(
            hotelId: hotel.id,
            managerId: managerId,
            phoneNumber: number[1],
            role: number[0]));
      }
    });
  }
}
