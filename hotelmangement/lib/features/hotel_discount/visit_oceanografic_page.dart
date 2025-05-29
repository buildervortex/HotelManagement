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
            const SizedBox(height: 12),
            const Text(
              "\$58",
              style: TextStyle(color: Colors.orange, fontSize: 16),
            ),
            const Text(
              "A hotel of high standards for a city flying high. A newly created, 24 floors building to house the Eurostars Gran Valencia Hotel. The hotel is set in one of the most prosperous areas that is in full expansion, close to the two most important focal points of the Benicalap district: the Congress Hall and the Nou Mestalla football stadium which, with capacity for up to 75,000 spectators, will in the near future become the most modern stadium in Spain.\n \nThe Eurostars Gran Valencia is the ideal accommodation for business clients, with easy access from and to the motorways, proximity to the city’s major industrial areas: (Fuente del Jarro, Paterna, Geminis Centre, Sorolla Centre, etc.), Wi-Fi connection, spacious meeting rooms with all the necessary technology and excellent leisure facilities such as a large outdoor swimming pool.\n The hotel is also a wise choice for the tourists that wishe to discover the new attractions of Valencia. The warm, pleasant design of our rooms and public areas seeks to make you feel at home. The lobby bar, situated on the 14th floor, is an excellent place for couples to enjoy the incomparable vistas from the terrace. The Arnadi restaurant offers creative, Mediterranean cuisine, always prepared with locally grown produce of optimum quality and following the latest culinary trends.\n \nThe metro and bus network (with a stop 50 metres away from the hotel) will allow you to place yourself in the heart of the historical city centre (3,5km away), in the City of the Arts and Sciences (6kms), in the port (9 kms) or the city beaches: la Malvarrosa, Las Arenas or El Saler.",
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 8),
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
          ],
        ),
      ),
    );
  }
}
