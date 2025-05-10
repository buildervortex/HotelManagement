import 'package:flutter/material.dart';
import 'package:hotel_management/Model/hotel_model.dart';

class HotelCard extends StatelessWidget {
  final HotelModel hotelItems;
  final Size size;

  const HotelCard({super.key, required this.hotelItems, required this.size});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Hotel Image Container
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.amber,
            image: DecorationImage(
              image: AssetImage(hotelItems.image),
              fit: BoxFit.cover,
            ),
          ),
          height: size.height * 0.20,
          width: size.width * 0.9,
        ),
        const SizedBox(height: 7),

        // Hotel Details
        Container(
          margin: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Hotel Name
                  Text(
                    hotelItems.name.toString(),
                    style: const TextStyle(
                      color: Colors.black87,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),

                  // Location
                  Row(
                    children: [
                      const Icon(Icons.location_on,
                          color: Colors.blueGrey, size: 18),
                      Text(
                        hotelItems.location.toString(),
                        style: const TextStyle(
                            color: Colors.black54, fontSize: 16),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),

                  // Beds & Bathrooms
                  Row(
                    children: [
                      const Icon(Icons.bed, color: Colors.blueGrey, size: 18),
                      Text(
                        " ${hotelItems.bed} Bed",
                        style: const TextStyle(
                            color: Colors.black54, fontSize: 16),
                      ),
                      const SizedBox(width: 20),
                      const Icon(Icons.bathtub,
                          color: Colors.blueGrey, size: 18),
                      Text(
                        " ${hotelItems.bathroom} Bathroom",
                        style: const TextStyle(
                            color: Colors.black54, fontSize: 16),
                      ),
                    ],
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.star, color: Color.fromARGB(255, 236, 213, 7), size: 18),
                      SizedBox(width: 5),
                      Text(
                        hotelItems.rating.toString(),
                        style:
                            const TextStyle(color: Colors.black, fontSize: 16),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  // Price
                  Text(
                    "Rs ${hotelItems.price}",
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  // Package
                  Text(
                    hotelItems.package,
                    style: const TextStyle(
                      color: Colors.black54,
                      fontSize: 16,
                      // fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
