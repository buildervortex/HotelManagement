import 'package:flutter/material.dart';

class AvailableFoodPage extends StatelessWidget {
  const AvailableFoodPage({super.key});

  final List<String> foodItems = const [
    "Rice & Curry",
    "Chicken Fried Rice",
    "Vegetable Noodles",
    "Mushroom Soup",
    "Grilled Fish",
    "Ice Cream",
    "Fruit Salad",
    "Pasta",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Available Food"),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: foodItems.length,
        itemBuilder: (context, index) {
          return Card(
            elevation: 2,
            margin: const EdgeInsets.symmetric(vertical: 8),
            child: ListTile(
              leading: const Icon(Icons.restaurant_menu, color: Colors.brown),
              title: Text(
                foodItems[index],
                style: const TextStyle(fontSize: 16),
              ),
            ),
          );
        },
      ),
    );
  }
}
