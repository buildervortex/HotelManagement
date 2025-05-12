import 'package:flutter/material.dart';
import 'package:hotel_management/Model/hotel_category_model.dart';
import 'package:hotel_management/Model/hotel_model.dart';
import 'package:hotel_management/Views/Widgects/hotel_card.dart';
import 'package:hotel_management/Views/hotel_detail_screen.dart';

void main() {
  runApp(MaterialApp(
    home: SearchHotel(),
  ));
}

class SearchHotel extends StatefulWidget {
  const SearchHotel({super.key});

  @override
  _SearchHotelState createState() => _SearchHotelState();
}

class _SearchHotelState extends State<SearchHotel> {
  final TextEditingController _searchController = TextEditingController();
  List<HotelModel> filteredHotels = hotelModel;
  String selectedCategory = "All"; // Default category selection

  // Function to filter hotels based on category and search query
  void _filterHotels() {
    String query = _searchController.text.toLowerCase();

    setState(() {
      filteredHotels = hotelModel.where((hotel) {
        bool matchesQuery = hotel.name.toLowerCase().contains(query);
        bool matchesCategory = selectedCategory == "All" || hotel.category == selectedCategory;
        return matchesQuery && matchesCategory;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Search")),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 20),
            
            // Search Bar
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  SizedBox(width: 10),
                  Expanded(
                    child: SizedBox(
                      height: 45,
                      child: TextField(
                        controller: _searchController,
                        onChanged: (value) => _filterHotels(),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                          hintText: "Search Hotels",
                          hintStyle: TextStyle(color: Colors.black38),
                          filled: true,
                          fillColor: Colors.grey[200],
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            borderSide: BorderSide(color: Colors.brown),
                          ),
                          prefixIcon: Icon(Icons.search, color: Colors.black38),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 20),

            )
          ],
        ),
      ),
    );
  }
}
