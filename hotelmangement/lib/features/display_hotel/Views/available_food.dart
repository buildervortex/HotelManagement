import 'package:flutter/material.dart';

class AvailableFoodPage extends StatelessWidget {
  const AvailableFoodPage({super.key});

  final List<Map<String, String>> foodItems = const [
    {
      "main": "Rice & Curry",
      "side": "Papadam & Coconut Sambol",
    },
    {
      "main": "Chicken Fried Rice",
      "side": "Chili Paste & Salad",
    },
    {
      "main": "Vegetable Noodles",
      "side": "Spring Rolls",
    },
    {
      "main": "Mushroom Soup",
      "side": "Garlic Bread",
    },
    {
      "main": "Grilled Fish",
      "side": "Lemon Wedges & Steamed Veggies",
    },
    {
      "main": "Ice Cream",
      "side": "Chocolate Syrup & Wafers",
    },
    {
      "main": "Fruit Salad",
      "side": "Yogurt & Honey",
    },
    {
      "main": "Pasta",
      "side": "Parmesan Cheese & Breadsticks",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text("Available Food"),
        centerTitle: true,
        backgroundColor: Colors.brown,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
        itemCount: foodItems.length,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.symmetric(vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade300,
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.all(16),
              leading: CircleAvatar(
                backgroundColor: Colors.brown.shade100,
                child: const Icon(Icons.restaurant_menu, color: Colors.brown),
              ),
              title: Text(
                foodItems[index]["main"]!,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
              subtitle: Text(
                foodItems[index]["side"]!,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[700],
                ),
              ),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            ),
          );
        },
      ),
    );
  }
}
