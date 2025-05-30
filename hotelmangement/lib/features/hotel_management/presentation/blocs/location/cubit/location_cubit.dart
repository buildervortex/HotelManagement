import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:location/location.dart';

part 'location_state.dart';

class LocationCubit extends Cubit<LocationState> {
  final Location location = Location();
  LocationCubit() : super(LocationInitial());

  Future<void> fetchLocation() async {
    bool serviceEnabed = await location.serviceEnabled();
    if (!serviceEnabed) serviceEnabed = await location.requestService();

    PermissionStatus permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return emit(ErrorCurrentLocation(
            message: "The location permissions not granted"));
      }
    }

    final currentLocation = await location.getLocation();
    emit(LoadedCurrentLocation(locationData: currentLocation));

    print("The current location data are the ${currentLocation}");
  }
}
