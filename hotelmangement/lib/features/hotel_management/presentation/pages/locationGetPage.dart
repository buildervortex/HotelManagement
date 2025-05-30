import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hotelmangement/features/hotel_management/presentation/blocs/hotels/cubit/create_hotel_cubit.dart';
import 'package:hotelmangement/features/hotel_management/presentation/blocs/location/cubit/location_cubit.dart';

class Locationgetpage extends StatefulWidget {
  const Locationgetpage({super.key});

  @override
  State<Locationgetpage> createState() => _LocationgetpageState();
}

class _LocationgetpageState extends State<Locationgetpage> {
  GoogleMapController? mapController;
  LatLng _defautlLocation = LatLng(6.9271, 79.8612);
  LatLng? selectedLocation;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    BlocProvider.of<LocationCubit>(context).fetchLocation();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LocationCubit, LocationState>(
      listener: (cont, state) {
        if (state is LoadedCurrentLocation) {
          setState(() {
            _defautlLocation = LatLng(
              state.locationData.latitude!,
              state.locationData.longitude!,
            );
          });
        }
      },
      child: Column(
        children: [
          TextButton(
              onPressed: () {
                _onSkip();
              },
              child: Text("Get Current Location")),
          Expanded(
              child: GoogleMap(
            initialCameraPosition: CameraPosition(
              target: _defautlLocation,
              zoom: 14.0,
            ),
            onMapCreated: (GoogleMapController controller) {
              mapController = controller;
            },
            onTap: _onMapTapped,
            markers: {
              Marker(
                markerId: MarkerId("selected"),
                position: selectedLocation ?? _defautlLocation,
              ),
            },
          )),
        ],
      ),
    );
  }

  void _onMapTapped(LatLng position) {
    BlocProvider.of<CreateHotelCubit>(context)
        .setLocationDetails(position.longitude, position.longitude);
    Navigator.of(context).popAndPushNamed("/getImages");
  }

  void _onSkip() {
    BlocProvider.of<CreateHotelCubit>(context).setLocationDetails(
        _defautlLocation.longitude, _defautlLocation.longitude);
    Navigator.of(context).popAndPushNamed("/getImages");
  }
}
