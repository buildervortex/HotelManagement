import 'package:flutter/material.dart';
import 'package:hotel_management/Model/hotel_model.dart';

class HotelDetailScreen extends StatefulWidget {
  final HotelModel hotelItem;

  const HotelDetailScreen({super.key, required this.hotelItem});

  @override
  State<HotelDetailScreen> createState() => _HotelDetailScreenState();
}

class _HotelDetailScreenState extends State<HotelDetailScreen> {
  int currentIndex = 0;
  int _selectedIndex = 0;

  final List<String> labels = ["Review (106)", "Photo (10)", "Near by (26)"];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Hotel Detail"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: size.height * 0.3,
              width: size.width,
              child: PageView.builder(
                onPageChanged: (value) {
                  setState(() {
                    currentIndex = value;
                  });
                },
                itemCount: 3,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Hero(
                        tag: widget.hotelItem.image,
                        child: Image.asset(
                          widget.hotelItem.image,
                          height: size.height * 0.25,
                          width: size.width * 0.9,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          3,
                          (index) => AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            margin: const EdgeInsets.only(right: 4),
                            width: 7,
                            height: 7,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: index == currentIndex
                                  ? Colors.blue
                                  : Colors.grey.shade400,
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Hotel Name & Rating
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.hotelItem.name,
                        style: const TextStyle(
                          color: Colors.black87,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        children: [
                          const Icon(Icons.star,
                              color: Color.fromARGB(255, 236, 213, 7),
                              size: 18),
                          const SizedBox(width: 5),
                          Text(
                            widget.hotelItem.rating.toString(),
                            style: const TextStyle(
                                color: Colors.black, fontSize: 16),
                          ),
                        ],
                      ),
                    ],
                  ),
                  
          ],
        ),
      ),
    );
  }
}
