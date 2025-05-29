import 'dart:async';
import 'package:flutter/material.dart';

class HotelOfferDetailPage extends StatefulWidget {
  const HotelOfferDetailPage({super.key});

  @override
  State<HotelOfferDetailPage> createState() => _HotelOfferDetailPageState();
}

class _HotelOfferDetailPageState extends State<HotelOfferDetailPage> {
  bool isSaved = false;
  int _currentPage = 0;
  late PageController _pageController;
  Timer? _timer;

  final List<String> hotelImages = [
    'assets/hotel_valencia.jpg',
    'assets/hotel_valencia_2.jpg',
    'assets/hotel_valencia_3.jpg',
    'assets/hotel_valencia_4.webp',
    'assets/hotel_valencia_5.webp',
    'assets/Eurostars_Gran_Valencia.jpg',
    'assets/visit_oceanografic.jpg',
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);

    _timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      if (_currentPage < hotelImages.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }

      if (_pageController.hasClients) {
        _pageController.animateToPage(
          _currentPage,
          duration: const Duration(milliseconds: 350),
          curve: Curves.easeIn,
        );
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildImageHeader(),
            _buildHotelInfo(),
            _buildWhatWeOffer(),
            _buildHostInfo(),
            //_buildBookNowButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildImageHeader() {
    return Stack(
      children: [
        SizedBox(
          height: 250,
          width: double.infinity,
          child: PageView.builder(
            controller: _pageController,
            itemCount: hotelImages.length,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemBuilder: (context, index) {
              return Image.asset(
                hotelImages[index],
                fit: BoxFit.cover,
              );
            },
          ),
        ),
        Positioned(
  top: 40,
  left: 16,
  child: GestureDetector(
    onTap: () {
      Navigator.pop(context);
    },
    child: const Icon(Icons.arrow_back, color: Colors.white),
  ),
),
        
        
        Positioned(
          bottom: 16,
          left: 16,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.6),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              "${hotelImages.length} photos",
              style: const TextStyle(color: Colors.white),
            ),
          ),
        )
      ],
    );
  }

  Widget _buildHotelInfo() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Hotel Valencia Center Luxury",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 6),
          Row(
            children: const [
              Icon(Icons.location_on, color: Colors.grey),
              SizedBox(width: 4),
              Text("Avda Baleares, 2, Valencia, 46023, Spain"),
            ],
          ),
          const SizedBox(height: 6),
          Row(
            children: const [
              Icon(Icons.star, color: Colors.orange),
              SizedBox(width: 4),
              Text("4.9 (5.8k reviews)"),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Chip(
                label: Text("20% OFF"),
                backgroundColor: Colors.black12,
              ),
              Text(
                "\$580 /night",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Text(
            "Hotel Valencia Center is 1312 feet from Valencia’s City of Arts and Sciences, 1.9 mi from the city center. It offers a sauna, gym and outdoor pool, and free Wi-Fi. The hotel is a 10-minute walk from Ayora Metro Station, which connects to the city center and the airport. It takes 5 minutes by bus to the beach or city center, and there is a bus stop opposite the hotel. All air-conditioned/heated (according season) rooms have a satellite TV, safe and mini-bar The hotel restaurant serves Mediterranean cuisine. There is a bar and room service is available. There is a 24-hour front desk and you can hire a car at the tour desk. On-site parking is available for an extra charge.",
            style: TextStyle(fontSize: 14),
          ),
        ],
      ),
    );
  }

  Widget _buildWhatWeOffer() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "What we offer",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              _OfferIcon(icon: Icons.bed, label: "2 Beds"),
              _OfferIcon(icon: Icons.restaurant, label: "Dinner"),
              _OfferIcon(icon: Icons.hot_tub, label: "Hot Tub"),
              _OfferIcon(icon: Icons.ac_unit, label: "1 AC"),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHostInfo() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          const CircleAvatar(
            backgroundImage: AssetImage('assets/host.jpg'),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                "Harleen Smith",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 4),
              Row(
                children: [
                  Icon(Icons.star, size: 16, color: Colors.orange),
                  SizedBox(width: 4),
                  Text("4.9 (1.4k reviews)"),
                ],
              )
            ],
          )
        ],
      ),
    );
  }

  // Widget _buildBookNowButton(BuildContext context) {
  //   return Padding(
  //     padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
  //     child: ElevatedButton(
  //       onPressed: () {
  //         // Add navigation or booking logic
  //       },
  //       style: ElevatedButton.styleFrom(
  //         backgroundColor: Colors.red,
  //         shape: RoundedRectangleBorder(
  //           borderRadius: BorderRadius.circular(30),
  //         ),
  //         padding: const EdgeInsets.symmetric(vertical: 16),
  //         minimumSize: const Size(double.infinity, 50),
  //       ),
  //       child: const Text(
  //         "Book Now",
  //         style: TextStyle(color: Colors.white, fontSize: 16),
  //       ),
  //     ),
  //   );
  // }
}

class _OfferIcon extends StatelessWidget {
  final IconData icon;
  final String label;

  const _OfferIcon({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 24,
          backgroundColor: Colors.grey.shade200,
          child: Icon(icon, color: Colors.black),
        ),
        const SizedBox(height: 6),
        Text(label, style: const TextStyle(fontSize: 12)),
      ],
    );
  }
}
