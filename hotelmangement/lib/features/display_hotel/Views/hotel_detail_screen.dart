import 'package:flutter/material.dart';
import 'package:hotelmangement/features/display_hotel/Model/hotel_model.dart';

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
                  const SizedBox(height: 10),
                  // Location
                  Row(
                    children: [
                      const Icon(Icons.location_on,
                          color: Colors.blueGrey, size: 18),
                      const SizedBox(width: 5),
                      Text(
                        widget.hotelItem.location,
                        style: const TextStyle(
                            color: Colors.black54, fontSize: 16),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  // Mobile
                  Row(
                    children: [
                      const Icon(Icons.phone, color: Colors.blueGrey, size: 18),
                      const SizedBox(width: 5),
                      Text(
                        widget.hotelItem.Mobile.toString(),
                        style: const TextStyle(
                            color: Colors.black54, fontSize: 16),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  // Toggle Buttons
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: ToggleButtons(
                      borderRadius: BorderRadius.circular(25),
                      borderColor: Colors.brown,
                      selectedBorderColor: Colors.brown,
                      fillColor: Colors.brown,
                      selectedColor: Colors.white,
                      color: Colors.black,
                      constraints:
                          const BoxConstraints(minWidth: 110, minHeight: 40),
                      isSelected: List.generate(
                          labels.length, (index) => index == _selectedIndex),
                      onPressed: (index) {
                        setState(() {
                          _selectedIndex = index;
                        });
                      },
                      children: labels
                          .map((label) => Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Text(label),
                              ))
                          .toList(),
                    ),
                  ),
                  const SizedBox(height: 15),
                  // Common Facilities
                  const Text(
                    "Common Facilities",
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.black87,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 10),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: widget.hotelItem.Facilities.map((facility) {
                        return Container(
                          margin: const EdgeInsets.only(right: 10, top: 10),
                          height: 60,
                          width: 60,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.brown),
                          ),
                          child: Center(
                            child: Text(
                              facility,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 10,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  const SizedBox(height: 15),
                  // Description
                  const Text(
                    "Description",
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.black87,
                        fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    widget.hotelItem.description,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.black38,
                      letterSpacing: -.5,
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 147, 113, 113),
          border: Border(
            top: BorderSide(color: Colors.grey.shade300),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Price",
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.w600),
                ),
                Text(
                  "Rs: ${widget.hotelItem.price}",
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.brown,
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
              ),
              child: const Text(
                "Book Now",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
