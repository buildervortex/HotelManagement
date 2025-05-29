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
    // LatLng(6.0326, 80.2170), // Galle Fort
    // LatLng(6.0359, 80.2152), // Lighthouse
    // LatLng(6.0272, 80.2195), // Unawatuna Beach
    // LatLng(6.0287, 80.2168), // Dutch Hospital Shopping Precinct
    // LatLng(6.0410, 80.2203), // Rumassala
 

 LatLng(6.9206, 79.8564), // Cinnamon Grand Colombo
  LatLng(6.9253, 79.8439), // Shangri-La Colombo
  LatLng(6.9223, 79.8475), // Galle Face Hotel
  LatLng(6.9339, 79.8428), // The Kingsbury
  LatLng(6.9316, 79.8470), // Hilton Colombo
  LatLng(6.9102, 79.8543), // Marino Beach Hotel
  LatLng(6.9229, 79.8481), // Taj Samudra
  LatLng(6.9110, 79.8569), // Mövenpick Hotel Colombo
  LatLng(6.9150, 79.8616), // Jetwing Colombo Seven
  LatLng(6.9065, 79.8560), // Mandarina Colombo

  LatLng(7.2925, 80.6650), // Earl’s Regency
  LatLng(7.3064, 80.6486), // Mahaweli Reach Hotel
  LatLng(7.3106, 80.6247), // Cinnamon Citadel Kandy
  LatLng(7.2632, 80.6692), // The Kandy House
  LatLng(7.2913, 80.6401), // OZO Kandy by Cinnamon

  LatLng(6.0386, 80.2073), // Jetwing Lighthouse
  LatLng(6.0410, 80.2170), // Amari Galle
  LatLng(5.9970, 80.3223), // The Fortress Resort & Spa
  LatLng(6.0415, 80.2142), // Le Grand Galle
  LatLng(6.0082, 80.2485), // Thaproban Pavilion Resort & Spa
  LatLng(5.9736, 80.4293), // Weligama Bay Marriott Resort & Spa
  LatLng(5.9635, 80.4285), // Cape Weligama
  LatLng(6.0068, 80.2463), // Cantaloupe Levels
  LatLng(6.0060, 80.2474), // The Frangipani Tree
  LatLng(6.0326, 80.2170), // Radisson Blu Resort Galle

  LatLng(6.9515, 80.7820), // Heritance Tea Factory
  LatLng(6.9667, 80.7654), // Araliya Green Hills Hotel
  LatLng(6.9684, 80.7828), // Grand Hotel Nuwara Eliya
  LatLng(6.9713, 80.7650), // Jetwing St. Andrew's
  LatLng(6.9630, 80.7715), // Galway Heights

  LatLng(6.4214, 79.9987), // Cinnamon Bentota Beach
  LatLng(6.4197, 79.9980), // Avani Bentota Resort
  LatLng(6.4111, 79.9965), // The Blue Water Hotel
  LatLng(6.5715, 79.9648), // Anantara Kalutara Resort
  LatLng(6.4193, 79.9979), // Club Villa Bentota

  LatLng(8.5897, 81.2170), // Trinco Blu by Cinnamon
  LatLng(8.7435, 81.1322), // Uga Jungle Beach
  LatLng(7.9134, 81.5618), // Uga Bay by Uga Escapes
  LatLng(7.9214, 81.5595), // Maalu Maalu Resort & Spa
  LatLng(6.8462, 81.8325), // Kottukal Beach House

  LatLng(7.9094, 80.7551), // Aliya Resort and Spa
  LatLng(7.8681, 80.7093), // Jetwing Lake
  LatLng(7.6939, 80.7106), // Heritance Kandalama
  LatLng(7.8850, 80.7048), // Amaya Lake
  LatLng(7.9160, 80.7770), // Camellia Resort and Spa

  LatLng(9.6682, 80.0090), // Jetwing Jaffna
  LatLng(9.6687, 80.0105), // North Gate by Jetwing
  LatLng(9.6700, 80.0200), // Thambu Illam

  LatLng(6.1931, 81.4023), // Wild Coast Tented Lodge
  LatLng(6.1830, 81.3975), // Chena Huts by Uga Escapes

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
