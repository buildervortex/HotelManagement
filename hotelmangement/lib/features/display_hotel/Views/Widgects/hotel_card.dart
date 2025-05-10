import 'package:flutter/material.dart';

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

      
      ],
    );
  }
}
