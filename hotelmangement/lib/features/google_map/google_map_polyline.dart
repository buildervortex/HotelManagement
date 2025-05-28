import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapPolyline extends StatefulWidget {
  const GoogleMapPolyline({super.key});

  @override
  State<GoogleMapPolyline> createState() => _GoogleMapPolylineState();
}

class _GoogleMapPolylineState extends State<GoogleMapPolyline> {
  LatLng myCurrentLocation = LatLng(7.8731, 80.7718);

  Set<Marker> markrer = {};

  final Set<Polyline> _polyline = {};
  
  List<LatLng> pointOnMap = [
    LatLng(6.0326, 80.2170), // Galle Fort
    LatLng(6.0359, 80.2152), // Lighthouse
    LatLng(6.0272, 80.2195), // Unawatuna Beach
    LatLng(6.0287, 80.2168), // Dutch Hospital Shopping Precinct
    LatLng(6.0410, 80.2203), // Rumassala
  ];

  @override
  void initState() {
    for (int i = 0; i < pointOnMap.length; i++) {
      markrer.add(
        Marker(
          markerId: MarkerId(
            i.toString(),
          ),
          position: pointOnMap[i],
          infoWindow: InfoWindow(
              title: "Place around my Country", snippet: "So Beautiful"),
          icon: BitmapDescriptor.defaultMarker,
        ),
      );
      setState(() {
        _polyline.add(
          Polyline(
            polylineId: PolylineId("Id"),
            points: pointOnMap,
            color: Colors.blue,
          ),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        polylines: _polyline,
        myLocationButtonEnabled: false,
        markers: markrer,
        initialCameraPosition:
            CameraPosition(target: myCurrentLocation, zoom: 15),
      ),
    );
  }
}



// import 'package:flutter/material.dart';
// import 'package:flutter_map/flutter_map.dart';
// import 'package:latlong2/latlong.dart';



// class WebMapWithPolyline extends StatelessWidget {
//   const WebMapWithPolyline({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final List<LatLng> points = [
//       LatLng(6.0326, 80.2170), // Galle Fort
//       LatLng(6.0359, 80.2152), // Lighthouse
//       LatLng(6.0272, 80.2195), // Unawatuna Beach
//       LatLng(6.0287, 80.2168), // Dutch Hospital
//       LatLng(6.0410, 80.2203), // Rumassala
//     ];

//     return Scaffold(
//       appBar: AppBar(title: const Text('Flutter Web Map with Polyline')),
//       body: FlutterMap(
//         options: MapOptions(
//           center: LatLng(6.0326, 80.2170),
//           zoom: 14,
//         ),
//         children: [
//           TileLayer(
//             urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
//             subdomains: ['a', 'b', 'c'],
//           ),
//           PolylineLayer(
//             polylines: [
//               Polyline(
//                 points: points,
//                 strokeWidth: 4.0,
//                 color: Colors.blue,
//               ),
//             ],
//           ),
//           MarkerLayer(
//             markers: points.map((point) {
//               return Marker(
//                 width: 40,
//                 height: 40,
//                 point: point,
//                 builder: (_) => Icon(
//                   Icons.location_on,
//                   color: Colors.red,
//                   size: 30,
//                 ),
//               );
//             }).toList(),
//           ),
//         ],
//       ),
//     );
//   }
// }
