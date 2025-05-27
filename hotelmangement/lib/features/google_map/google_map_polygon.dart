import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CustomInfoWindows extends StatefulWidget {
  const CustomInfoWindows({super.key});

  @override
  State<CustomInfoWindows> createState() => _CustomInfoWindowsState();
}

class _CustomInfoWindowsState extends State<CustomInfoWindows> {
  final CustomInfoWindowController customInfoWindowController =
      CustomInfoWindowController();

  Set<Marker> marker = {};
  final List<LatLng> lateLongPoint = [
    LatLng(6.0326, 80.2170), // Galle Fort
    LatLng(6.0359, 80.2152), // Lighthouse
    LatLng(6.0272, 80.2195), // Unawatuna Beach
  ];

//Corresponding name for the location
  final List<String> locationNames = [
    "Galle Fort",
    "Lighthouse",
    "Unawatuna Beach",
  ];

//Corresponding image URLs for the location
  final List<String> locationImages = [
    "https://upload.wikimedia.org/wikipedia/commons/thumb/7/77/Galle_Fort.jpg/640px-Galle_Fort.jpg",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSi0AgXeyyW81Dit-L8wKUfeyUeph1CfigzCQ&s",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTFVq-479WZERMtaxX_4MsDRUbOtNffqtLUaA&s",
  ];

  @override
  void initState() {
    displayInfo();
    super.initState();
  }

  displayInfo() {
    for (int i = 1; i < lateLongPoint.length; i++) {
      marker.add(
        Marker(
          markerId: MarkerId(
            i.toString(),
          ),
          icon: BitmapDescriptor.defaultMarker,
          position: lateLongPoint[i],
          onTap: () {
            customInfoWindowController.addInfoWindow!(
              Container(
                child: Column(
                  children: [
                    Image.network(
                      locationImages[i],
                      height: 125,
                      width: 250,
                      fit: BoxFit.cover,
                    ),
                    Text(
                      locationNames[i],
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
              ),
              lateLongPoint[i],
            );
          },
        ),
      );
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: LatLng(27.8731, 80.7718),
              zoom: 15,
            ),
            markers: marker,
            onMapCreated: (GoogleMapController controller) {
              customInfoWindowController.googleMapController = controller;
            },
          ),
          CustomInfoWindow(
            controller: customInfoWindowController,
            height: 155,
            width: 250,
            offset: 40,
          ),
        ],
      ),
    );
  }
}

