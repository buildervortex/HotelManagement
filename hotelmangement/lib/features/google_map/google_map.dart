import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapFlutter extends StatefulWidget {
  const GoogleMapFlutter({super.key});

  @override
  State<GoogleMapFlutter> createState() => _GoogleMapFlutterState();
}

class _GoogleMapFlutterState extends State<GoogleMapFlutter> {
  LatLng myCurrentLocation = LatLng(7.8731, 80.7718);
  late GoogleMapController googleMapController;
  Set<Marker> markrer = {};
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        myLocationButtonEnabled: false,
        markers: markrer,
        onMapCreated: (GoogleMapController controller) {
          googleMapController = controller;
        },
        initialCameraPosition:
            CameraPosition(target: myCurrentLocation, zoom: 15),
        // markers: {
        //   Marker(
        //     markerId: MarkerId("Marker Id"),
        //     position: myCurrentLocation,
        //     draggable: true,
        //     onDragEnd: (value) {},
        //     infoWindow: InfoWindow(
        //       title: "Title of the maker",
        //       snippet: "more info about marker",
        //     ),
        //   ),
        // },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: () async {
          Position position = await currentPosition();
          googleMapController.animateCamera(
            CameraUpdate.newCameraPosition(
              CameraPosition(
                zoom: 15,
                target: LatLng(position.latitude, position.longitude),
              ),
            ),
          );
          markrer.clear();
          markrer.add(
            Marker(
              markerId: MarkerId("This is my location"),
              position: LatLng(position.latitude, position.longitude),
            ),
          );
          setState(() {
            
          });
        },
        child: Icon(
          Icons.my_location,
          size: 30,
        ),
      ),
    );
  }

  Future<Position> currentPosition() async {
    bool serviceEnable;
    LocationPermission permission;

    // Check if the location service are ebabled or not

    serviceEnable = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnable) {
      return Future.error("Location services are disable");
    }

    //Check location permission status
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error("Location permission denied");
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error("Location denied permanently");
    }

    Position position = await Geolocator.getCurrentPosition();
    return position;
  }
}
