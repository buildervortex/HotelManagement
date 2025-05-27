import 'package:flutter/material.dart';

class VisitOceanograficPage extends StatelessWidget {
  const VisitOceanograficPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(120),
        child: AppBar(
          title: const Text(
            "Visit Oceanografic",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 25,
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          flexibleSpace: Stack(
            fit: StackFit.expand,
            children: [
              Image.asset(
                'assets/visit_oceanografic.jpg',
                fit: BoxFit.cover,
              ),
              Container(
                color: Colors.black.withOpacity(0.5),
              ),
            ],
          ),
          iconTheme: const IconThemeData(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(
                'assets/visit_oceanografic1.jpg',
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              "Eurostars Gran Valencia",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              "\$58",
              style: TextStyle(color: Colors.orange, fontSize: 16),
            ),
            const Text(
              "Visit Oceanografic",
              style: TextStyle(
                color: Colors.deepOrange,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              "Visit the largest marine park in Europe, where you can go on a thrilling trip through the most important marine ecosystems on the planet. Beluga whales, dolphins, sharks and penguins are waiting to show you the secrets of the sea.\n\n*The price may change depending on the season.",
              style: TextStyle(fontSize: 14),
            ),
            const Divider(height: 40),
            Center(
              child: TextButton.icon(
                onPressed: () {
                  // Navigator.push(context, MaterialPageRoute(builder: (_) => PromotionsPage()));
                },
                icon: const Icon(Icons.arrow_forward),
                label: const Text("SEE ALL PROMOTIONS"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
