// import 'package:flutter/material.dart';
// import 'package:hotelmangement/features/display_hotel/Model/hotel_model.dart';

// class HotelCard extends StatelessWidget {
//   final HotelModel hotelItems;
//   final Size size;

//   const HotelCard({super.key, required this.hotelItems, required this.size});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: [
//         // Hotel Image Container
//         Container(
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(10),
//             color: Colors.amber,
//             image: DecorationImage(
//               image: AssetImage(hotelItems.image),
//               fit: BoxFit.cover,
//             ),
//           ),
//           height: size.height * 0.20,
//           width: size.width * 0.9,
//         ),
//         const SizedBox(height: 7),

//         // Hotel Details
//         Container(
//           margin: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   // Hotel Name
//                   Text(
//                     hotelItems.name.toString(),
//                     style: const TextStyle(
//                       color: Colors.black87,
//                       fontSize: 22,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   const SizedBox(height: 5),

//                   // Location
//                   Row(
//                     children: [
//                       const Icon(Icons.location_on,
//                           color: Colors.blueGrey, size: 18),
//                       Text(
//                         hotelItems.location.toString(),
//                         style: const TextStyle(
//                             color: Colors.black54, fontSize: 16),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 5),

//                   // Beds & Bathrooms
//                   Row(
//                     children: [
//                       const Icon(Icons.bed, color: Colors.blueGrey, size: 18),
//                       Text(
//                         " ${hotelItems.bed} Bed",
//                         style: const TextStyle(
//                             color: Colors.black54, fontSize: 16),
//                       ),
//                       const SizedBox(width: 20),
//                       const Icon(Icons.bathtub,
//                           color: Colors.blueGrey, size: 18),
//                       Text(
//                         " ${hotelItems.bathroom} Bathroom",
//                         style: const TextStyle(
//                             color: Colors.black54, fontSize: 16),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Row(
//                     children: [
//                       const Icon(Icons.star, color: Color.fromARGB(255, 236, 213, 7), size: 18),
//                       SizedBox(width: 5),
//                       Text(
//                         hotelItems.rating.toString(),
//                         style:
//                             const TextStyle(color: Colors.black, fontSize: 16),
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: 10),
//                   // Price
//                   Text(
//                     "Rs ${hotelItems.price}",
//                     style: const TextStyle(
//                       color: Colors.black,
//                       fontSize: 20,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   // Package
//                   Text(
//                     hotelItems.package,
//                     style: const TextStyle(
//                       color: Colors.black54,
//                       fontSize: 16,
//                       // fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }



// New Update


import 'package:flutter/material.dart';
import 'package:hotelmangement/features/display_hotel/Model/hotel_model_test.dart' show ExtendedHotel;

class HotelCard extends StatelessWidget {
  final ExtendedHotel hotelData;
  final Size size;

  const HotelCard({super.key, required this.hotelData, required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 10,
            spreadRadius: 5,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Hotel Image
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            child: Image.network(
              hotelData.hotelImageList.isNotEmpty
                  ? hotelData.hotelImageList.first
                  : "https://via.placeholder.com/400x200.png?text=No+Image",
              height: size.height * 0.25,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),

          // Hotel Info
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  hotelData.hotel.name,
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    const Icon(Icons.location_on, size: 18, color: Colors.blueGrey),
                    const SizedBox(width: 5),
                    Expanded(
                      child: Text(
                        hotelData.hotel.address,
                        style: const TextStyle(fontSize: 16, color: Colors.black54),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                if (hotelData.phoneNumbers.isNotEmpty)
                  Row(
                    children: [
                      const Icon(Icons.phone, size: 18, color: Colors.green),
                      const SizedBox(width: 5),
                      Text(
                        hotelData.phoneNumbers.first.number,
                        style: const TextStyle(fontSize: 16, color: Colors.black87),
                      ),
                    ],
                  ),
                const SizedBox(height: 10),

                // Rating & Price
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.star, color: Colors.orangeAccent, size: 20),
                        const SizedBox(width: 5),
                        Text(
                          "${hotelData.hotel.rating.toStringAsFixed(1)}",
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "Rs ${hotelData.hotel.price}",
                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Text(hotelData.hotel.priceType, style: const TextStyle(color: Colors.grey)),
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}



