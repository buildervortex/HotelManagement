import 'package:flutter/widgets.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Locationgetpage extends StatefulWidget {
  const Locationgetpage({super.key});

  @override
  State<Locationgetpage> createState() => _LocationgetpageState();
}

class _LocationgetpageState extends State<Locationgetpage> {
  GoogleMapController? mapController;
  LatLng? selectedLocation;

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
