import 'package:discount_page/discounts_screens/hotel_offers_details_page.dart';
import 'package:discount_page/discounts_screens/visit_oceanografic_page.dart';
import 'package:flutter/material.dart';

class OffersDiscountsPage extends StatefulWidget {
  const OffersDiscountsPage({super.key});

  @override
  State<OffersDiscountsPage> createState() => _OffersDiscountsPageState();
}

class _OffersDiscountsPageState extends State<OffersDiscountsPage> {
  bool isSaved = false;  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "OFFERS",
          style: TextStyle(color: Colors.red),
        ),
        backgroundColor: Colors.amberAccent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Can we tempt you?",
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            // Romantic Experience Card
            _buildOfferCard(
              context,
              "Romantic experience",
              "\$580",
              "assets/romantic_experience.jpg",
              () {
                Navigator.pushNamed(context, '/romantic');
              },
            ),

            // Visit Oceanografic Card
            _buildOfferCard(
              context,
              "Visit Oceanografic",
              "From \$58 per person",
              "assets/visit_oceanografic.jpg",
              () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const VisitOceanograficPage()),
                );
              },
            ),

            const SizedBox(height: 20),

            // Hot Deals Title Section
            const Text(
              "Hot Deals",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),

            // Hot Deal Card
            _buildHotDealCard(context),
          ],
        ),
      ),
    );
  }

  Widget _buildOfferCard(BuildContext context, String title, String price, String imagePath, VoidCallback onPressed) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                imagePath,
                width: 120,
                height: 120,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.red)),
                  Text(price, style: const TextStyle(fontSize: 14, color: Colors.black)),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: onPressed,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.lightBlue,
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                    ),
                    child: const Text("VIEW OFFERS"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHotDealCard(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigate to Hotel Offer Detail Page when the card is tapped
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const HotelOfferDetailPage(),
          ),
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        margin: const EdgeInsets.symmetric(vertical: 10),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      'assets/hotel_valencia.jpg', // Replace with your image
                      width: double.infinity,
                      height: 160,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    top: 8,
                    left: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: const Text(
                        '20% OFF',
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          isSaved = !isSaved;
                        });
                      },
                      child: Icon(
                        isSaved ? Icons.favorite : Icons.favorite_border,
                        color: isSaved ? Colors.red : Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: const [
                  Tooltip(
                    message: "Traveler score",
                    child: Icon(Icons.people_alt_rounded, size: 16, color: Colors.blue),
                  ),
                  SizedBox(width: 4),
                  Text('8.7'),
                  Spacer(),
                  Tooltip(
                    message: "User rating (based on reviews)",
                    child: Icon(Icons.star, size: 16, color: Colors.amber),
                  ),
                  SizedBox(width: 4),
                  Text('4.4 (532)'),
                ],
              ),
              const SizedBox(height: 6),
              const Text(
                'Hotel Valencia Center Luxury',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 2),
              Row(
                children: const [
                  Icon(Icons.location_on, size: 16, color: Colors.grey),
                  SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      'Avda Baleares, 2, Valencia , 46023, Spain',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              const Align(
                alignment: Alignment.bottomRight,
                child: Text(
                  '\$580 / night',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
