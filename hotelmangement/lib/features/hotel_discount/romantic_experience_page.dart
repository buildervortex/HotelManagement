import 'package:flutter/material.dart';

class RomanticExperiencePage extends StatelessWidget {
  const RomanticExperiencePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: PreferredSize(
        preferredSize: const Size.fromHeight(120),
        child: AppBar(
          title: const Text(
            "Romantic Experience",
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
                'assets/appbar.jpg',
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
                'assets/Eurostars_Gran_Valencia.jpg',
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
              "\$580",
              style: TextStyle(color: Colors.orange, fontSize: 16),
            ),
            const Text(
              "Romantic experience",
              style: TextStyle(color: Colors.deepOrange, fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            const Text(
              "Eurostars Gran Valencia Hotel features a 24 hour front desk, a rooftop terrace, and a concierge. In addition, as a valued Eurostars Gran Valencia Hotel guest, you can enjoy a pool and a poolside bar that are available on-site. Guests arriving by vehicle have access to parking.\n\n",
              style: TextStyle(fontSize: 14),
            ),
            const Text(
              "Live an unforgettable romantic night full of details at the Exe Rey Don Jaime. We have everything you need for an evening full of magic.\n\nIncludes:\n- Welcome gift.\n- A bottle of cava.\n- Chocolates.",
              style: TextStyle(fontSize: 14),
            ),
            const Divider(height: 40),
            const Text(
              "Our customers have also been interested in:",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            _buildRelatedOfferCard(context),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildRelatedOfferCard(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                'assets/visit_oceanografic.jpg',
                width: 80,
                height: 80,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Visit Oceanografic",
                    style: TextStyle(color: Colors.red, fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const Text(
                    "From \$58 per person",
                    style: TextStyle(color: Colors.black),
                  ),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/oceanographic');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.lightBlue,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                    ),
                    child: const Text("VIEW OFFERS"),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
